# Confluence Space Index & Internal URL Registry

> **Classification**: Internal  
> **Purpose**: Master consolidated index of all key Confluence spaces, key page URLs, and internal tooling links referenced across Atlas_Architect skills. Use this as the single lookup point for internal source locations.

---

## Confluence Spaces

| Space | Space Key | Primary URL | Purpose |
|-------|-----------|-------------|---------|
| **Architecture** | ARCH | https://emishealthgroup.atlassian.net/wiki/spaces/ARCH | Architecture standards, HLD/LLD templates, ADRs, technology decisions, WAF guidance |
| **Infrastructure Knowledge Base** | ARCH | https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/7881818337 | Architecture knowledge base tracker — knowledge gaps, regional coverage, vendor contacts |
| **Brisbane (PBA)** | PBA | https://emishealthgroup.atlassian.net/wiki/spaces/PBA | Brisbane project documentation, LLDs, operational procedures |
| **HEPK / Infrastructure Engineering** | HEPK | https://emishealthgroup.atlassian.net/wiki/spaces/HEPK | VMware management, vCenter, on-premises infrastructure operational knowledge |
| **Hosting Services** | HS | https://emishealthgroup.atlassian.net/wiki/spaces/HS | Hosted Services LLDs, expansion designs, data centre operations |
| **Elvis / Rising Sun (Security)** | Elvis | https://emishealthgroup.atlassian.net/wiki/spaces/Elvis | Rising Sun security programme — CrowdStrike, Tenable, Delinea, Darktrace deployment |
| **PIMS** | PIMS | [INTERNAL — populate: PIMS space URL] | PIMS operating model, service catalogue, team runbooks, on-call procedures |

---

## Key Architecture Pages

| Page | URL | Notes |
|------|-----|-------|
| **Infrastructure Architecture Knowledge Base Tracker** | https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/7881818337/Infrastructure+Architecture+Knowledge+Base+Tracker | Master list of known/unknown architecture areas and coverage |
| **Solution Design Template (HLD/LLD)** | https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6350569511/Solution+Design+Template | Official template for all HLD and LLD documents |
| **Well-Architected Framework Checklist** | https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6887803190/Well+Architected+Framework+Checklist | Internal WAF review checklist for design validation |
| **Well-Architected Framework in Healthcare** | https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6535824823/Well+Architected+Framework+in+Healthcare | Healthcare-specific WAF guidance and risk considerations |
| **Architectural Goals** | https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/7781941249/Architectural+Goals | Strategic architecture objectives and principles |
| **Technology Choices & Benefits** | https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6570770654/Technology+Choices+and+Benefits | Approved technology decisions with rationale |
| **Adelaide Architecture (AWS)** | https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6499991902/Adelaide+Architecture | AWS architecture reference design (primary cloud) |
| **LLD Wales Expansion 2024** | https://emishealthgroup.atlassian.net/wiki/spaces/HS/pages/7006814862/LLD+WALES+Expansion+2024 | Example on-premises expansion LLD (Hosting Services) |
| **VMware vCenter Login Instructions** | https://emishealthgroup.atlassian.net/wiki/spaces/HEPK/pages/6253838337/VMware+-+vCenter+Login+Instructions | VMware access guide for infrastructure team |
| **PIMS Work Ingress Process** | [INTERNAL — populate: PIMS Confluence page URL] | How demands/work enter the PIMS team (CloudOps, SRE, DBA, Platforms, Operations, FinOps) |

---

## Internal Engineering & Developer Portals

| Tool | URL | Purpose |
|------|-----|---------|
| **Backstage / Hub (IDP)** | https://hub.emis-x.uk/ | Internal Developer Portal — Software Catalog, gold path templates, TechDocs, component registry |
| **Platform Engineering Docs** | https://engineering.emis-x.uk/docs/category/platform-engineering | Platform Engineering hub, Backstage guides, IaC standards |
| **SRE Docs** | https://engineering.emis-x.uk/docs/category/site-reliability/ | SRE runbooks, Dynatrace configuration guides, monitoring standards |

---

## GitHub — EMIS Group Repositories

| Repository | URL | Purpose |
|------------|-----|---------|
| **emisgroup (Organisation)** | https://github.com/emisgroup | Root organisation — all EMIS/Optum engineering repositories |
| **emisx-engineering** | https://github.com/emisgroup/emisx-engineering | Platform Engineering, Backstage IDP, gold path templates, IaC modules |
| **emishealth-sre-config** | https://github.com/emisgroup/emishealth-sre-config | Dynatrace SRE configuration for England/Nations (EMISWeb, CCMH, GPES, EMIS Connect) |
| **emisx-sre-config** | https://github.com/emisgroup/emisx-sre-config | Dynatrace SRE configuration for EMIS-X, EXA, PFS, Community Pharmacy, Pathway |

> **Note**: Additional IaC repositories (Terraform modules, Bicep templates, Ansible playbooks) are held within the emisgroup GitHub organisation. Check Azure DevOps for pipeline-linked IaC repos under each outcome team's project.

---

## Demand Management & Backlog

| Tool | URL | Purpose |
|------|-----|---------|
| **Aha! — Hosted Services Pivot** | https://optum.aha.io/bookmarks/custom_pivots/7631534830970022767 | Hosted Services demand view — architecture triage and capacity planning |
| **Aha! — Platform Engineering Pivot** | https://optum.aha.io/bookmarks/custom_pivots/7631536791781662911 | Platform Engineering demand view — IDP, cloud foundations, tooling |
| **ServiceNow — Change Management** | [INTERNAL — populate: ServiceNow instance URL]/change | Change requests, CAB records, RFC tracking |
| **ServiceNow — CMDB** | [INTERNAL — populate: ServiceNow instance URL]/cmdb | Configuration Items, infrastructure topology, relationship maps |
| **ServiceNow — Incident Management** | [INTERNAL — populate: ServiceNow instance URL]/incident | Incident triage, P1/P2 bridge records, PIR links |
| **Azure DevOps — El Capitan Board** | [INTERNAL — populate: ADO project URL]/boards | El Capitan team (CloudOps) sprint board and backlog |
| **Azure DevOps — Blanc Board** | [INTERNAL — populate: ADO project URL]/boards | Blanc team sprint board and backlog |
| **Azure DevOps — Everest Board** | [INTERNAL — populate: ADO project URL]/boards | Everest team sprint board and backlog |
| **Azure DevOps — Snowden Board** | [INTERNAL — populate: ADO project URL]/boards | Snowden team sprint board and backlog |
| **Azure DevOps — Genesis AI Board** | [INTERNAL — populate: ADO project URL]/boards | Genesis AI team sprint board and backlog |

---

## Cloud Consoles & Monitoring

| Tool | URL | Purpose |
|------|-----|---------|
| **Azure Portal** | https://portal.azure.com | Azure resource management; use SSO with UHG/Optum credentials |
| **AWS Console** | https://console.aws.amazon.com | AWS resource management; assume role via Identity Center |
| **Dynatrace** | https://zoh82166.apps.dynatrace.com/ui/apps/dynatrace.dashboards/dashboards | Observability dashboards, service topology, APM |
| **Dynatrace — Logs** | https://zoh82166.apps.dynatrace.com/ui/apps/dynatrace.logs/ | Centralised log management and search |
| **Dynatrace — Problems** | https://zoh82166.apps.dynatrace.com/ui/apps/dynatrace.problems/ | Active problems, alerts, and anomaly detection |

---

## Operational & Security Tools

| Tool | URL | Purpose |
|------|-----|---------|
| **CrowdStrike Falcon** | https://falcon.crowdstrike.com | EDR/AV console — endpoint management, threat hunting, detections |
| **Tenable.io** | https://cloud.tenable.com | Vulnerability scanning, agent management, compliance reporting |
| **Delinea Secret Server** | [INTERNAL — populate: Delinea instance URL] | Privileged Access Management — secret checkout, SSH proxy, SIEM forwarding |
| **Palo Alto Panorama** | [INTERNAL — populate: Panorama URL] | Centralised firewall policy management |
| **Darktrace** | [INTERNAL — populate: Darktrace console URL] | Network AI threat detection and autonomous response |

---

## Maintenance

- This index should be updated whenever a new internal tool URL, Confluence space, or GitHub repository is added to any skill reference file.
- Review this index quarterly to verify URLs remain valid and placeholder values ([INTERNAL — populate: ...]) are replaced with actual links.
- Owner: Infrastructure Solutions Architecture team.
