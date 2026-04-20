# NIST Cybersecurity Framework Baseline

## Overview

The NIST Cybersecurity Framework (CSF) provides a structured approach to managing cybersecurity risk. EMIS/Optum uses NIST CSF as the overarching framework for security posture management, supplemented by specific controls from NIST SP 800-53.

## CSF Core Functions

### 1. IDENTIFY (ID)

**Goal**: Develop an understanding of the organisational context, assets, and risks.

| Category | Control | EMIS/Optum Implementation |
|----------|---------|--------------------------|
| **Asset Management (ID.AM)** | Hardware inventory | ServiceNow CMDB; Azure Resource Graph; AWS Config |
| | Software inventory | CMDB application CIs; container image registry |
| | Data flow mapping | Documented in HLD/LLD; Dynatrace service flow maps |
| | External information systems | Third-party integration register in Confluence |
| | Resource classification | Data classification policy: Public, Internal, Confidential, Restricted |
| **Risk Assessment (ID.RA)** | Vulnerability identification | Defender for Cloud; AWS Security Hub; Qualys/Nessus scans |
| | Threat intelligence | Microsoft Threat Intelligence; Dynatrace Security Analytics |
| | Risk register | Maintained in [INTERNAL — populate: risk management tool/location] |
| **Governance (ID.GV)** | Security policy | Information Security Policy in Confluence |
| | Roles & responsibilities | RACI documented per service/application |
| | Legal & regulatory requirements | HIPAA, UK Data Protection Act 2018, GDPR awareness |

### 2. PROTECT (PR)

**Goal**: Implement safeguards to ensure delivery of critical services.

| Category | Control | EMIS/Optum Implementation |
|----------|---------|--------------------------|
| **Access Control (PR.AC)** | Identity management | Azure AD / Entra ID; federated SSO |
| | Remote access | VPN + MFA; Azure Bastion for infrastructure access |
| | Permissions management | RBAC with least privilege; PIM for just-in-time elevation |
| | Network segmentation | Hub-and-spoke VNets; NSGs; private endpoints |
| **Awareness & Training (PR.AT)** | Security training | Annual security awareness training; phishing simulations |
| | Privileged user training | Additional training for administrators; documented in LMS |
| **Data Security (PR.DS)** | Data-at-rest protection | AES-256 encryption; Azure Disk Encryption / AWS EBS Encryption |
| | Data-in-transit protection | TLS 1.2+ mandatory; ExpressRoute/Direct Connect encryption |
| | Asset decommissioning | Secure media destruction (NIST 800-88); Azure disk wipe |
| | Data leak prevention | Microsoft Purview DLP; sensitivity labels |
| **Protective Technology (PR.PT)** | Audit logging | Azure Activity Logs, Diagnostic Logs; CloudTrail |
| | Removable media | Blocked via endpoint policy; exceptions require approval |
| | Least functionality | CIS hardened OS images; unnecessary services disabled |
| | Communication protection | TLS everywhere; mTLS for service-to-service where feasible |

### 3. DETECT (DE)

**Goal**: Implement activities to identify cybersecurity events.

| Category | Control | EMIS/Optum Implementation |
|----------|---------|--------------------------|
| **Anomalies & Events (DE.AE)** | Baseline establishment | Dynatrace AI-powered baselining; Azure Monitor baselines |
| | Event analysis | Sentinel analytics rules; Dynatrace problem detection |
| | Event correlation | Sentinel workbooks; Dynatrace Smartscape topology |
| | Impact determination | Automated severity classification based on affected CIs |
| **Security Monitoring (DE.CM)** | Network monitoring | NSG Flow Logs; Azure Firewall Logs; Dynatrace network module |
| | Physical security monitoring | Data centre CCTV; badge access logs |
| | Personnel activity monitoring | Azure AD sign-in logs; Conditional Access monitoring |
| | Malicious code detection | Defender for Endpoint; Defender for Cloud (server protection) |
| | Unauthorised access detection | Azure AD Identity Protection; impossible travel alerts |
| | Vulnerability scanning | Monthly Defender for Cloud scans; container image scanning |
| **Detection Processes (DE.DP)** | Roles & responsibilities | SOC team defined; escalation paths documented |
| | Testing detection | Purple team exercises annually; detection rule validation |
| | Continuous improvement | Post-incident detection gap analysis |

### 4. RESPOND (RS)

**Goal**: Take action regarding detected cybersecurity incidents.

| Category | Control | EMIS/Optum Implementation |
|----------|---------|--------------------------|
| **Response Planning (RS.RP)** | Incident response plan | Documented in Confluence; referenced in ServiceNow playbooks |
| **Communications (RS.CO)** | Personnel notification | PagerDuty for P1; ServiceNow workflow for P2-P4 |
| | Incident reporting | ServiceNow incident + major incident process for P1 |
| | Information sharing | Threat intelligence sharing per agreed protocols |
| | Stakeholder coordination | RACI-based communication; executive notification for P1 |
| **Analysis (RS.AN)** | Investigation | Sentinel investigation graphs; Dynatrace root cause analysis |
| | Forensics | Azure disk snapshots for forensic preservation |
| | Incident categorisation | MITRE ATT&CK mapping where applicable |
| **Mitigation (RS.MI)** | Containment | Network isolation; account disablement; rule blocks |
| | Eradication | Patch, re-image, or rebuild affected systems |
| **Improvements (RS.IM)** | Post-incident review | Blameless PIR within 5 business days of P1 resolution |

### 5. RECOVER (RC)

**Goal**: Restore capabilities impaired during a cybersecurity incident.

| Category | Control | EMIS/Optum Implementation |
|----------|---------|--------------------------|
| **Recovery Planning (RC.RP)** | Recovery execution | DR procedures per service tier; tested annually |
| **Improvements (RC.IM)** | Lessons learned | PIR findings incorporated into design and runbooks |
| | Recovery strategy updates | DR plans updated based on PIR and annual review |
| **Communications (RC.CO)** | Public relations | Comms team engagement for externally visible incidents |
| | Reputation repair | Customer notification per HIPAA and regulatory requirements |

## Architecture Design Checklist (NIST)

When designing infrastructure:

- [ ] All assets are inventoried and classified
- [ ] Risk assessment completed for the solution
- [ ] Access control follows least privilege (RBAC + PIM)
- [ ] Data is encrypted at rest and in transit
- [ ] Security monitoring is configured (Defender, Sentinel, Dynatrace)
- [ ] Vulnerability scanning is scheduled
- [ ] Incident response procedures reference the solution
- [ ] DR/recovery procedures are documented and tested
- [ ] Post-incident review process includes this solution's components
