# HIPAA Baseline

## Overview

The Health Insurance Portability and Accountability Act (HIPAA) requires safeguards for Protected Health Information (PHI). All EMIS/Optum infrastructure that processes, stores, or transmits PHI must comply with the HIPAA Security Rule.

> **Scope**: Any system that handles PHI — including databases, application servers, file storage, messaging systems, and backup infrastructure that contains or could contain PHI.

## Administrative Safeguards

### Security Management Process (§164.308(a)(1))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Risk Analysis | Annual risk assessment of all PHI-handling systems; documented in Confluence |
| Risk Management | Risk register maintained; remediation plans tracked in ServiceNow |
| Sanction Policy | HR-enforced sanctions for policy violations |
| Information System Activity Review | Monthly review of audit logs for PHI access; Dynatrace + Log Analytics |

### Workforce Security (§164.308(a)(3))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Authorisation/Supervision | RBAC with least privilege; Azure AD PIM for elevated access |
| Workforce Clearance | Background checks per HR policy |
| Termination Procedures | Automated account deprovisioning via Azure AD lifecycle management |

### Information Access Management (§164.308(a)(4))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Access Authorisation | Role-based; approved via ServiceNow request with manager sign-off |
| Access Establishment/Modification | Provisioned via Azure AD groups; reviewed quarterly |
| Isolating Healthcare Clearinghouse Functions | Separate subscriptions/accounts for clearinghouse workloads |

### Security Awareness Training (§164.308(a)(5))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Security Reminders | Quarterly security awareness communications |
| Protection from Malware | Endpoint protection (Defender for Endpoint) on all devices |
| Login Monitoring | Azure AD Sign-In Logs; anomalous login alerting via Conditional Access |
| Password Management | Azure AD password policies; complexity + length requirements; no shared accounts |

### Contingency Plan (§164.308(a)(7))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Data Backup Plan | Automated daily backups; geo-redundant for Tier 1 |
| Disaster Recovery Plan | Documented DR procedures per service tier; tested annually |
| Emergency Mode Operation Plan | Documented procedures for operating during system outages |
| Testing & Revision | Annual DR test; post-test review and plan updates |

## Physical Safeguards

### Facility Access Controls (§164.310(a)(1))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Facility Security Plan | Data centre access controlled by physical security (badge, biometric) |
| Access Control & Validation | Visitor logs; escort requirements for non-staff |
| Maintenance Records | Data centre maintenance tracked and audited |

### Workstation & Device Security (§164.310(b-d))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Workstation Use | Acceptable use policy; screen lock; clean desk |
| Workstation Security | Encrypted laptops; VPN required for remote access |
| Device & Media Controls | Encrypted storage; secure media disposal (NIST 800-88 compliant) |

## Technical Safeguards

### Access Control (§164.312(a)(1))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Unique User Identification | Individual Azure AD accounts; no shared credentials |
| Emergency Access Procedure | Break-glass accounts stored in Key Vault; usage audited |
| Automatic Logoff | Session timeout: 15 minutes for PHI systems |
| Encryption & Decryption | AES-256 at rest; TLS 1.2+ in transit |

### Audit Controls (§164.312(b))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Audit Logging | All PHI access logged; Azure AD audit logs, application audit trails |
| Log Retention | Minimum 6 years (HIPAA requirement); stored in immutable storage |
| Log Review | Automated anomaly detection (Sentinel); monthly manual review |

### Integrity (§164.312(c)(1))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Data Integrity | Checksums/hashing for data in transit; database integrity constraints |
| Mechanism to Authenticate ePHI | Digital signatures; TLS mutual authentication where applicable |

### Transmission Security (§164.312(e)(1))

| Control | EMIS/Optum Implementation |
|---------|--------------------------|
| Integrity Controls | TLS with certificate validation; reject invalid certificates |
| Encryption | TLS 1.2+ mandatory; TLS 1.3 preferred for new implementations |
| Network Isolation | PHI systems in dedicated subnets; no direct internet access |

## Breach Notification Requirements

| Requirement | Detail |
|-------------|--------|
| Discovery | Document the date of discovery of any PHI breach |
| Notification Timeline | Affected individuals within 60 days of discovery |
| Content | Nature of breach, types of information involved, steps to protect, what the entity is doing |
| HHS Notification | If ≥ 500 individuals: notify HHS within 60 days |
| Media Notification | If ≥ 500 individuals in a state: notify prominent media outlets |

## Architecture Design Checklist (HIPAA)

When designing infrastructure that handles PHI:

- [ ] PHI data flows are documented and encrypted end-to-end
- [ ] Access to PHI requires MFA and is logged
- [ ] PHI storage is encrypted at rest with managed keys (Key Vault / KMS)
- [ ] Backup of PHI data is encrypted and geo-redundant
- [ ] Audit logs for PHI access are retained for minimum 6 years
- [ ] Network segmentation isolates PHI systems from general infrastructure
- [ ] Disaster recovery for PHI systems meets defined RTO/RPO
- [ ] Break-glass access procedure is documented and tested
- [ ] Business Associate Agreements (BAA) are in place for all third-party services handling PHI
- [ ] Cloud services used for PHI are HIPAA-eligible (Azure: BAA covers most services; AWS: BAA covers specified services)
