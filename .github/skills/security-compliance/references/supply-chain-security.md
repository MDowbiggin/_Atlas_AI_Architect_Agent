# Supply Chain Security

## Overview

Supply chain attacks target the components, tooling, and processes used to build and deploy software rather than targeting the end system directly. For EMIS/Optum, supply chain risk spans: container base images, open-source dependencies, IaC modules, third-party vendor software, and the CI/CD pipeline itself.

This reference covers EMIS/Optum's supply chain security controls aligned to ISO 27001 A.5.19–A.5.22, NIST SP 800-161, and SLSA (Supply-chain Levels for Software Artifacts).

---

## Supply Chain Threat Model

| Threat | Example | Control |
|--------|---------|---------|
| Compromised dependency | Malicious npm/pip package injected into build | Dependency scanning; SBOM; private registry mirror |
| Trojanised base image | Docker Hub image with backdoor | Approved registry only; image signing; CVE scanning |
| Pipeline compromise | Attacker injects code via compromised build agent | OIDC credentials; least-privilege pipeline; signed commits |
| Vendor software backdoor | Third-party software with persistent access | Vendor security assessment; penetration testing requirement |
| Dependency confusion | Internal package name hijacked via public registry | Private registry with upstream proxying; package namespace control |
| IaC module tampering | Terraform module from uncontrolled source | Module pinned by version/hash; internal registry preferred |

---

## Software Bill of Materials (SBOM)

An SBOM is a machine-readable inventory of all components in a software artefact (container image, service, or application).

### When an SBOM Is Required

- All new containerised workloads deployed to production
- Any workload handling PHI/Confidential data
- Workloads using third-party vendor-supplied container images
- Before procurement or adoption of new platform tooling

### SBOM Standards

| Standard | Use Case |
|----------|---------|
| **SPDX** (ISO/IEC 5962:2021) | Preferred for container and application SBOMs |
| **CycloneDX** | Alternative; well-supported in Trivy and Grype |

### SBOM Generation Tooling

| Tool | Generates | Integration |
|------|-----------|-------------|
| **Trivy** | SPDX/CycloneDX for container images and filesystems | CI/CD pipeline (ADO / GitHub Actions) |
| **Syft** | SPDX/CycloneDX for container images | CI/CD pipeline |
| **Grype** | CVE scanning against SBOM | CI/CD pipeline; pairs with Syft |

### SBOM Storage and Retention

- SBOMs are stored in the container registry (ECR / ACR) as an OCI artefact attached to the image
- SBOMs for compliance-relevant workloads are retained for the lifetime of the workload + 1 year
- SBOMs are reviewed on each image rebuild and on publication of a HIGH/CRITICAL CVE affecting a known component

---

## Container Image Security

### Approved Image Sources

| Registry | Status | Notes |
|----------|--------|-------|
| Amazon ECR (private) | ✅ Approved | Primary for AWS workloads; scanner enabled |
| Azure Container Registry (private) | ✅ Approved | Primary for Azure workloads; Defender for Containers enabled |
| Microsoft Artifact Registry (MCR) | ✅ Approved | Official Microsoft base images |
| AWS ECR Public Gallery | ⚠️ Approved with review | Verify publisher; pin by digest not tag |
| Docker Hub | ⚠️ Approved for official images with review | Official images only; pinned by digest; pull through ECR/ACR |
| Unknown / unverified registries | ❌ Not permitted | Raise security exception if unavoidable |

### Image Hardening Requirements

1. Use minimal base images (distroless, UBI minimal, or Alpine) — reduce attack surface
2. Pin images by digest (`@sha256:...`), not tag — tags are mutable
3. Run as non-root user (UID ≥ 1000); declare `USER` in Dockerfile
4. No secrets, credentials, or SSH keys in image layers — use Key Vault / Secrets Manager CSI driver at runtime
5. Remove unnecessary tools from production images (curl, wget, bash where not required)
6. Rebuild images on publication of upstream CVEs — do not rely solely on scheduled scans

### Image Scanning Policy

| Severity | Action |
|----------|--------|
| CRITICAL | Block pipeline deployment; raise security incident; patch within 48 hours |
| HIGH | Block pipeline deployment; patch within 14 days; exception required to proceed |
| MEDIUM | Log and track; patch within 30 days |
| LOW | Log; review at next scheduled rebuild |

### Image Signing

All production images must be signed:

| Platform | Signing Tool | Verification |
|----------|-------------|-------------|
| AWS ECR | Cosign (sigstore) | AWS Signer + OPA admission policy |
| Azure ACR | Notation (CNCF) | Ratify admission controller on AKS |

---

## Dependency Management

### Open Source Dependency Scanning

All repositories must have dependency scanning enabled:

| Tool | Platform | Language Coverage |
|------|----------|------------------|
| **Dependabot** | GitHub / ADO | Most languages; auto-raises PRs for vulnerable dependencies |
| **pip-audit** | Python projects | PyPI packages |
| **npm audit** | Node.js | npm packages |
| **Trivy (filesystem)** | All | Multi-language in CI/CD pipeline |

### Dependency Security Rules

- [ ] All dependencies pinned to specific versions (no `latest`, no `>=` ranges without cap in production)
- [ ] Dependabot or equivalent enabled on all active repositories
- [ ] `CRITICAL` or `HIGH` CVEs in direct dependencies block merge to main
- [ ] Transitive dependency CVEs tracked; patch plan required within 30 days for HIGH
- [ ] Internal packages use private package feeds (Azure Artifacts / AWS CodeArtifact) to prevent dependency confusion
- [ ] Third-party packages verified against known-good sources (checksums / hash pinning)

### Dependency Confusion Prevention

Dependency confusion occurs when a public package name matches an internal private package name, causing the build system to pull the public (potentially malicious) version.

**Mitigations:**
1. All internal package feeds are upstream-proxied (pull from public registries through ECR/ACR/Artifacts with scope filtering)
2. Internal package namespaces are registered publicly (even if empty) to prevent squatting
3. Package managers are configured to prefer internal feeds (`--prefer-dist` / registry ordering)

---

## IaC Module and Third-Party Code Security

### Terraform Modules

| Control | Requirement |
|---------|-------------|
| Source | Use internal Terraform registry or version-pinned public registry modules by the official HashiCorp partner |
| Pinning | Pin all modules to a specific version tag + source hash; do not use `latest` or branch references |
| Review | All new external modules require security review before adoption |
| Scanning | `tfsec`, `checkov`, and `terrascan` run in CI/CD; see [Secure IaC Pipeline Standards](./secure-iac-pipeline.md) |

### Bicep / ARM Modules

- Use Azure Verified Modules (AVM) from the official Microsoft registry where available
- Pin template versions; do not use unversioned `main` branch references
- Scan with `PSArm` or `arm-ttk` (ARM) / Bicep linter with custom rules

---

## Vendor and Third-Party Software Security

### Vendor Security Assessment

Before adopting new third-party software or services:

| Step | Requirement |
|------|-------------|
| Security questionnaire | Complete EMIS/Optum vendor security questionnaire or review vendor's SOC 2 Type II / ISO 27001 certificate |
| Penetration test | Request evidence of annual penetration testing for critical/production integrations |
| Data processing | Confirm Data Processing Agreement (DPA) if vendor handles personal data |
| BAA | Confirm Business Associate Agreement if vendor handles PHI |
| Vulnerability disclosure | Confirm vendor has a documented vulnerability disclosure and patching policy |
| Incident notification | Confirm contract includes security incident notification SLA (EMIS/Optum standard: 24 hours for critical incidents) |

### Approved Vendor List

Maintain an approved vendor list in Confluence. New vendors require security sign-off from ESRO before production use.

| Vendor | Status | Last Reviewed | Notes |
|--------|--------|--------------|-------|
| Amazon Web Services | ✅ Approved | Ongoing | BAA in place; AWS Organizations SCPs applied |
| Microsoft Azure | ✅ Approved | Ongoing | BAA in place; EA in place |
| CrowdStrike | ✅ Approved | [Date] | SOC 2 Type II certified |
| Tenable | ✅ Approved | [Date] | ISO 27001 certified |
| Delinea | ✅ Approved | [Date] | SOC 2 Type II certified |
| Dynatrace | ✅ Approved | [Date] | ISO 27001; SOC 2 Type II |
| Darktrace | ✅ Approved | [Date] | ISO 27001 certified |
| New vendor | ⚠️ Pending | | Security assessment required before production use |

---

## Supply Chain Security Checklist

Use when onboarding a new workload, vendor, or significant dependency:

### For New Containerised Workloads
- [ ] Base image from approved registry; pinned by digest
- [ ] Image scanned for CVEs; no CRITICAL/HIGH unmitigated
- [ ] SBOM generated and stored in registry
- [ ] Image signed (Cosign/Notation)
- [ ] Admission policy validates image signature before deployment
- [ ] Runs as non-root; no unnecessary tools in image

### For New Open Source Dependencies
- [ ] Package from trusted source; version pinned
- [ ] Dependabot / equivalent scanning enabled
- [ ] No known HIGH/CRITICAL CVEs at adoption
- [ ] Licence compatible with EMIS/Optum licence policy (MIT, Apache 2.0, BSD preferred; GPL requires legal review)

### For New Vendors / Third-Party Software
- [ ] Vendor security questionnaire completed or SOC 2/ISO 27001 certificate reviewed
- [ ] DPA signed (where applicable)
- [ ] BAA signed (where PHI involved)
- [ ] Penetration test evidence received
- [ ] Incident notification clause in contract
- [ ] Added to approved vendor list in Confluence

### For New IaC Modules
- [ ] Module from internal registry or official/verified source
- [ ] Version pinned; source hash verified
- [ ] Security review completed before adoption
- [ ] IaC scanner passes on module usage

---

## Key References

| Reference | Link |
|-----------|------|
| NIST SP 800-161r1 (C-SCRM) | https://csrc.nist.gov/publications/detail/sp/800-161/rev-1/final |
| SLSA Framework | https://slsa.dev/ |
| CISA Software Supply Chain Security Guidance | https://www.cisa.gov/resources-tools/resources/software-supply-chain-security-guidance |
| Google Open Source Security Score (OpenSSF Scorecard) | https://securityscorecards.dev/ |
| Trivy docs | https://trivy.dev/ |
| Cosign (image signing) | https://docs.sigstore.dev/cosign/overview/ |
