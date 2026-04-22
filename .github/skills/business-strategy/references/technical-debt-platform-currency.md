# Technical Debt & Platform Currency

## Overview

Technical debt and platform currency are managed as first-class concerns at EMIS/Optum. All active remediation programmes must be tracked, costed, and prioritised using the same rigour applied to new demands. This reference documents the active programmes as of April 2026 and the framework for assessing and prioritising debt.

> **Architecture mandate**: Technical debt must be surfaced in demand reviews and HLDs. Never design on top of unacknowledged debt without a documented remediation plan and accepted risk.

---

## Active Remediation Programmes (April 2026)

### 1. Rising Sun Remediation

**Purpose**: Security and platform remediation programme addressing legacy security tooling, missing agent deployments, and network infrastructure gaps identified across the estate.

**Programme Owners**: Philip Mais / Chris King (programme management); Dave Nelson (network investigation)

| Workstream | Description | Status | Owner |
|-----------|-------------|--------|-------|
| **CrowdStrike Migration** | Deploy CrowdStrike EDR to all in-scope servers and endpoints; replace legacy AV | In progress | Chris Watts, Daniel Kaminski, David Gee, Abbie Bowes |
| **Tenable / Nessus Migration** | Migrate from on-prem Nessus scanners to Tenable.io cloud platform (port 443); agent-only deployments for AWS, DHCW, Doncaster; dedicated scanners for Gibraltar, Watford, Leeds DCs | In progress — next stage: split agent-only assets into dashboards/services (Mar 2026) | David Gee, David Vine |
| **Delinea DDE Deployment** | Deploy Delinea Distributed Engines (DDEs) across all VMware platforms; SSH proxy for Pinnacle; integrate syslog to SIEM | In progress — UKHosting, Wales, Gibraltar, Jersey, Doncaster | David Gee, Mark Howis, Daniel Kaminski, William Macpherson |
| **Network Infrastructure** | Network remediation work identified during Rising Sun assessment | Investigation | Dave Nelson |
| **Darktrace Expansion** | Deploy Darktrace appliances to additional sites; Jersey TBC; VMware integration PoC (OVA) | In progress | David Gee, Dave Nelson, Rob Deery, Abbie Bowes |

**Reference documents**:
- Nessus/Tenable migration: `Nessus/Tenable migration` (Confluence)
- CrowdStrike migration: `Crowdstrike - AV` (Confluence)
- Delinea Rising Sun: `Delinea Secret Server` (Confluence)

---

### 2. VMware Renewal Decision (October 2026)

**Purpose**: Broadcom/VMware licensing renewal is due **October 2026**. This is a board-level strategic decision with significant cost, architectural, and operational implications. Architecture must produce an options assessment to inform the decision.

**Renewal Contact**:
- Graham Wallace (TAM): graham.wallace@broadcom.com
- Gareth Edwards: gareth.edwards@broadcom.com
- Mick Watkins: mick.watkins@broadcom.com

**VMware Estate (April 2026)**:

| Site | Documentation Reference |
|------|------------------------|
| Wales | LLD \| WALES Expansion 2024 - Hosted Services - Confluence |
| Jersey | Local ESXi |
| Doncaster | LLD \| Doncaster Hardware Refresh - Hosted Services - Confluence |
| Symphony | — |
| Gibraltar | LLD Gibraltar Hardware Refresh - Hosted Services - Confluence |
| Leeds DCs | OUK Hosting (On-premises Services) - Hosted Services - Confluence |

**Key Reference Documents**:
- Options assessment: `To VMWare or not to VMware - Options` (Confluence)
- Licensing & costs: `VMWare Host Reporting Feb 2026_Dave Nelson.xlsx`
- vCenter login instructions: `VMware - vCenter Login Instructions` (Confluence)
- ARMIS scans network for all assets — provides VMware host inventory for options analysis

### Options for Assessment

| Option | Description | Indicative Benefit | Indicative Risk |
|--------|-------------|-------------------|----------------|
| **Renew VMware** | Accept Broadcom renewal terms; continue operating VMware vSphere/vSAN/NSX | Operational continuity; no migration risk | Broadcom pricing trajectory; licence model changes; ongoing vendor dependency |
| **Migrate workloads to cloud** | Accelerate cloud migration of remaining VMware workloads to AWS/Azure; reduce or eliminate vSphere footprint | Reduces on-prem footprint; aligns with cloud-first strategy | Migration risk; cost spike during transition; latency/compliance requirements for some workloads |
| **Migrate to alternative hypervisor** | Move to Nutanix, OpenStack, Proxmox, or Microsoft Hyper-V | Breaks Broadcom dependency; potential cost reduction | Re-platforming effort; tooling changes; team retraining |
| **Hybrid continuation** | Retain VMware for regulated/latency-sensitive; migrate commodity workloads to cloud | Balances cost and risk | Continued dual-platform complexity; ongoing VMware licences at reduced scope |

**Decision timeline**: Options assessment must be presented to ARB by **Q2 2026** to allow sufficient lead time before October 2026 renewal.

### VMware Gold Standard Aims (For Retention Scenario)

Regardless of the renewal decision, the following improvements are recommended for any retained VMware estate:

- [ ] Implement a tagging strategy and apply it to vCenter resources
- [ ] Improve monitoring of vCenter/ESXi and physical infrastructure
- [ ] Implement syslog forwarding for vCenter/ESXi
- [ ] Implement infrastructure reporting: security patches, VMware versions (VMware Skyline Health Diagnostics Virtual Appliance)
- [ ] Increase security posture: domain auth on ESXi Hosts and vCenter (not local accounts)
- [ ] Password rotation across all VMware products
- [ ] Certificate management for VMware products (CA-backed recommended over self-signed)
- [ ] Automated patching routines for vCenter and hosts
- [ ] Automated capacity reporting
- [ ] Deploy VMware Skyline Health Diagnostics Virtual Appliance

---

### 3. Certificate Management Roadmap

**Purpose**: Establish automated certificate lifecycle management across all on-prem and cloud services. Self-signed and manually managed certificates are a security and operational risk.

**Current Status**: Backlogged — held on Aha! backlog and El Capitan ADO backlog.

**Scope**:
- VMware products (vCenter, ESXi, NSX) — self-signed certificates to be replaced with CA-backed
- On-premises services
- AWS ACM (Certificate Manager) — automated renewal for AWS-hosted services
- Azure Key Vault — certificate management for Azure-hosted services

**Proposed Solution Elements**:
- Internal CA or external CA (e.g., DigiCert, Let's Encrypt) — assess based on use case
- Azure Key Vault / AWS ACM for cloud certificate automation
- HashiCorp Vault PKI (if evaluated as strategic) for on-prem private CA
- CrowdStrike / ARMIS for certificate expiry detection

**Priority**: Move from backlog to active roadmap before VMware renewal decision — certificate automation is a dependency for any VMware gold standard improvement.

---

### 4. EMISWeb Containerisation

**Purpose**: Containerise the EMISWeb application tier and migrate the database tier to AWS RDS, reducing VM-based infrastructure overhead and enabling cloud-native scaling.

**Owner**: Rich Davies + Mic Holden
**Reference**: Draft `EMIS Web - Doubling down on cloud` (Confluence)

**Architectural implications**:
- This is a Tier 1 / mission-critical workload — BC/DR design must be reviewed at each phase
- Container platform: EKS (AWS primary) with Karpenter autoscaling
- Database migration: SQL Server on VMware → AWS RDS or RDS Custom for SQL Server
- Network: HSCN connectivity must be preserved throughout migration phases
- Clinical safety: DCB0129 review required for each phase affecting clinical data display or availability

---

### 5. Bastion Replacement

**Purpose**: 60+ legacy bastion hosts are deployed for remote administrative access. These represent a security risk (publicly accessible, manual key management) and operational overhead. Replace with Zero Trust-aligned access methods.

**Current state**: 60+ bastions across the estate
**Target state**: Zero bastions; all admin access via:
- **AWS**: AWS Systems Manager Session Manager (SSM) — port-less, credential-less, fully audited
- **Azure**: Azure Bastion (managed, no public RDP/SSH)
- **On-prem**: Delinea Secret Server SSH proxy / ZPA (Zscaler Private Access) for individual endpoints

**Priority**: Aligns with CyberEssentials Plus (no public RDP/SSH), Zero Trust Architecture principle, and HIPAA audit logging requirements. Raise as a security remediation demand.

---

### 6. Security Patching Automation

**Purpose**: Automate OS and application patching across all platforms to reduce manual effort, close compliance gaps, and meet the 14-day critical / 30-day high patch SLA.

**Current gaps**:
- Manual patching processes remain for some VMware and legacy on-prem workloads
- Patch compliance reporting is inconsistent

**Target state**:
- **AWS**: AWS Systems Manager Patch Manager with patch baselines per OS; compliance reporting via AWS Config conformance pack
- **Azure**: Azure Update Manager with maintenance windows; compliance view in Defender for Cloud
- **VMware/on-prem**: Ansible-based patching runbooks; VMware Skyline for patch advisory; integrate compliance reporting into Dynatrace or ServiceNow

---

## Technical Debt Assessment Framework

Use this framework when assessing technical debt in demand reviews or architecture reviews:

### MoSCoW-Style Prioritisation

| Priority | Criteria |
|----------|---------|
| **Must remediate** | Active security risk (critical/high CVE); HIPAA/CyberEssentials compliance gap; EOL platform with no vendor support; imminent licence/renewal deadline (< 6 months) |
| **Should remediate** | Medium-term security risk; operational inefficiency > 20% FTE time; platform approaching EOL; performance SLA at risk |
| **Could remediate** | Technical debt that increases delivery friction but no immediate risk; modernisation opportunity without urgency |
| **Won't (now)** | Acknowledged debt; too costly to remediate relative to value; documented and risk-accepted by CISO/CTO |

### Scoring Template

| Criterion | Score (1-5) | Notes |
|-----------|------------|-------|
| **Security Risk** | | Critical CVE = 5; no risk = 1 |
| **Compliance Risk** | | Regulatory breach = 5; no compliance impact = 1 |
| **Operational Risk** | | Service outage risk = 5; cosmetic only = 1 |
| **Cost Impact** | | > £100k/year waste or risk = 5 |
| **Effort to Remediate** | | Trivial = 5 (easy to fix); enormous = 1 |
| **Business Impact if Not Fixed** | | Patient safety / revenue = 5; minimal = 1 |
| **Priority Score (Benefit/Effort)** | | Sum Security+Compliance+Operational+Cost+Business ÷ Effort |

Programmes with the highest Priority Score should be raised to the top of the remediation backlog.

---

## Technical Debt Register

Maintain a live technical debt register in Aha! and the relevant ADO workstream backlog. Each item must include:

| Field | Content |
|-------|---------|
| **Item** | Short description of the debt |
| **Platform/System** | Affected system |
| **Risk Category** | Security / Compliance / Operational / Cost |
| **Priority** | Must / Should / Could / Won't |
| **Priority Score** | From scoring template above |
| **Owner** | Responsible team / individual |
| **Target Resolution Date** | Agreed deadline |
| **ADO Work Item** | Link to backlog item |
| **Cost to Remediate** | Estimated effort and/or spend |
| **Risk if Not Fixed** | Documented consequence of non-remediation |
| **Risk Accepted By** | Named accountable person (if Won't) |
