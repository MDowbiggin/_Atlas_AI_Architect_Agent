# Zero Trust Assessment Guide

## Overview

Zero Trust is a security model based on the principle of "never trust, always verify." It eliminates implicit trust based on network location and requires continuous verification of every request, regardless of where it originates.

EMIS/Optum's Zero Trust alignment is assessed across six pillars. Each pillar has a maturity scale from **Traditional** (perimeter-based, network-implicit trust) through **Advanced** (identity-centric, contextual controls) to **Optimal** (fully automated, continuous verification, AI-assisted).

> Zero Trust is not a product — it is a strategy. Designs are assessed against the model; gaps generate remediation actions that feed into architecture decisions (ADRs) and the technical debt programme.

---

## The Six Zero Trust Pillars

### Pillar 1: Identity

**Goal**: Verify every identity explicitly; treat identity as the new perimeter.

| Maturity Level | Characteristics |
|----------------|----------------|
| **Traditional** | Username/password only; static group membership; no MFA; shared service accounts |
| **Advanced** | MFA enforced; RBAC aligned to least privilege; PIM for elevated access; managed identities for services |
| **Optimal** | Continuous access evaluation; risk-based Conditional Access; passwordless authentication; no standing privileges; IRSA for container workloads |

**EMIS/Optum Controls:**

| Control | Implementation | Target State |
|---------|---------------|-------------|
| MFA | Azure AD Conditional Access (all users) | Advanced ✅ |
| Just-in-time access | Azure AD PIM; no standing admin | Advanced ✅ |
| Managed identities | Used for Azure service-to-service | Advanced ✅ |
| IRSA | IAM Roles for Service Accounts (EKS) | Advanced ✅ |
| Passwordless | Selective rollout | Advanced → Optimal |
| Continuous access evaluation | Azure AD CAE enabled | Advanced ✅ |
| Service account governance | Managed identities only; no client secret rotation | Advanced ✅ |

---

### Pillar 2: Device

**Goal**: Validate device health before granting access; treat unmanaged devices as untrusted.

| Maturity Level | Characteristics |
|----------------|----------------|
| **Traditional** | Any device on the corporate network is trusted; no device compliance checks |
| **Advanced** | MDM-enrolled devices required for corporate access; health checks at authentication; Conditional Access device compliance |
| **Optimal** | Continuous device health monitoring; automatic remediation for non-compliant devices; hardware attestation |

**EMIS/Optum Controls:**

| Control | Implementation | Target State |
|---------|---------------|-------------|
| MDM enrollment | Microsoft Intune for corporate devices | Advanced ✅ |
| Device compliance | Conditional Access requires compliant device | Advanced ✅ |
| EDR | CrowdStrike Falcon on all endpoints | Advanced ✅ |
| Healthcare/clinical devices | ARMIS asset discovery covers IoT/medical | Advanced ✅ |
| Patch compliance | Update Manager / Intune compliance policies | Advanced ✅ |

---

### Pillar 3: Network

**Goal**: Limit blast radius; assume any network segment can be compromised; verify all north-south and east-west traffic.

| Maturity Level | Characteristics |
|----------------|----------------|
| **Traditional** | Flat network; trust based on being inside the perimeter; perimeter firewall only |
| **Advanced** | Segmented networks; NSGs/Security Groups; private endpoints; no implicit east-west trust |
| **Optimal** | Micro-segmentation at workload level; mTLS between services; traffic inspection for all paths; network access proxy (ZTNA) |

**EMIS/Optum Controls:**

| Control | Implementation | Target State |
|---------|---------------|-------------|
| Network segmentation | Hub-and-spoke; VNets/VPCs with subnets; NSGs/Security Groups | Advanced ✅ |
| Private endpoints | PaaS services accessed via private endpoint only (Azure) | Advanced ✅ |
| VPC endpoints | AWS service access via VPC endpoints | Advanced ✅ |
| No public admin access | Azure Bastion / SSM Session Manager; no public RDP/SSH | Advanced ✅ |
| WAF | Azure Application Gateway WAF v2 / AWS WAF on internet-facing services | Advanced ✅ |
| East-west inspection | Azure Firewall / Palo Alto for inter-subnet traffic | Advanced → Optimal |
| mTLS | Service-to-service mTLS (EKS service mesh — under evaluation) | Traditional → Optimal |
| ZTNA | Network access via ZPA (in evaluation for remote access) | Advanced |

---

### Pillar 4: Application

**Goal**: Protect applications with per-session access validation; no implicit application-level trust.

| Maturity Level | Characteristics |
|----------------|----------------|
| **Traditional** | Applications trusted once user is on the network; no app-level access controls |
| **Advanced** | OAuth 2.0/OIDC; per-app Conditional Access; session management; WAF |
| **Optimal** | Continuous session assessment; adaptive authentication; app-level micro-segmentation; API gateway enforcement |

**EMIS/Optum Controls:**

| Control | Implementation | Target State |
|---------|---------------|-------------|
| OAuth 2.0/OIDC | Azure AD app registrations; managed identity federation | Advanced ✅ |
| Per-app Conditional Access | Conditional Access policies targeting specific applications | Advanced ✅ |
| WAF | Application Gateway WAF v2 / AWS WAF on public-facing apps | Advanced ✅ |
| API gateway | Azure API Management / AWS API Gateway for API exposure | Advanced ✅ |
| Secrets management | Azure Key Vault / AWS Secrets Manager; no hardcoded secrets | Advanced ✅ |
| Session timeout | 15-minute timeout for PHI-handling applications | Advanced ✅ |

---

### Pillar 5: Data

**Goal**: Classify, encrypt, and monitor data at all stages; limit access to the minimum necessary.

| Maturity Level | Characteristics |
|----------------|----------------|
| **Traditional** | Data accessible by anyone on the network; no classification; encryption inconsistent |
| **Advanced** | Data classified; encryption at rest and in transit enforced; access controls tied to classification |
| **Optimal** | Automated data discovery and classification; DLP policies enforced; data access just-in-time; PHI/PII never leaves secure boundaries |

**EMIS/Optum Controls:**

| Control | Implementation | Target State |
|---------|---------------|-------------|
| Data classification | Public / Internal / Confidential / Restricted framework | Advanced ✅ |
| Encryption at rest | AES-256; Azure Disk Encryption / KMS for all production | Advanced ✅ |
| Encryption in transit | TLS 1.2+ mandatory; TLS 1.3 for new builds | Advanced ✅ |
| PHI access logging | 6-year HIPAA audit log retention; immutable storage | Advanced ✅ |
| Data loss prevention | Microsoft Purview DLP; sensitivity labels | Advanced ✅ |
| Amazon Macie | Automated PHI discovery in S3 (AWS) | Advanced ✅ |
| CMK for PHI | Customer-managed keys for Confidential/Restricted data | Advanced ✅ |

---

### Pillar 6: Visibility & Automation (Monitoring)

**Goal**: Monitor all activity, automate detection and response; assume breach is always possible.

| Maturity Level | Characteristics |
|----------------|----------------|
| **Traditional** | Perimeter-focused monitoring; manual log review; reactive response |
| **Advanced** | Centralised SIEM; automated alerting; threat intelligence feeds; incident playbooks |
| **Optimal** | AI/ML threat detection; SOAR automation; continuous compliance assessment; behavioural analytics |

**EMIS/Optum Controls:**

| Control | Implementation | Target State |
|---------|---------------|-------------|
| SIEM | Microsoft Sentinel (Azure); CloudWatch + Security Hub (AWS) | Advanced ✅ |
| Threat detection | Defender for Cloud; GuardDuty; Darktrace (network AI) | Advanced ✅ |
| Observability | Dynatrace OneAgent across all platforms | Advanced ✅ |
| Vulnerability management | Defender vulnerability assessment; Tenable Nessus/tenable.io | Advanced ✅ |
| SOAR | Sentinel playbooks for automated response (in development) | Advanced → Optimal |
| Behavioural analytics | Azure AD Identity Protection; impossible travel | Advanced ✅ |

---

## Zero Trust Assessment Template

Use this template when assessing a solution design or existing system for Zero Trust maturity.

```markdown
# Zero Trust Assessment — [Solution / System Name]

## Overview

| Field | Value |
|-------|-------|
| **System** | [Name] |
| **Assessor** | [Name, Role] |
| **Date** | YYYY-MM-DD |
| **Related HLD** | HLD-[XXXX] |

## Pillar Assessment

| Pillar | Current State | Target State | Gaps Identified | Priority |
|--------|--------------|-------------|----------------|---------|
| Identity | Traditional / Advanced / Optimal | | | H/M/L |
| Device | Traditional / Advanced / Optimal | | | H/M/L |
| Network | Traditional / Advanced / Optimal | | | H/M/L |
| Application | Traditional / Advanced / Optimal | | | H/M/L |
| Data | Traditional / Advanced / Optimal | | | H/M/L |
| Visibility & Automation | Traditional / Advanced / Optimal | | | H/M/L |

## Gap Analysis

### High Priority Gaps

| Pillar | Gap Description | Risk | Remediation | ADR / Demand Ref |
|--------|----------------|------|-------------|-----------------|
| | | | | |

### Medium Priority Gaps

| Pillar | Gap Description | Risk | Remediation | ADR / Demand Ref |
|--------|----------------|------|-------------|-----------------|
| | | | | |

## Overall Zero Trust Maturity Score

| Pillar | Score (1=Traditional, 2=Advanced, 3=Optimal) |
|--------|---------------------------------------------|
| Identity | |
| Device | |
| Network | |
| Application | |
| Data | |
| Visibility & Automation | |
| **Total** | /18 |
| **Average** | |

## Recommended Actions

1.
2.
3.
```

---

## Zero Trust Quick Reference — Design Checklist

- [ ] No implicit trust based on network location — verify identity for every request
- [ ] MFA enforced for all human identities accessing the system
- [ ] Managed identities / IRSA used for all service-to-service communication — no stored credentials
- [ ] Network segmentation: subnets, NSGs/Security Groups, private endpoints in place
- [ ] No public administrative ports (RDP/SSH) — Bastion or Session Manager only
- [ ] East-west traffic between tiers explicitly permitted via rules; deny-all default
- [ ] Data classified and encryption applied per classification
- [ ] PHI access logged and retained per HIPAA (6 years)
- [ ] Monitoring and alerting connected to SIEM; anomalous access alerts configured
- [ ] Session timeouts configured for PHI-handling applications (15 minutes)
