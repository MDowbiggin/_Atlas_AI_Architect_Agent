# Vendor Management

## Overview

This reference covers EMIS/Optum's key vendor relationships, enterprise agreements, licence governance principles, and the approach for managing commercial vendor risk. Architecture must account for vendor relationships when selecting technologies and producing BoMs.

> **Commercial boundary**: Infrastructure Architects provide technical validation and indicative costings. All contract negotiations, procurement decisions, and commercial commitments require sign-off from the EMIS/Optum Commercial/Procurement team.

---

## Key Vendors & Relationships

### Microsoft

| Item | Detail |
|------|--------|
| **Relationship type** | Enterprise Agreement (EA) |
| **Primary products** | Azure, Microsoft 365, Windows Server, SQL Server, Entra ID, Defender, Sentinel |
| **Key licensing** | Enterprise Agreement true-up model; Azure Hybrid Benefit (AHUB) for Windows Server and SQL Server |
| **AHUB eligibility** | Windows Server and SQL Server licences with active Software Assurance (SA) can be used on Azure to reduce costs by 40-55% |
| **Dev/Test pricing** | Azure Dev/Test subscription reduces Windows OS licensing cost for non-production |
| **Savings vehicles** | Azure Reserved Instances (1yr/3yr); Azure Savings Plans for Compute |
| **Support tier** | [INTERNAL — confirm current Microsoft support contract level: Developer / Standard / Professional Direct / Premier] |
| **Key contact** | [INTERNAL — Microsoft Account Manager] |

**Architecture notes**:
- Always check AHUB eligibility before pricing Windows Server / SQL Server on Azure
- New Azure services not covered under the EA may require a separate purchase order — confirm with Procurement
- Microsoft Entra ID (Azure AD) is the strategic identity platform; any new identity tooling must integrate with it

---

### Amazon Web Services (AWS)

| Item | Detail |
|------|--------|
| **Relationship type** | Enterprise Discount Programme (EDP) or standard consolidated billing under AWS Organizations |
| **Primary products** | EC2, EKS, RDS, S3, VPC, Lambda, Route 53, GuardDuty, Security Hub, CloudWatch, Direct Connect |
| **Key licensing** | Pay-as-you-go; Savings Plans; Reserved Instances; Spot |
| **Savings vehicles** | Compute Savings Plans (≥70% steady-state target); EC2 RI for specific workloads; Graviton for ~20% cost benefit |
| **Support tier** | [INTERNAL — confirm current AWS support tier: Developer / Business / Enterprise On-Ramp / Enterprise] |
| **TAM** | [INTERNAL — AWS Technical Account Manager if Enterprise tier] |

**Architecture notes**:
- AWS is the primary cloud platform; default to AWS for new workloads unless justified
- Graviton (arm64) is the default instance family; x86 requires documented justification
- Savings Plans coverage reviewed quarterly by CloudOps (Rich Davies, Matt Jackson, Nabeel)
- New AWS services in accounts not under the consolidated billing structure require Procurement approval before provisioning

---

### Broadcom / VMware

| Item | Detail |
|------|--------|
| **Relationship type** | Enterprise licence agreement |
| **Products** | vSphere, vSAN, NSX, vCenter |
| **Renewal date** | **October 2026** — critical strategic decision point |
| **Licensing model** | Broadcom has moved to subscription/per-core pricing post-acquisition; assess impact on renewal terms |
| **TAM contacts** | Graham Wallace (graham.wallace@broadcom.com), Gareth Edwards (gareth.edwards@broadcom.com), Mick Watkins (mick.watkins@broadcom.com) |
| **Licence footprint** | See `VMWare Host Reporting Feb 2026_Dave Nelson.xlsx` |

**Architecture notes**:
- All designs involving on-prem compute must flag the October 2026 VMware renewal decision point
- The options assessment (`To VMWare or not to VMware - Options`) must be presented to ARB by Q2 2026
- Do not approve multi-year VMware-dependent designs without confirming the renewal decision path
- See [Technical Debt & Platform Currency](../../business-strategy/references/technical-debt-platform-currency.md)

---

### Dynatrace

| Item | Detail |
|------|--------|
| **Relationship type** | SaaS subscription — Host Unit (HU) and DPS (Davis Platform Subscription) based |
| **Products** | Full-stack APM, infrastructure monitoring, synthetic monitoring, security analytics |
| **Instance** | https://zoh82166.apps.dynatrace.com |
| **Licensing model** | Host Units (HUs) per monitored host; DPS for serverless/containers |
| **Key contact (internal)** | Joseph Pemberton (JP), Robbie Frodsham, Navid Hussein |
| **Pricing note** | Dynatrace HU costs must be included in every BoM for AWS and Azure hosted solutions |

**Architecture notes**:
- Dynatrace is the strategic APM platform; AppDynamics, Nagios are Containment/Retired
- All production workloads must have Dynatrace OneAgent deployed
- SRE configuration managed via GitHub: `emisgroup/emishealth-sre-config` and `emisgroup/emisx-sre-config`
- Include Dynatrace HU costs in BoMs: typically 1 HU per production host; 0.5 HU for Dev/Test

---

### ServiceNow

| Item | Detail |
|------|--------|
| **Relationship type** | SaaS licence |
| **Products** | ITSM (incident, change, problem, request), CMDB, ITOM (IT Operations Management) |
| **Key contacts (internal)** | Aaron Riley (Account Manager), James Croll, Ben De Caet, Sam Hart |
| **Pricing model** | Licence per fulfilment user; consumption-based for ITOM Discovery |

**Architecture notes**:
- All production changes must go through ServiceNow change management
- CMDB must be updated for all new CI (Configuration Items); automate via ITOM Discovery or ADO pipeline where possible
- ITOM integration with Backstage is in progress (Aaron Riley, Sam Hart, JP, Robbie Frodsham)

---

### CrowdStrike

| Item | Detail |
|------|--------|
| **Relationship type** | Enterprise SaaS subscription |
| **Products** | Falcon EDR, prevention policies |
| **Key contacts (internal)** | Chris Watts, Daniel Kaminski, David Gee, Abbie Bowes |
| **Deployment** | IaC-deployed; PowerShell or baked into EC2 AMI; rolled out by Group Security |

**Architecture notes**:
- All in-scope hosts (Windows and Linux VMs/EC2) must have CrowdStrike Falcon deployed
- Containers and the EXA platform are **not** currently covered — document as known gap
- Prevention policies are managed by Group Security; coordinate rollout via CICD pipeline owners
- ARMIS detects if CrowdStrike is absent on a VM/EC2 — ensure ARMIS scans the estate

---

### Tenable / Nessus

| Item | Detail |
|------|--------|
| **Products** | Tenable.io (cloud), Nessus vulnerability scanner |
| **Owners (internal)** | David Gee, David Vine (ESRO) |
| **Migration status** | Migrating from on-prem Nessus to Tenable.io cloud platform (port 443) |

**Architecture notes**:
- Agent-only deployments (AWS, DHCW, Doncaster) transitioning to Tenable.io
- Dedicated scanner deployments remain for Gibraltar, Watford, Leeds DCs
- New deployments must use Tenable agent-based scanning — do not deploy legacy Nessus scanners

---

### Delinea (Secret Server / PAM)

| Item | Detail |
|------|--------|
| **Products** | Delinea Secret Server (PAM), Distributed Engines (DDE) |
| **Access URL** | https://emis.delinea.app/view/auth/start |
| **Owners (internal)** | David Gee, Mark Howis, Daniel Kaminski, William Macpherson |
| **DDE footprint** | AWS, Azure, ZPA (individual endpoints), DevTest (reduced launchers); being deployed to VMware platforms |

**Architecture notes**:
- All privileged access (admin accounts, service accounts with elevated rights) must be managed through Delinea Secret Server
- SSH proxy functionality required for Pinnacle (Mark Howis)
- Syslog from Delinea must be forwarded to the SIEM platform
- New environments (VMware, cloud accounts) must have DDE deployed before go-live

---

### Palo Alto Networks

| Item | Detail |
|------|--------|
| **Products** | Next-generation firewalls (on-prem); potentially Prisma Cloud |
| **Key contact** | Dave Nelson (Network Operations) |

---

## Licence Governance Principles

### Licence Compliance Checklist

When specifying software in a design or BoM, validate:

- [ ] **BYOL vs. included** — Is the licence included in the cloud service price (e.g., managed OS in PaaS) or must it be brought from existing entitlements (BYOL)?
- [ ] **Core-based vs. user-based** — SQL Server, Windows Server Datacenter pricing is per core; ensure the VM/host core count is accurately reflected
- [ ] **AHUB eligibility** — Windows Server and SQL Server with active SA can apply Azure Hybrid Benefit (~40-55% saving); confirm SA status with Procurement before assuming AHUB
- [ ] **Dev/Test pricing** — Non-production Azure environments should use Dev/Test subscription pricing where applicable
- [ ] **Subscription vs. perpetual** — Cloud licensing is typically subscription; on-prem may be perpetual + SA; model both in TCO
- [ ] **Virtualisation licensing** — VMware Datacenter licensing covers unlimited VMs on licensed hosts; check this covers the proposed extra VMs
- [ ] **Per-seat vs. concurrent** — Some products (e.g., Dynatrace, Delinea) charge per connected user or host; ensure quantities in BoM are accurate

### Vendor Lock-In Risk Register

Complete for any vendor where EMIS/Optum has significant dependency:

| Vendor | Products | Annual Spend (approx.) | Lock-In Risk | Portable Alternative | Switching Cost (estimate) | Risk Rating |
|--------|---------|----------------------|-------------|---------------------|--------------------------|------------|
| Microsoft | Azure, M365, SQL Server | [INTERNAL] | Medium | AWS, GCP, PostgreSQL | High — data migration, retraining | Medium |
| AWS | Primary cloud | [INTERNAL] | Medium | Azure, GCP | High — IaC rework, service remapping | Medium |
| Broadcom/VMware | vSphere, vSAN | [INTERNAL] | High | Nutanix, cloud migration | High — hardware, retraining, migration | **High** |
| Dynatrace | APM, monitoring | [INTERNAL] | Medium | Datadog, New Relic | Medium — agent swap, dashboard re-creation | Medium |
| ServiceNow | ITSM, CMDB | [INTERNAL] | High | Jira Service Management | Very High — process re-engineering, data migration | **High** |
| CrowdStrike | EDR | [INTERNAL] | Low-Medium | SentinelOne, Microsoft Defender | Low — agent swap | Low |

> **Action**: Vendors rated **High** lock-in risk must have a documented mitigation strategy or a risk-accepted position signed by the CISO/CTO.

---

## Vendor Performance & Review

| Activity | Frequency | Owner |
|----------|-----------|-------|
| Cloud spend review (AWS + Azure) | Monthly | CloudOps (Rich Davies, Matt Jackson, Nabeel) |
| FinOps / Savings Plan coverage review | Quarterly | CloudOps + Architecture |
| Vendor licence compliance audit | Annually | Procurement + Architecture |
| VMware renewal assessment | Before October 2026 | Architecture (ARB submission Q2 2026) |
| Microsoft EA true-up | Annually | Procurement |
| Dynatrace HU utilisation review | Quarterly | Monitoring team (JP, Robbie Frodsham) |
