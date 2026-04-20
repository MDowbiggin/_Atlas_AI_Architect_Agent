# PIMS Services & Solutions Overview and Roadmap

> Source: REVIEW DRAFT — PIMS Services & Solutions Overview and Roadmap (Confluence, 30 Mar 2026)
> Status: IN REVIEW | Team Owner: Infrastructure Architecture & Solutions Architecture
> Classification: Internal

---

## Overview & Goals

PIMS (Platforms Infrastructure Managed Services) aims to:

- **MUST**: Automate documentation across cloud and on-premises environments
- **MUST**: Include AI/agent tooling in the documentation pipeline
- **SHOULD**: Automate documentation from VMware vSphere stack and GitHub repositories
- **SHOULD**: Link services to Architecture Landscape, Build Sheets, and Infrastructure Handover pages
- **COULD**: Support MI/IIs discovery reports for migrations

---

## Work Management

### Azure DevOps (ADO) Board

PIMS work is organised across the following ADO workstreams:

| Workstream | Scope |
|------------|-------|
| **El Capitan** | BAU operations, DK & BB, KTLO metrics |
| **Blanc** | Falklands, Sirona, Jersey, Gibraltar, project delivery, R&D |
| **Everest** | Security team / ESRO, BAU, R&D |
| **Snowden** | Wales delivery |
| **Rising Sun Remediation** | Contacts: Philip Mais / Chris King |

**AHA** is used for backlog and roadmap management.

Reference: [PIMS Confluence Work Ingress Process](https://emishealthgroup.atlassian.net/wiki/spaces) (internal)

### SIPs / Workloads / Technical Debt

Key active SIPs:
- Containerise EMISWeb & DB tier into RDS — Owners: Rich Davies, Mic Holden
- 60+ Bastion hosts for remote access (rationalisation in progress)
- Certificate solution roadmap
- Security patching automation

---

## Internal Developer Platform (IDP): Backstage

**What it is**: Open-source IDP created by Spotify built on Node.js and React.

| Capability | Description |
|-----------|-------------|
| Software Catalog | Auto-discovery and documentation of all services and components |
| Software Templates | Gold paths for spinning up APIs, Git repos, and guardrails |
| TechDocs | Markdown documentation rendered inside the catalog |
| Plugins | PagerDuty integration, custom EMIS plugins |

**Key URLs**:
- Platform Engineering Hub: https://engineering.emis-x.uk/docs/category/platform-engineering
- Backstage UI (Hub): https://hub.emis-x.uk/
- Genesis component: https://hub.emis-x.uk/catalog/platform/component/genesis
- Plugin catalogue: https://backstage.io/plugins/
- EMIS-X Engineering GitHub: https://github.com/emisgroup/emisx-engineering

**Key Contacts**: Dario DeVito, Luke Smith (Genesis), Ian Hardcastle, John-Paul Drawneek, Robbie Frodsham

---

## Observability: Dynatrace

**What it is**: SRE and observability platform. Used for dashboards, synthetic monitoring, and alerting across EMIS Health and EMIS-X environments.

| Resource | URL/Notes |
|----------|-----------|
| Dynatrace Dashboards | https://zoh82166.apps.dynatrace.com/ui/apps/dynatrace.dashboards/dashboards |
| SRE Documentation | https://engineering.emis-x.uk/docs/category/site-reliability/ |
| EMISHealth SRE Config (GitHub) | https://github.com/emisgroup/emishealth-sre-config |
| EMIS-X SRE Config (GitHub) | https://github.com/emisgroup/emisx-sre-config |

**EMISHealth SRE repo** covers: England & Nations EMISWeb, CCMH, Clinical Services, GPES, EMIS Connect.
**EMIS-X SRE repo** covers: EMIS-X, EXA, PFS, Community Pharmacy, Pathway.

**Community call**: Thursdays 11:00–12:00 GMT

**Key Contacts**: Joseph Pemberton (JP), Robbie Frodsham, Navid Hussein

---

## Vulnerability Management: Tenable Nessus / tenable.io

**What it is**: Vulnerability scanning platform managed by ESRO. All deployments are migrating to tenable.io Cloud Platform (port 443).

| Deployment Type | Environments |
|----------------|-------------|
| **Agent-only** (no dedicated scanner) | AWS, DHCW, Doncaster |
| **Dedicated Nessus scanner** | Gibraltar (baseline), Watford, Leeds DCs |
| **Also scans** | ESXi VMware clusters, Network Infrastructure |

- Reference docs: https://docs.tenable.com/agent.htm
- Next stage (from Mar 2026): Split out agent-only assets into separate dashboards and services

**Key Contacts** (ESRO platform owners): David Gee, David Vine

---

## Endpoint Detection & Response: CrowdStrike

**What it is**: EDR/AV platform managed by Group Security. PIMS deploys the agent via IaC.

| Aspect | Detail |
|--------|--------|
| Deployment method | PowerShell or baked into EC2 AMI |
| Policy management | Group Security (Prevention Policies) |
| OS support | Auto-detects Windows or Linux |
| Coverage gap | Containers & EXA Platform NOT covered (technical feasibility constraint) |
| Network detection | ARMIS scans for assets missing CrowdStrike |
| Dashboard | https://falcon.crowdstrike.com/dashboards-v2/dashboard/C7A761D3-4D97-42F4-9060-A31E5FE034FB |

**Key Contacts**: Chris Watts, Daniel Kaminski, David Gee, Abbie Bowes

> Rising Sun reference: [Crowdstrike - AV](https://emishealthgroup.atlassian.net/wiki/spaces/Elvis/pages/6836520448/Crowdstrike+-+AV)

---

## Privileged Access Management: Delinea Secret Server

**What it is**: PAM (Privileged Access Management) platform. Also used for SSH proxy (Pinnacle) and syslog forwarding to SIEM.

| Resource | URL/Notes |
|----------|-----------|
| Secret Server URL | https://emis.delinea.app/view/auth/start |
| Delinea Overview (Rising Sun) | [Delinea Secret Server](https://emishealthgroup.atlassian.net/wiki/spaces/Elvis/pages/6836617425/Delinea+Secret+Server) |

**Distributed Engines (DDE) / Launchers**:
- PAM (Password), AWS, Azure, ZPA (Individual Endpoints), DevTest (Reduced Launchers)

**Deployment locations** (VMware platforms):
- UKHosting (Fulford Grange, Leeds)
- Wales
- Gibraltar
- Jersey
- Doncaster

**Roadmap items**:
- AI-assisted review of Delinea session recordings (in evaluation)
- SSH proxy functionality for Pinnacle (owner: Mark Howis)
- Syslog forwarding to SIEM platform

**Key Contacts**: David Gee, Mark Howis, Daniel Kaminski, William Macpherson

---

## Network AI Threat Detection: Darktrace

**What it is**: AI-powered network threat detection. Appliances deployed at key sites. VMware integration PoC in progress (deployed via .OVA ISO from Security team).

| Site | Appliances |
|------|-----------|
| Wales | 2x |
| Gibraltar | 2x |
| Leeds | 2x |
| Jersey | TBC |

**Key Contacts** (ESRO): David Gee, Dave Nelson, Rob Deery, Abbie Bowes

---

## Asset Discovery: ARMIS

**What it is**: Network-based asset discovery and security posture platform. Used to identify all assets including those without CrowdStrike coverage.

- ARMIS API used extensively during Rising Sun migration
- Martin Ward has deep API experience

**Key Contacts**: David Gee, Rob Deery, Abbie Bowes, Martin Ward

---

## Cloud Account Access

### AWS — Read-Only Access (Holistic-Viewer)

Access requires a ticket to SecOps: https://emishealthgroup.atlassian.net/servicedesk/customer/portal/1/group/3/create/10332

**Holistic-Viewer permission set**:
- `ViewOnlyAccess` + `SecurityAudit` + `AWSResourceExplorerReadOnlyAccess`
- Optional: permissions boundary to enforce "no writes / no sensitive reads"

Key contacts for access: Rich Davies, Matt Jackson, Nabeel

### Azure — Read-Only Access

| Detail | Value |
|--------|-------|
| Portal | https://portal.azure.com/ |
| Domain | emishealthenterprise.onmicrosoft.com |
| Tenant / Directory ID | bd16c2b9-cbc8-46b6-892e-36bbe902b867 |
| Access role (all subscriptions) | Microsoft Entra ID 'Global Reader' (Roles & Administrators) |
| Root tenant role | 'EHE Platform Managers' with 'Reader' rights |

---

## Virtualisation Platform: VMware vSAN / vCenter

**Renewal due**: October 2026 (Broadcom licensing)

| Resource | Reference |
|----------|-----------|
| VMware options overview | [To VMWare or not to VMware — Options](https://emishealthgroup.atlassian.net/wiki/spaces/~5c3ef54d9f04e73325c2e7f7/pages/8641020141/To+VMWare+or+not+to+VMware+-+Options) |
| vCenter login guide | [VMware - vCenter Login Instructions](https://emishealthgroup.atlassian.net/wiki/spaces/HEPK/pages/6253838337/VMware+-+vCenter+Login+Instructions) |

**VMware environments in scope**:

| Environment | Reference LLD |
|-------------|--------------|
| Wales | [LLD WALES Expansion 2024](https://emishealthgroup.atlassian.net/wiki/spaces/HS/pages/7006814862/LLD+WALES+Expansion+2024) |
| Jersey | Local ESXi |
| Doncaster | [LLD Doncaster Hardware Refresh](https://emishealthgroup.atlassian.net/wiki/spaces/HS/pages/2245132590/LLD+Doncaster+Hardware+Refresh) |
| Gibraltar | [LLD Gibraltar Hardware Refresh](https://emishealthgroup.atlassian.net/wiki/spaces/HS/pages/7436435610/LLD+Gibraltar+Hardware+Refresh) |
| Leeds DCs | [OUK Hosting On-premises Services](https://emishealthgroup.atlassian.net/wiki/spaces/HS/pages/8267792385/OUK+Hosting+On-premises+Services) |
| Symphony | In scope |

**VMware Gold Standard Best Practice Aims**:
- Implement tagging strategy across vCenter resources
- Implement improved monitoring of vCenter/ESXi and physical infrastructure
- Implement a Syslog tool for vCenter/ESXi
- Implement Infrastructure Reporting — security patches, VMware versions (VMware Skyline Health Diagnostics)
- Domain auth authentication on ESXi Hosts & vCenter
- Password rotation across all VMware products
- Certificate management for VMware products (self-signed or CA-backed)
- Automated patching routines for vCenter + hosts
- Automated capacity reporting
- Deploy VMware Skyline Health Diagnostics Virtual Appliance (**service improvement recommendation**)

**Broadcom/VMware Contacts**:
- Graham Wallace (graham.wallace@broadcom.com) — TAM
- Gareth Edwards (gareth.edwards@broadcom.com)
- Mick Watkins (mick.watkins@broadcom.com)

---

## AI Platforms

### Genesis AI Platform

- Engineering Genesis AI: https://69a6a9b4fc07a0da83d6d9fe--emisx-engineering.netlify.app/genesis-ai/
- Platform Engineering AI Strategy: https://69a6a9b4fc07a0da83d6d9fe--emisx-engineering.netlify.app/docs/platform-engineering/our-strategy/augment-sdlc-with-ai

### AI Tooling in Use (PIMS/Architecture)

| Tool | Notes |
|------|-------|
| GitHub Copilot (VSC) | GPT-Codex 5.3, Claude Sonnet 4.6, Claude Opus 4.6 |
| GitHub Copilot MCP | Build via Genesis Platform |
| Confluence Bot (Rovo) | Atlassian AI assistant |

---

## ITOM via ServiceNow

ServiceNow ITOM integration is being evaluated.

**Key Contacts**: Aaron Riley (Account Manager), James Croll, Ben De Caet, Sam Hart, JP (Joseph Pemberton), Robbie Frodsham

---

## Deployment Strategy

PIMS IaC and documentation deployment strategy:

1. **YAML templates** — standard and core configuration (Core Infrastructure Detail, Reference Architecture, VMware detail — see Daniel Kaminski for guide)
2. **ReadMe.md files** — structured documentation following a defined template; sourced from Reference Architecture
3. **HCL files** — Terraform configuration meeting current standards
4. **Read-only access** (for architects/AI agents) to: all GitHub repos, all AWS/Azure/GCP accounts, VMware vSphere infrastructure
5. **CSV import fallback** — where direct access is not available, CSVs are imported into AI agents/solutions for estate overview
6. **Mermaid in VS Code** — reads YAML, ReadMe, and HCL files to build Confluence page diagrams

---

## SLA

| Metric | Value |
|--------|-------|
| Availability | 24/7 × 365 |
| Classification | Critical underpinning service |
| Monthly Uptime Target | **99.9%** |

---

## Key References

| Reference | Link |
|-----------|------|
| Infrastructure Architecture Knowledge Base Tracker | [Confluence](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/7881818337/Infrastructure+Architecture+Knowledge+Base+Tracker) |
| Solution Design Template | [Confluence](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6350569511/Solution+Design+Template) |
| Well Architected Framework Checklist | [Confluence](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6887803190/Well+Architected+Framework+Checklist) |
| Well Architected Framework in Healthcare | [Confluence](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6573687136/Well+Architected+Framework+in+Health+Care) |
| Architectural Goals | [Confluence](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/7781941249/Architectural+Goals) |
| Technology Choices & Benefits | [Confluence](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6570770654/Technology+Choices+and+Benefits) |
| AWS Adelaide Architecture | [Confluence](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6499991902/Adelaide+Architecture) |
| Brisbane Confluence Space | https://emishealthgroup.atlassian.net/wiki/spaces/PBA |
