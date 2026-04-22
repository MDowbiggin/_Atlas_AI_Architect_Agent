---
name: security-compliance
description: "Security and compliance baselines for EMIS/Optum infrastructure. Use when: validating designs against HIPAA, NIST, CIS Level 2, ISO 27001, Cyber Essentials Plus, or Zero Trust principles; checking security controls; hardening infrastructure; encryption requirements; access control design; audit logging; IaC pipeline security; supply chain/SBOM checks; AI/LLM workload security; or conducting security reviews."
---

# Security & Compliance Baselines

## When to Use

- Validating an infrastructure design against compliance requirements
- Checking whether a specific security control is required for a workload
- Designing access control, encryption, network security, or audit logging
- Conducting a security review of an existing or proposed architecture
- Responding to a compliance audit or gap analysis
- Hardening servers, containers, or cloud services
- Assessing a design for Zero Trust alignment
- Reviewing IaC pipelines for secrets scanning, policy-as-code, and supply chain integrity
- Checking security controls for AI/LLM workloads (prompt injection, data isolation, model access control)
- Validating that a design meets Cyber Essentials Plus requirements
- Documenting or reviewing a security exception or derogation from an approved baseline
- Validating third-party / vendor supply chain security requirements (SBOMs, dependency scanning)

## Applicable Frameworks

EMIS/Optum infrastructure must comply with ALL of the following:

| Framework | Scope | Reference |
|-----------|-------|-----------|
| **HIPAA** | All systems that process, store, or transmit PHI | [HIPAA Baseline](./references/hipaa-baseline.md) |
| **NIST Cybersecurity Framework** | Organisation-wide security posture | [NIST Baseline](./references/nist-baseline.md) |
| **CIS Level 2** | OS, cloud, and network hardening benchmarks | [CIS Level 2 Baseline](./references/cis-level2-baseline.md) |
| **ISO 27001** | Information Security Management System (ISMS) | [ISO 27001 Baseline](./references/iso27001-baseline.md) |
| **Cyber Essentials Plus** | UK Government-backed cyber hygiene certification | [NHS Clinical Compliance](../architecture/references/nhs-clinical-compliance.md) |
| **Zero Trust** | Identity, device, and network trust model | [Zero Trust Assessment](./references/zero-trust-assessment.md) |

## Security Principles

1. **Secure by Design** — Security is designed into solutions from the outset, not added as an afterthought; every HLD must include a security section and the Quick Compliance Check must pass before design review is complete
2. **Zero Trust** — Never trust implicitly; verify explicitly for every identity, device, and network request; assume breach as a default operating posture; apply least-privilege everywhere
3. **Least Privilege** — Every identity (human or non-human) receives only the minimum permissions required to perform its function; privileges are reviewed quarterly and reduced when no longer needed
4. **Defence in Depth** — No single control is sufficient; layer security controls across identity, network, endpoint, data, and application so that a failure in one layer does not result in a breach
5. **Encrypt Everything** — All data is encrypted at rest (AES-256 minimum) and in transit (TLS 1.2+ minimum); encryption keys are managed via approved key management services (Azure Key Vault / AWS KMS); no plaintext secrets anywhere
6. **Audit and Detect** — All access to sensitive systems and data is logged; logs are retained per compliance requirements; anomalous activity triggers automated alerts; security monitoring is a design requirement, not an optional add-on
7. **Immutable Infrastructure** — Systems are rebuilt rather than patched in place where possible; IaC ensures consistent, auditable configuration; drift is detected and remediated automatically
8. **Supply Chain Awareness** — Third-party components, container images, and IaC modules are from trusted sources; dependency scanning and SBOM generation are part of the build pipeline; vendor security posture is assessed before adoption
9. **Fail Safe** — On failure, systems default to a denied/closed state; no configuration should allow unauthorised access in an error condition; rollback procedures restore known-good secure state
10. **Proportionate Controls** — Security controls are proportionate to the data classification and risk level of the workload; every control must be justified against a threat; over-engineering and security theatre are equally to be avoided

## Quick Compliance Check

When reviewing a design, validate against these mandatory controls:

### Data Protection
- [ ] Data classified (Public, Internal, Confidential, Restricted)
- [ ] Encryption at rest (AES-256 minimum)
- [ ] Encryption in transit (TLS 1.2+ minimum; TLS 1.3 preferred for new builds)
- [ ] Key management via Azure Key Vault or AWS KMS
- [ ] No PHI/PII in logs, comments, or unencrypted storage
- [ ] Secrets NOT hardcoded in IaC, environment variables, or application config — managed via Key Vault / Secrets Manager

### Access Control
- [ ] Least-privilege RBAC applied
- [ ] MFA enforced for all administrative access
- [ ] Privileged access via PIM / just-in-time (not standing admin rights)
- [ ] Service accounts use managed identities (Azure) or IAM roles/instance profiles (AWS) — no long-lived passwords or access keys in code
- [ ] IRSA (IAM Roles for Service Accounts) used for EKS pods (AWS)
- [ ] Access reviews scheduled (quarterly minimum)
- [ ] Zero Trust controls assessed — see [Zero Trust Assessment](./references/zero-trust-assessment.md)

### Network Security
- [ ] Network segmentation (VNet/VPC, subnets, NSGs/Security Groups)
- [ ] No public endpoints without WAF/DDoS protection
- [ ] Private endpoints for PaaS services (Azure) / VPC endpoints for AWS services
- [ ] Firewall rules follow deny-all default
- [ ] Azure Bastion (Azure) or AWS Systems Manager Session Manager (AWS) for admin access — no public RDP/SSH
- [ ] East-west traffic between subnets restricted via NSGs/Security Groups (not just perimeter controls)

### Logging & Monitoring
- [ ] Audit logging enabled for all components
- [ ] Logs forwarded to centralised SIEM (Sentinel/Log Analytics for Azure; CloudWatch + Security Hub for AWS)
- [ ] Minimum 90-day log retention (365 days for compliance; 6 years for HIPAA audit logs)
- [ ] Security alerting configured (Defender for Cloud for Azure; GuardDuty + Security Hub for AWS)
- [ ] Dynatrace security analytics enabled
- [ ] Immutable log storage for compliance-relevant audit trails (WORM / Object Lock)

### Patch Management
- [ ] Automated OS patching (Azure Update Management for Azure / AWS Systems Manager Patch Manager for AWS)
- [ ] Application patching per vendor schedule
- [ ] Critical patches applied within 14 days; high within 30 days
- [ ] Patch compliance reported monthly (via Azure Update Manager or AWS Config conformance pack)
- [ ] Container base images rebuilt on upstream CVE publication; image scanning in CI/CD pipeline

### Incident Response
- [ ] Incident response procedure documented
- [ ] Security incidents escalated via ServiceNow P1/P2 process
- [ ] Post-incident review process defined
- [ ] Breach notification procedure aligned with HIPAA requirements

### IaC & Pipeline Security
- [ ] IaC scanned for misconfigurations (tfsec / checkov / Trivy for Terraform/Bicep)
- [ ] Container images scanned for CVEs before push to registry
- [ ] SBOM generated for containerised workloads
- [ ] No secrets in version control — pre-commit hooks and pipeline secret scanning enforced
- [ ] IaC pipeline uses least-privilege service principal / OIDC (not long-lived credentials)
- [ ] See [Secure IaC Pipeline Standards](./references/secure-iac-pipeline.md)

### AI / LLM Workloads (if applicable)
- [ ] Prompt injection mitigations in place (input validation, output filtering, content safety)
- [ ] PHI/PII data NOT passed to external LLM APIs unless a BAA/DPA is in place
- [ ] Model access controlled via IAM/RBAC — no open API endpoints
- [ ] AI agent tool permissions scoped to read-only where possible; write actions require explicit approval
- [ ] Audit logging for all LLM interactions that involve sensitive data

## Procedure

### For Design Validation

1. Identify which data classifications the design handles (focus on Confidential/Restricted)
2. Run through the Quick Compliance Check above
3. For each framework, load the relevant reference file and validate specific controls
4. Document any gaps in the design review findings
5. Recommend remediation actions with priority and effort estimate

### For Security Review

1. Map the architecture components to the relevant compliance scope
2. Assess each component against CIS Level 2 hardening benchmarks
3. Validate network security against NIST and ISO 27001 controls
4. Check HIPAA-specific requirements for any PHI-handling components
5. Produce a Security Review Report with findings, risk ratings, and remediation plan

### For Zero Trust Assessment

1. Load [Zero Trust Assessment](./references/zero-trust-assessment.md)
2. Evaluate the design against the six Zero Trust pillars (Identity, Device, Network, Application, Data, Visibility)
3. Score each pillar against the maturity model (Traditional → Advanced → Optimal)
4. Document the current vs. target state per pillar
5. Produce a prioritised remediation plan; include in ADR if a significant design change is required

### For IaC / Pipeline Security Review

1. Load [Secure IaC Pipeline Standards](./references/secure-iac-pipeline.md)
2. Validate that scanning tools (tfsec/checkov/Trivy) are present in the pipeline
3. Confirm no secrets are passing through the pipeline without Key Vault / Secrets Manager
4. Verify the service principal used by the pipeline has least-privilege permissions and uses OIDC (not long-lived credentials)
5. Confirm SBOM generation is in place for containerised workloads
6. Document findings; any HIGH/CRITICAL pipeline security gaps block deployment

### For Supply Chain Security Assessment

1. Load [Supply Chain Security](./references/supply-chain-security.md)
2. Review all third-party dependencies and container base images for known CVEs
3. Confirm all images originate from trusted registries (ECR/ACR with image signing)
4. Validate that SBOM is generated and reviewed for new workloads
5. Check that Dependabot or equivalent is enabled in all ADO/GitHub repos
6. For vendor software: confirm security posture assessment has been completed

## References

- [HIPAA Baseline](./references/hipaa-baseline.md) — PHI handling, safeguards, breach notification, AWS HIPAA-eligible services
- [NIST Baseline](./references/nist-baseline.md) — CSF categories, control families, NIST SP 800-53 mapping
- [CIS Level 2 Baseline](./references/cis-level2-baseline.md) — Hardening benchmarks for OS, cloud, containers, network
- [ISO 27001 Baseline](./references/iso27001-baseline.md) — ISMS controls, Annex A mapping, SoA template
- [Zero Trust Assessment](./references/zero-trust-assessment.md) — Six-pillar Zero Trust maturity model and EMIS/Optum assessment template
- [Supply Chain Security](./references/supply-chain-security.md) — SBOM, dependency scanning, image signing, vendor security posture
- [Secure IaC Pipeline Standards](./references/secure-iac-pipeline.md) — Pipeline secret scanning, policy-as-code, OIDC credentials, IaC security tooling
