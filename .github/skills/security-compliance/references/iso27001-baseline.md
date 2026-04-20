# ISO 27001 Baseline

## Overview

ISO/IEC 27001:2022 specifies requirements for establishing, implementing, maintaining, and continually improving an Information Security Management System (ISMS). EMIS/Optum maintains ISO 27001 certification, and all infrastructure designs must support the ISMS controls.

## Annex A Controls — Infrastructure Architecture Relevance

The following maps ISO 27001:2022 Annex A controls to EMIS/Optum infrastructure implementation. Controls are grouped by theme.

### A.5 — Organisational Controls

| Control | Title | Infrastructure Implementation |
|---------|-------|------------------------------|
| A.5.1 | Policies for information security | Documented in Confluence; referenced in HLD/LLD |
| A.5.2 | Information security roles & responsibilities | RACI matrix per service; documented in HLD |
| A.5.3 | Segregation of duties | Separate roles for dev, deploy, operate; PIM for elevation |
| A.5.9 | Inventory of information & associated assets | ServiceNow CMDB; Azure Resource Graph; AWS Config |
| A.5.10 | Acceptable use of information & assets | Endpoint policies; Azure AD Conditional Access |
| A.5.12 | Classification of information | Data classification (Public, Internal, Confidential, Restricted) applied to all designs |
| A.5.13 | Labelling of information | Sensitivity labels via Microsoft Purview; document classification headers |
| A.5.14 | Information transfer | Encrypted transfer protocols (TLS, SFTP); data sharing agreements |
| A.5.15 | Access control | RBAC; least privilege; MFA; documented in design |
| A.5.23 | Information security for cloud services | Cloud security baseline applied (this skill); CSP responsibility model documented |
| A.5.29 | Information security during disruption | DR/BCP plans; tested annually; referenced in HLD |
| A.5.30 | ICT readiness for business continuity | DR architecture documented; RTO/RPO defined per tier |

### A.6 — People Controls

| Control | Title | Infrastructure Implementation |
|---------|-------|------------------------------|
| A.6.1 | Screening | HR process; not directly infrastructure but referenced in access provisioning |
| A.6.2 | Terms & conditions of employment | Security responsibilities in contracts |
| A.6.3 | Information security awareness, education & training | Annual training; tracked in LMS |
| A.6.4 | Disciplinary process | HR-managed; Atlas_Architect does not implement directly |
| A.6.5 | Responsibilities after termination | Automated deprovisioning via Azure AD lifecycle |

### A.7 — Physical Controls

| Control | Title | Infrastructure Implementation |
|---------|-------|------------------------------|
| A.7.1 | Physical security perimeters | Data centre physical security; out of scope for cloud-native designs |
| A.7.4 | Physical security monitoring | CCTV; badge access; cloud equivalent: Azure AD sign-in monitoring |
| A.7.9 | Security of assets off-premises | Encrypted laptops; VPN; device compliance via Intune |
| A.7.10 | Storage media | Encrypted storage; secure disposal (NIST 800-88) |
| A.7.14 | Secure disposal or re-use of equipment | Azure disk wipe on deallocation; crypto-shred for encrypted volumes |

### A.8 — Technological Controls

| Control | Title | Infrastructure Implementation |
|---------|-------|------------------------------|
| A.8.1 | User endpoint devices | Intune MDM; Defender for Endpoint; Conditional Access (compliant device) |
| A.8.2 | Privileged access rights | PIM; just-in-time access; time-limited elevation |
| A.8.3 | Information access restriction | RBAC; NSGs; private endpoints; data masking where applicable |
| A.8.4 | Access to source code | ADO repository permissions; branch policies |
| A.8.5 | Secure authentication | MFA; certificate-based auth for services; managed identities |
| A.8.6 | Capacity management | Auto-scaling; Azure Monitor capacity alerts; right-sizing reviews |
| A.8.7 | Protection against malware | Defender for Endpoint; Defender for Cloud; container image scanning |
| A.8.8 | Management of technical vulnerabilities | Defender vulnerability assessment; monthly patching; CVE tracking |
| A.8.9 | Configuration management | IaC (Terraform/Bicep); Azure Policy; drift detection |
| A.8.10 | Information deletion | Data retention policies; automated deletion; crypto-shred |
| A.8.11 | Data masking | Dynamic data masking for SQL databases; synthetic data for test environments |
| A.8.12 | Data leakage prevention | Microsoft Purview DLP; Azure Information Protection |
| A.8.13 | Information backup | Azure Backup; Veeam; tested restore procedures |
| A.8.14 | Redundancy of information processing | Availability Zones; multi-region DR; N+1 capacity |
| A.8.15 | Logging | Centralised logging (Log Analytics / Sentinel); application + infrastructure logs |
| A.8.16 | Monitoring activities | Dynatrace; Azure Monitor; Defender for Cloud; continuous monitoring |
| A.8.17 | Clock synchronisation | NTP synchronisation for all servers; Azure default time sync for cloud VMs |
| A.8.20 | Network security | Hub-and-spoke; firewall; NSGs; private endpoints (see networking standards) |
| A.8.21 | Security of network services | ExpressRoute; encrypted VPN; DDoS protection |
| A.8.22 | Segregation in networks | Subnet isolation; micro-segmentation (NSX on-prem, NSGs in cloud) |
| A.8.23 | Web filtering | Azure Firewall FQDN rules; proxy for on-prem |
| A.8.24 | Use of cryptography | AES-256 at rest; TLS 1.2+ in transit; Key Vault for key management |
| A.8.25 | Secure development lifecycle | Secure code scanning in ADO pipelines; IaC security scanning (tfsec/checkov) |
| A.8.26 | Application security requirements | Security NFRs in design; OWASP Top 10 awareness |
| A.8.28 | Secure coding | Not directly infrastructure but relevant for IaC: no hardcoded secrets, input validation |

## Statement of Applicability (SoA) — Infrastructure Scope

When producing an HLD or LLD, map your design to the relevant Annex A controls:

```markdown
## ISO 27001 Control Mapping

| Control | Status | Implementation | Evidence |
|---------|--------|---------------|----------|
| A.5.15 Access Control | Implemented | Azure AD RBAC + PIM | [Link to RBAC design section] |
| A.8.20 Network Security | Implemented | Hub-and-spoke + NSGs | [Link to network design section] |
| A.8.24 Use of Cryptography | Implemented | AES-256 + TLS 1.2 | [Link to security section] |
| ... | | | |
```

## Architecture Design Checklist (ISO 27001)

- [ ] Data classification determined and documented
- [ ] Access control model designed (RBAC/least privilege)
- [ ] Encryption requirements defined (at rest and in transit)
- [ ] Logging and monitoring architecture defined
- [ ] Backup and recovery procedures designed
- [ ] Network segmentation and security controls designed
- [ ] Vulnerability management process covers all components
- [ ] Configuration managed via IaC with drift detection
- [ ] Capacity management and auto-scaling designed
- [ ] DR/BCP architecture documented with RTO/RPO targets
- [ ] Relevant Annex A controls mapped in the design document
