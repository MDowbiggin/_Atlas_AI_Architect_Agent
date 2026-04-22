# Secure IaC Pipeline Standards

## Overview

Infrastructure as Code (IaC) pipelines are a critical attack surface. A compromised pipeline can provision infrastructure, exfiltrate secrets, or deploy malicious configurations at scale. These standards ensure that EMIS/Optum IaC pipelines (Azure DevOps, GitHub Actions) meet security-by-default requirements.

Applies to: Terraform, Bicep, Ansible, Helm, and any other IaC tooling used in PIMS and Architecture delivery.

---

## Pipeline Security Principles

1. **Least-privilege service identity** — The pipeline's identity (service principal or OIDC-federated identity) is granted only the permissions required for the specific pipeline's scope; no Contributor/Owner at subscription root unless absolutely required and ARB-approved
2. **No long-lived credentials** — Service principals with client secrets are deprecated; all new pipelines use OIDC Workload Identity Federation (Azure) or OIDC-based IAM roles (AWS); no credentials stored as pipeline variables or committed to repos
3. **Scan before apply** — All IaC code is scanned for security misconfigurations before `plan` or `apply`; HIGH/CRITICAL findings block the pipeline
4. **Secret detection** — Every commit and pipeline run is scanned for secrets (API keys, passwords, connection strings); detected secrets fail the pipeline and trigger an incident
5. **Protected branches** — All IaC repositories have branch protection on `main`/`production`; direct pushes forbidden; all changes via PR with peer review
6. **Immutable artefacts** — Infrastructure plans (Terraform plan files) are stored as signed artefacts; the `apply` stage deploys the exact reviewed plan — no re-planning at apply time
7. **Audit trail** — Every pipeline run is logged with who triggered it, what changed, and the outcome; logs are retained for 1 year minimum

---

## Identity and Credential Standards

### Azure DevOps — Service Connections

| Standard | Requirement |
|----------|-------------|
| Authentication method | Workload Identity Federation (OIDC) — not service principal with secret |
| Scope | Subscriptions or resource groups — not management group root unless reviewed |
| Permissions | Contributor on target resource group(s); Reader at subscription level; no Owner |
| Service connection approval | All service connections approved by CloudOps lead before use in production pipelines |
| Automated credential rotation | Not applicable for OIDC; for legacy secret-based SPs, rotate every 90 days |

### GitHub Actions

| Standard | Requirement |
|----------|-------------|
| Authentication method | OIDC via `azure/login` action with Federated Credential; `aws-actions/configure-aws-credentials` with OIDC |
| Permissions block | Every workflow must declare a `permissions` block at the workflow or job level; default to `read-all`; add specific write permissions only where needed |
| Secrets | Use GitHub Environments with environment protection rules for production secrets; do not store secrets as repo-level plaintext variables |
| Third-party actions | Pin all third-party actions by SHA hash (`uses: actions/checkout@abc1234`) not by tag; review before adoption; use Dependabot for action version updates |

### Secret Management in Pipelines

| Scenario | Approved Method |
|----------|----------------|
| Azure connection strings / keys | Azure Key Vault reference in Azure DevOps variable groups; resolved at runtime |
| AWS credentials (for non-pipeline use) | AWS Secrets Manager; referenced via SSM Parameter Store in pipeline |
| Database credentials in pipelines | Managed Identity / IRSA for pipeline agent access; credentials never stored as pipeline variables |
| Certificate private keys | Azure Key Vault Certificate object; exported as task reference — never stored in pipeline variables or code |
| **Prohibited** | Hardcoded credentials in YAML, Terraform, Ansible playbooks, or code; credentials in `.env` files committed to repos |

---

## IaC Security Scanning

### Scanning Tools by IaC Type

| IaC Type | Primary Scanner | Secondary Scanner | Policy-as-Code |
|----------|----------------|-------------------|----------------|
| **Terraform (Azure)** | `tfsec` | `checkov` | Open Policy Agent (OPA) / Azure Policy |
| **Terraform (AWS)** | `tfsec` | `checkov` | OPA / AWS Config conformance packs |
| **Bicep / ARM** | `PSArm` linter | `arm-ttk` + Bicep linter | Azure Policy |
| **Helm Charts** | `kubesec` | `trivy config` | OPA Gatekeeper / Kyverno |
| **Ansible** | `ansible-lint` | `kics` | N/A |
| **Dockerfiles** | `hadolint` | `trivy config` | OPA/Kyverno admission |

### Severity Gate Policy

| Severity | Pipeline Action |
|----------|----------------|
| **CRITICAL** | Hard fail — pipeline blocked; security incident raised if in existing running infrastructure |
| **HIGH** | Hard fail — pipeline blocked; exception required to proceed (see [Exception/Derogation Template](../../decision-making/references/exception-derogation-template.md)) |
| **MEDIUM** | Soft fail — warning logged; must be remediated within 30 days or exception raised |
| **LOW / INFO** | Logged — tracked; no immediate action required |

### Running Scanners in ADO Pipelines

```yaml
# tfsec — Terraform security scanner
- task: CmdLine@2
  displayName: 'Run tfsec'
  inputs:
    script: |
      docker run --rm \
        -v $(System.DefaultWorkingDirectory):/src \
        aquasec/tfsec /src \
        --format json \
        --out tfsec-report.json \
        --minimum-severity HIGH
      if [ $? -ne 0 ]; then echo "##vso[task.complete result=Failed;]tfsec found high/critical issues"; fi

# checkov — multi-framework IaC scanner
- task: CmdLine@2
  displayName: 'Run checkov'
  inputs:
    script: |
      pip install checkov
      checkov -d . \
        --framework terraform \
        --output junitxml \
        --output-file-path checkov-report.xml \
        --compact \
        --hard-fail-on HIGH,CRITICAL
```

### Running Scanners in GitHub Actions

```yaml
- name: tfsec
  uses: aquasecurity/tfsec-action@v1.0.3  # pin by version/SHA in practice
  with:
    minimum_severity: HIGH
    format: sarif
    soft_fail: false

- name: checkov
  uses: bridgecrewio/checkov-action@v12  # pin by SHA in practice
  with:
    directory: .
    framework: terraform
    hard_fail_on: CRITICAL,HIGH
    output_format: sarif
    output_file_path: checkov.sarif
```

---

## Secret Detection in Pipelines

### Pre-Commit Hooks (Developer Workstations)

Install `pre-commit` with `detect-secrets` or `gitleaks`:

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
        args: ['--baseline', '.secrets.baseline']
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0
    hooks:
      - id: gitleaks
```

### Pipeline Secret Scanning (ADO)

```yaml
- task: CmdLine@2
  displayName: 'Gitleaks secret scan'
  inputs:
    script: |
      docker run --rm \
        -v $(System.DefaultWorkingDirectory):/path \
        zricethezav/gitleaks:latest detect \
        --source /path \
        --report-format json \
        --report-path gitleaks-report.json \
        --exit-code 1
```

### If a Secret Is Detected

1. **Fail immediately** — the pipeline must not continue; no IaC is deployed
2. **Rotate the exposed credential immediately** — treat as compromised; rotate in Key Vault / Secrets Manager / IAM
3. **Purge from git history** — use `git filter-repo` or `BFG Repo Cleaner`; notify Security (ESRO) if the repo was public or had broad internal access
4. **Raise a security incident** in ServiceNow
5. **Review root cause** — add missing pre-commit hook or update scanning configuration to detect this pattern

---

## Pipeline Branch Protection

### Azure DevOps

```
Branch: main / production
- [ ] Require pull request before merging
- [ ] Require at least 1 reviewer (minimum; 2 for production IaC)
- [ ] Require at least 1 passing build (CI pipeline including security scans)
- [ ] Do not allow bypassing the above settings (for non-admins)
- [ ] Lock branch (enable status checks)
```

### GitHub

```
Branch: main / production
- [ ] Require pull request reviews before merging (2 required for production)
- [ ] Require status checks to pass before merging (tfsec, checkov, secret scan)
- [ ] Require branches to be up to date before merging
- [ ] Restrict who can push to matching branches (named team only)
- [ ] Do not allow force pushes
- [ ] Require signed commits (where toolchain supports it)
```

---

## Terraform State Security

Terraform state files can contain sensitive data (resource IDs, connection strings, rendered secrets). State must be secured:

| Requirement | Azure | AWS |
|-------------|-------|-----|
| Remote state backend | Azure Blob Storage (private, encryption at rest) | S3 (private, SSE-KMS CMK, versioning enabled) |
| State locking | Azure Blob lease | DynamoDB table |
| Access control | Managed identity for pipeline; RBAC: Storage Blob Data Contributor for pipeline MI only | IAM role for pipeline; S3 bucket policy: deny to principal not in approved role list |
| Encryption | Storage Account encryption (CMK for Confidential/Restricted infrastructure) | SSE-KMS with CMK |
| No local state in production | `terraform.tfstate` in `.gitignore`; CI enforced | Same |
| State inspection | `terraform show -json` and `terraform state list` require explicit pipeline step — not run ad-hoc | Same |

---

## Pipeline Security Checklist

Before a new IaC pipeline is promoted to production:

- [ ] Service connection / OIDC identity uses least-privilege permissions (no Owner/root)
- [ ] OIDC Workload Identity Federation used (no long-lived client secret)
- [ ] No credentials hardcoded in YAML pipeline files, Terraform variables, or Ansible playbooks
- [ ] `tfsec` or equivalent IaC scanner runs before `terraform plan`; HIGH/CRITICAL blocks pipeline
- [ ] `checkov` or equivalent runs as a second scanner; failures block pipeline
- [ ] Secret scanning (gitleaks or detect-secrets) runs on every commit/PR
- [ ] Pre-commit hooks installed on all contributor workstations
- [ ] Branch protection enforced: PRs required; minimum 1 reviewer; CI must pass
- [ ] Terraform state in secure remote backend (Azure Blob / S3) with CMK and state locking
- [ ] Pipeline run logs retained for minimum 12 months
- [ ] SBOM generation included for containerised workloads built by the pipeline
- [ ] Pipeline reviewed by CloudOps / Platforms team before first production run
