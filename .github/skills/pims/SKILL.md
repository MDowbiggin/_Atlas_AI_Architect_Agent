---
name: pims
description: "Platforms Infrastructure Managed Services (PIMS) operating model and cross-team coordination. Use when: designing for operational handover, understanding PIMS service catalogue, coordinating with CloudOps/SRE/DBA/Platforms/Operations/FinOps teams, defining SLAs/OLAs, planning BAU transitions, understanding PIMS team structure, or identifying the correct outcome team (El Capitan, Everest, Blanc, Snowden, Genesis AI)."
---

# Platforms Infrastructure Managed Services (PIMS)

## When to Use

- Designing a solution that will be operated and maintained by PIMS
- Planning the handover from project delivery to BAU operations
- Understanding the service catalogue and what PIMS supports
- Defining Service Level Agreements (SLAs) or Operational Level Agreements (OLAs)
- Coordinating with CloudOps, SRE, DBA, Platforms, Operations, or FinOps disciplines
- Engaging the SRE team for observability design, synthetic monitoring, or reliability scoring
- Understanding the DBA function's scope for database platform management, backup, and HA/DR
- Working with FinOps on cloud cost governance, reserved capacity strategy, or spend optimisation
- Assessing operational readiness for a new or modified service
- Identifying PIMS tools and platforms (Backstage, Dynatrace, Tenable, CrowdStrike, Delinea, Darktrace, ARMIS)
- Understanding PIMS service ownership and key contacts per tool
- Looking up Backstage/IDP configuration, Software Catalog, or gold path templates
- Configuring or querying Dynatrace SRE dashboards and GitHub config repos
- Understanding Delinea Secret Server footprint and PAM deployment locations
- Checking VMware vSAN/vCenter estate, gold standard practices, or renewal timelines
- Understanding cloud account read-only access (AWS Holistic-Viewer, Azure Global Reader)
- Identifying which outcome team owns a workstream (El Capitan, Blanc, Everest, Snowden, Genesis AI)
- Planning IaC deployment strategy (YAML templates, HCL, ReadMe.md standards)

## PIMS Overview

Platforms Infrastructure Managed Services (PIMS) is the operational function responsible for running, monitoring, maintaining, and supporting EMIS/Optum's infrastructure estate across Azure, AWS, on-premises, and hybrid environments.

### PIMS Mission

To deliver reliable, secure, and cost-effective infrastructure services that enable EMIS/Optum's products and business operations.

### PIMS Operating Principles

1. **Service Excellence** — PIMS delivers to defined SLAs/OLAs; every service has documented operational procedures and measurable uptime targets; underpinning services are continuously monitored
2. **Automation-First** — Manual repetitive tasks are candidates for automation; IaC, AIOps, and self-service tooling reduce toil and human error; automation is a first-class operational output
3. **Documentation-by-Default** — Every service, change, and incident generates updated documentation; Backstage Software Catalog is the target source of truth for service inventory; ReadMe.md and YAML standards apply to all managed services
4. **Security-Embedded** — Security controls are built into operational processes, not bolted on; patching, access management, vulnerability remediation, and PAM coverage are BAU activities
5. **Continuous Improvement** — Post-incident reviews, problem management, and service reviews drive structured improvement; learning from failures is valued and blameless; recurring issues trigger problem records and architectural review
6. **FinOps-Aware** — Infrastructure spend is visible, accountable, and optimised; right-sizing, reserved capacity, tagging compliance, and cost-centre reporting are operational requirements, not just project activities
7. **Outcome-Oriented** — Work is organised into outcome teams (El Capitan, Blanc, Everest, Snowden, Genesis AI) with clear scope and delivery accountability; all work enters via Aha! and is tracked in ADO

### PIMS Scope

| In Scope | Out of Scope |
|----------|-------------|
| Server (VM) management and patching | Application code deployment (Engineering) |
| Cloud platform operations (Azure, AWS) | Application-level debugging (Engineering) |
| Network infrastructure operations | Business application support (App Support teams) |
| Storage and backup management | End-user device management (EUC/Desktop) |
| Monitoring and alerting (Dynatrace, Azure Monitor) | Physical data centre management (Facilities partner) |
| Security infrastructure operations (firewalls, WAF) | Security policy and governance (InfoSec team) |
| Database infrastructure (not application DBA) | Database schema changes (Engineering/DBA) |
| IaC pipeline operations | IaC module development (Architecture/Engineering) |

## PIMS Disciplines

PIMS is structured around six operational disciplines. Each discipline represents a specialist capability area within the PIMS function:

| Discipline | Description | Key Teams / Contacts |
|------------|-------------|----------------------|
| **CloudOps** | Azure and AWS platform operations, resource provisioning, cost monitoring, cloud governance | Rich Davies, Matt Jackson, Nabeel |
| **SRE (Site Reliability Engineering)** | Observability, Dynatrace administration, synthetic monitoring, SLO/SLI management, reliability scoring, incident detection | Joseph Pemberton (JP), Robbie Frodsham, Navid Hussein |
| **DBA (Database Administration)** | Database platform management, backups, performance tuning, high availability, disaster recovery for database tier | [INTERNAL — populate] |
| **Platforms** | Internal Developer Platform (Backstage/IDP), Software Catalog, gold path templates, IaC tooling, automation pipelines | Dario DeVito, Luke Smith, Ian Hardcastle, John-Paul Drawneek |
| **Operations** | Day-to-day service management, ServiceNow ITOM/CMDB, change management, incident management, problem management | Aaron Riley, James Croll, Ben De Caet, Sam Hart |
| **FinOps** | Cloud cost governance, reserved capacity management, tagging compliance, budget vs. actuals reporting, right-sizing recommendations | CloudOps (Rich Davies, Matt Jackson) + Finance BP |

## Team Structure

> The table below reflects the full team roster, mapping individuals to both their discipline and the specialist functions they support.

| Team | Responsibility | Key Contacts |
|------|---------------|-------------|
| **CloudOps** | Azure and AWS platform operations, resource management, cost monitoring | Rich Davies, Matt Jackson, Nabeel |
| **Site Reliability Engineering (SRE)** | Dynatrace administration, dashboard management, synthetic monitoring, SLO/SLI, reliability; Dynatrace community call Thursdays 11:00–12:00 GMT | Joseph Pemberton (JP), Robbie Frodsham, Navid Hussein |
| **Platforms & Engineering** | IaC development, automation, tooling, pipeline management, Backstage/IDP platform | Daniel Kaminski, Dario DeVito, Luke Smith, Ian Hardcastle, John-Paul Drawneek |
| **Network Operations** | Network infrastructure, firewalls, load balancers, DNS, VPN/ExpressRoute | Dave Nelson |
| **Security Operations (ESRO)** | Security tooling, SIEM, vulnerability management, incident response support | David Gee, David Vine, Rob Deery, Abbie Bowes |
| **Database Administration (DBA)** | Database platform management, backups, performance, HA/DR | [INTERNAL — populate] |
| **Operations & Service Management** | ServiceNow ITOM, CMDB management, change management, incident management, process governance | Aaron Riley (Account Manager), James Croll, Ben De Caet, Sam Hart |
| **FinOps** | Cloud cost governance, reserved capacity management (AWS Savings Plans/RIs, Azure RIs), tagging compliance, monthly cost reporting, right-sizing | Rich Davies, Matt Jackson + Finance BP |
| **PAM (Delinea)** | Privileged Access Management, Secret Server, SSH proxy | David Gee, Mark Howis, Daniel Kaminski, William Macpherson |
| **EDR (CrowdStrike)** | Endpoint detection and response, AV platform | Chris Watts, Daniel Kaminski, David Gee, Abbie Bowes |
| **Asset Discovery (ARMIS)** | Network asset discovery, security posture | David Gee, Rob Deery, Abbie Bowes, Martin Ward |

## Outcome Teams (ADO Workstreams)

PIMS delivery work is organised into outcome teams. All work enters via **Aha!** for backlog and roadmap management, then flows into **Azure DevOps (ADO)** workstreams for execution. Each outcome team has a defined scope:

| Outcome Team | ADO Workstream | Scope | Notes |
|---|---|---|---|
| **El Capitan** | BAU Operations | BAU operations, DK & BB, KTLO (Keep The Lights On) metrics, core infrastructure BAU | Primary BAU workstream |
| **Blanc** | Project Delivery | Falklands, Sirona, Jersey, Gibraltar, project delivery, R&D | Project/cross-site delivery |
| **Everest** | Security & ESRO | Security team (ESRO) BAU, security R&D, compliance remediation | Security-focused workstream |
| **Snowden** | Wales Delivery | Wales-specific infrastructure delivery and BAU | Regional delivery workstream |
| **Genesis AI** | AI & Automation | Genesis AI platform, IDP innovation, automation tooling, AI agent development, AIOps | AI/platform innovation workstream |

> Rising Sun Remediation (contacts: Philip Mais / Chris King) is an active cross-team programme tracked separately, not a persistent outcome team.

## Service Catalogue

### Compute Services

| Service | Description | SLA | Support Hours |
|---------|-------------|-----|--------------|
| Azure VM Management | Provisioning, patching, monitoring, backup | 99.9% (zone-redundant) | 24/7 (production) |
| AWS EC2 Management | Provisioning, patching, monitoring, backup | 99.9% (multi-AZ) | 24/7 (production) |
| VMware VM Management | Provisioning, patching, monitoring, backup | 99.9% (HA cluster) | 24/7 (production) |
| AKS Cluster Management | Platform management, upgrades, node pool scaling | 99.95% | 24/7 (production) |
| Azure App Service | Platform management, scaling, certificate management | Per Azure SLA | Business hours + on-call |

### Storage Services

| Service | Description | SLA | Support Hours |
|---------|-------------|-----|--------------|
| Azure Storage Management | Blob, Files, Disks — provisioning, monitoring, lifecycle | Per Azure SLA | Business hours |
| Backup Management | Azure Backup, Veeam — policy management, restore requests | RPO per tier | 24/7 (P1 restore) |
| SAN/NAS Management | NetApp/Dell — volume provisioning, snapshots, replication | 99.99% | 24/7 |

### Network Services

| Service | Description | SLA | Support Hours |
|---------|-------------|-----|--------------|
| Firewall Management | Azure Firewall, Palo Alto — rule management, monitoring | 99.99% | 24/7 |
| Load Balancer Management | Azure LB, App Gateway, F5 — configuration, health monitoring | 99.99% | 24/7 |
| DNS Management | Azure DNS, on-prem DNS — record management | 99.99% | 24/7 |
| ExpressRoute / VPN | Connectivity monitoring, failover management | 99.95% | 24/7 |

### Security Services

| Service | Description | SLA | Support Hours |
|---------|-------------|-----|--------------|
| Vulnerability Management | Scanning, reporting, remediation tracking | Monthly scan cycle | Business hours |
| SIEM Operations | Sentinel / Log Analytics — rule management, alert triage | Real-time | 24/7 (P1/P2) |
| Certificate Management | SSL/TLS certificate provisioning, renewal, monitoring | Pre-expiry renewal | Business hours |
| Identity Operations | Azure AD administration, access provisioning, PIM | Per SLA | 24/7 (access issues) |
### FinOps Services

| Service | Description | SLA | Support Hours |
|---------|-------------|-----|---------------|
| Cloud Cost Reporting | Monthly cost report per cost centre; budget vs. actual; trend analysis | Monthly | Business hours |
| Right-Sizing Recommendations | Utilisation analysis; over-provisioned resource identification; resize recommendations | Quarterly review | Business hours |
| Reserved Capacity Management | AWS Savings Plans/RIs and Azure RIs — purchase decisions, utilisation monitoring, coverage targets | Monthly review | Business hours |
| Tagging Compliance | Tag governance; compliance reporting; untagged resource alerting; chargeback enablement | Continuous | Business hours |
| Cost Anomaly Detection | Monitoring for unexpected spend spikes; CloudOps alerting + monthly review | Continuous | Business hours |
## Operational Level Agreements (OLAs)

### Response and Resolution Times

| Priority | Response Time | Resolution Target | Escalation |
|----------|-------------|-------------------|------------|
| P1 — Critical | 15 minutes | 4 hours | Immediate page to on-call; bridge call |
| P2 — Major | 30 minutes | 8 hours | ServiceNow escalation; team lead notified |
| P3 — Minor | 2 hours | 24 hours (business) | ServiceNow workflow |
| P4 — Low | 4 hours | 5 business days | ServiceNow queue |

### Standard Change Lead Times

| Change Type | Lead Time |
|------------|-----------|
| VM provisioning (from approved template) | 2 business days |
| Firewall rule change | 3 business days |
| DNS record change | 1 business day |
| Storage provisioning | 2 business days |
| Network subnet creation | 5 business days |
| New service onboarding (full stack) | By project plan |

## Project to BAU Handover

### Handover Requirements

Before PIMS will accept a new service into BAU operations, the following must be provided:

| Artefact | Description | Owner |
|----------|-------------|-------|
| **HLD** | Approved High-Level Design | Architecture |
| **LLD** | Approved Low-Level Design with configuration details | Architecture |
| **Runbook** | Operational procedures: start/stop, health checks, troubleshooting, DR | Architecture + Engineering |
| **Monitoring** | Dynatrace dashboards, synthetic monitors, alerting rules configured | Architecture + CloudOps |
| **CMDB** | All CIs registered in ServiceNow with relationships | Architecture + PIMS |
| **Access** | Operational team access provisioned to all components | Architecture + Identity |
| **Backup** | Backup configured and first successful backup verified | Architecture + PIMS |
| **DR** | DR procedure documented and tested | Architecture |
| **Knowledge Transfer** | Walkthrough session with PIMS team covering architecture and operations | Architecture |
| **Support Contact** | Escalation contact for application-level issues | Engineering / Product |

### Handover Checklist

- [ ] HLD approved and stored in SharePoint/Confluence
- [ ] LLD approved and stored in SharePoint/Confluence
- [ ] Runbook created and published to ServiceNow Knowledge Base
- [ ] Dynatrace monitoring configured and dashboards created
- [ ] Alerting rules configured (P1-P4 mapping)
- [ ] CMDB updated with all CIs and relationships
- [ ] Backup configured, tested, and documented
- [ ] DR procedure documented and tested
- [ ] Operational team access verified
- [ ] Knowledge transfer session completed
- [ ] Change management handover (who approves changes to this service?)
- [ ] Cost centre and budget holder confirmed for ongoing operational costs

## PIMS Tools & Platforms

| Tool / Platform | Category | Key URLs / Notes |
|-----------------|----------|-----------------|
| **Backstage (Hub)** | Internal Developer Platform (IDP) | https://hub.emis-x.uk/ — Software Catalog, Templates, TechDocs |
| **Dynatrace** | Observability / SRE | https://zoh82166.apps.dynatrace.com/ui/apps/dynatrace.dashboards/dashboards |
| **Tenable Nessus / tenable.io** | Vulnerability Management | Migrating to tenable.io on port 443; docs: https://docs.tenable.com/agent.htm |
| **CrowdStrike Falcon** | EDR / AV | Deployed via IaC (PowerShell / EC2 AMI); dashboard: https://falcon.crowdstrike.com |
| **Delinea Secret Server** | PAM | https://emis.delinea.app/view/auth/start |
| **Darktrace** | Network AI Threat Detection | OVA appliances at Wales (×2), Gibraltar (×2), Leeds (×2), Jersey (TBC) |
| **ARMIS** | Asset Discovery | Network-scanned; used to detect assets missing CrowdStrike |
| **VMware vSAN/vCenter** | Virtualisation | Renewal Oct 2026; read-only access via vCenter Login Instructions |
| **Azure DevOps (ADO)** | Work Management | El Capitan, Blanc, Everest, Snowden workstreams |
| **AHA** | Backlog & Roadmap | Feeds ADO workstreams |
| **ServiceNow ITOM** | IT Operations Management | Integration in evaluation |
| **Genesis AI Platform** | AI/IDP | https://hub.emis-x.uk/catalog/platform/component/genesis |
| **GitHub Copilot (VSC)** | AI Tooling | Claude Sonnet 4.6, Claude Opus 4.6, GPT-Codex 5.3 |
| **Confluence Rovo Bot** | AI Tooling | Atlassian AI assistant |

## SLA

| Metric | Value |
|--------|-------|
| Availability | 24/7 × 365 |
| Classification | Critical underpinning service |
| Monthly Uptime Target | **99.9%** |

## References

- [PIMS Operating Model](./references/pims-operating-model.md) — Detailed processes, escalation paths, and interaction model
- [PIMS Services & Solutions Roadmap](./references/pims-services-roadmap.md) — Tool overviews, key contacts, deployment locations, URLs, and IaC strategy (source: REVIEW DRAFT, Mar 2026)
