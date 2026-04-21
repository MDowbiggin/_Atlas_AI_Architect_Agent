---
name: security-compliance
description: "Security and compliance baselines for EMIS/Optum infrastructure. Use when: validating designs against HIPAA, NIST, CIS Level 2, ISO 27001, checking security controls, hardening infrastructure, encryption requirements, access control design, audit logging, or conducting security reviews."
---

# Security & Compliance Baselines

## When to Use

- Validating an infrastructure design against compliance requirements
- Checking whether a specific security control is required for a workload
- Designing access control, encryption, network security, or audit logging
- Conducting a security review of an existing or proposed architecture
- Responding to a compliance audit or gap analysis
- Hardening servers, containers, or cloud services

## Applicable Frameworks

EMIS/Optum infrastructure must comply with ALL of the following:

| Framework | Scope | Reference |
|-----------|-------|-----------|
| **HIPAA** | All systems that process, store, or transmit PHI | [HIPAA Baseline](./references/hipaa-baseline.md) |
| **NIST Cybersecurity Framework** | Organisation-wide security posture | [NIST Baseline](./references/nist-baseline.md) |
| **CIS Level 2** | OS, cloud, and network hardening benchmarks | [CIS Level 2 Baseline](./references/cis-level2-baseline.md) |
| **ISO 27001** | Information Security Management System (ISMS) | [ISO 27001 Baseline](./references/iso27001-baseline.md) |

## Quick Compliance Check

When reviewing a design, validate against these mandatory controls:

### Data Protection
- [ ] Data classified (Public, Internal, Confidential, Restricted)
- [ ] Encryption at rest (AES-256 minimum)
- [ ] Encryption in transit (TLS 1.2+ minimum)
- [ ] Key management via Azure Key Vault or AWS KMS
- [ ] No PHI/PII in logs, comments, or unencrypted storage

### Access Control
- [ ] Least-privilege RBAC applied
- [ ] MFA enforced for all administrative access
- [ ] Privileged access via PIM (just-in-time)
- [ ] Service accounts use managed identities (Azure) or IAM roles/instance profiles (AWS) — no long-lived passwords or access keys in code
- [ ] IRSA (IAM Roles for Service Accounts) used for EKS pods (AWS)
- [ ] Access reviews scheduled (quarterly minimum)

### Network Security
- [ ] Network segmentation (VNet/VPC, subnets, NSGs/Security Groups)
- [ ] No public endpoints without WAF/DDoS protection
- [ ] Private endpoints for PaaS services (Azure) / VPC endpoints for AWS services
- [ ] Firewall rules follow deny-all default
- [ ] Azure Bastion (Azure) or AWS Systems Manager Session Manager (AWS) for admin access — no public RDP/SSH

### Logging & Monitoring
- [ ] Audit logging enabled for all components
- [ ] Logs forwarded to centralised SIEM (Sentinel/Log Analytics for Azure; CloudWatch + Security Hub for AWS)
- [ ] Minimum 90-day log retention (365 days for compliance; 6 years for HIPAA audit logs)
- [ ] Security alerting configured (Defender for Cloud for Azure; GuardDuty + Security Hub for AWS)
- [ ] Dynatrace security analytics enabled

### Patch Management
- [ ] Automated OS patching (Azure Update Management for Azure / AWS Systems Manager Patch Manager for AWS)
- [ ] Application patching per vendor schedule
- [ ] Critical patches applied within 14 days; high within 30 days
- [ ] Patch compliance reported monthly (via Azure Update Manager or AWS Config conformance pack)

### Incident Response
- [ ] Incident response procedure documented
- [ ] Security incidents escalated via ServiceNow P1/P2 process
- [ ] Post-incident review process defined
- [ ] Breach notification procedure aligned with HIPAA requirements

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

## References

- [HIPAA Baseline](./references/hipaa-baseline.md) — PHI handling, safeguards, breach notification
- [NIST Baseline](./references/nist-baseline.md) — CSF categories, control families
- [CIS Level 2 Baseline](./references/cis-level2-baseline.md) — Hardening benchmarks for OS, cloud, network
- [ISO 27001 Baseline](./references/iso27001-baseline.md) — ISMS controls, Annex A mapping
