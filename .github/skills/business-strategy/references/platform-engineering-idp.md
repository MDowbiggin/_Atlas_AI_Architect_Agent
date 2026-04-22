# Platform Engineering & Internal Developer Platform (IDP)

## Overview

EMIS/Optum's Internal Developer Platform (IDP) is built on **Backstage** (by Spotify) and operated by the Platform Engineering team. It provides the software catalog, gold path templates, TechDocs, and plugin integrations that enable self-service infrastructure provisioning and standardised operations across all teams.

> **Mandate**: All new solutions must be registered in the Backstage Software Catalog at go-live. Gold path templates (not bespoke provisioning) are the default for standard infrastructure patterns.

---

## Platform Engineering Resources

| Resource | Link |
|----------|------|
| Platform Engineering Hub (Docs) | https://engineering.emis-x.uk/docs/category/platform-engineering |
| Backstage IDP UI | https://hub.emis-x.uk/ |
| Genesis AI Component | https://hub.emis-x.uk/catalog/platform/component/genesis |
| Community Teams Channel | community-platform \| Technology Communities \| Microsoft Teams |
| Backstage Plugin Registry | https://backstage.io/plugins/ |
| EMIS Backstage Plugins Repo | https://github.com/emisgroup/emisx-dev-portal/tree/main/plugins |
| TechDocs Features | https://backstage.io/docs/features/techdocs/ |
| EMIS-X Engineering GitHub (Backstage reference repo) | https://github.com/emisgroup/emisx-engineering |
| Aha! Platform Engineering Roadmap | https://optum.aha.io/bookmarks/custom_pivots/7582519213095880525/7612678779668930546 |

### Key Contacts

| Name | Role |
|------|------|
| Dario DeVito | Platform Engineering Lead — Backstage, IDP, Genesis AI |
| Luke Smith | Genesis Platform |
| Ian Hardcastle | Platform Engineering |
| John-Paul Drawneek | Platform Engineering |
| Robbie Frodsham | Monitoring & Observability, Platform Engineering |

---

## Backstage Core Capabilities

### Software Catalog

The Software Catalog is the single source of truth for all services, systems, and components deployed by EMIS/Optum.

**What it provides**:
- Discovery and ownership tracking for all services, APIs, libraries, and infrastructure
- Dependency mapping between components
- Integration with GitHub repos, Dynatrace, PagerDuty, ServiceNow ITOM

**Architecture requirement**: Every new solution HLD must include a Software Catalog entry design specifying:
- Component name, type (service, website, library, infrastructure)
- Owner (team)
- System membership
- API definitions
- Links to GitHub repo, Confluence runbook, and Dynatrace dashboard

### Gold Path Templates

Gold paths are opinionated, pre-approved templates for common infrastructure and application patterns. They enforce EMIS/Optum standards (security controls, tagging, IaC structure) at the point of provisioning.

**Available gold path categories** (confirm current list with Platform Engineering):
- Spinning up REST APIs
- New GitHub repository creation with guardrails
- Infrastructure provisioning templates (YAML-based)

**Architecture requirement**: If no gold path exists for the pattern in a new design, the architecture team must raise a Platform Engineering backlog item to create one. Bespoke one-off provisioning without a template path requires sign-off.

### TechDocs

TechDocs renders Markdown documentation stored in GitHub repositories directly inside the Backstage catalog. Every catalogued component should have a corresponding `/docs` folder with a `mkdocs.yml` and documentation in Markdown.

**Standard TechDocs structure**:
```
/docs
    index.md          # Service overview
    architecture.md   # Links to HLD/LLD in Confluence or embedded diagrams
    runbook.md        # Operational runbook (or link to ServiceNow KB)
    dependencies.md   # Upstream/downstream dependencies
    oncall.md         # On-call contacts and escalation path
```

### Plugin Integrations

| Plugin | Integration Purpose | Status |
|--------|-------------------|--------|
| **PagerDuty** | Incident status and on-call schedule in catalog | Active |
| **ServiceNow ITOM** | CI/CD-driven CMDB updates; automated ticket creation | In progress (Aaron Riley, Sam Hart, Ben De Caet, James Croll) |
| **Dynatrace** | SRE dashboards and service health in catalog | Active (JP, Robbie Frodsham, Navid Hussein) |
| **GitHub** | Repo metadata, PR status, pipeline status | Active |

---

## PIMS Delivery Workstreams

PIMS work is organised into four ADO Kanban-based workstreams. Architects must know the correct workstream to route demands and track IaC/automation work.

| Workstream | Focus | Owners | Type |
|-----------|-------|--------|------|
| **El Capitan** | BAU / KTLO (Keep the Lights On); infrastructure reliability, patching, operational improvements | Daniel Kaminski (DK), BB | BAU |
| **Everest** | Security-focused outcomes; ESRO-led security tooling and controls | Security / ESRO (Rob Deery, David Gee) | BAU |
| **Snowden** | Wales delivery; project-specific infrastructure | Project delivery | Project |
| **Blanc** | Falklands, Sirona, Jersey, Gibraltar delivery; project-specific | Project delivery (Rob Deery) | Project |

**PIMS Confluence Space**: [PIMS Work Ingress Process](https://confluence.emis.com) — all new PIMS work enters via here.

---

## IaC Deployment Standards for Platform Engineering

All infrastructure deployed through Platform Engineering gold paths follows this three-layer standard. Architects must design solutions that produce all three artefacts.

### Layer 1 — YAML Templates

Purpose: Standard and core infrastructure configuration; define what a solution is made up of.

**Must include**:
- Service name, tier, environment
- Core infrastructure components (compute, networking, storage, database)
- Reference Architecture pointer (link to HLD/LLD in Confluence)
- For VMware workloads: ESXi cluster, vSAN configuration, network port group details (use Daniel Kaminski's VMware guide as template)
- Resource tags (mandatory: `CostCentre`, `Environment`, `Owner`, `Application`, `Project`, `ManagedBy`)

**Standards**: Follow Platform Engineering YAML template guide — confirm current template with Daniel Kaminski or the El Capitan backlog.

### Layer 2 — ReadMe.md

Purpose: Human-readable service/solution description that Backstage TechDocs renders.

**ReadMe.md required sections**:
```markdown
## [Service/Solution Name]

### Purpose
Brief description of what the service/solution does and who it serves.

### Architecture
Link to HLD/LLD in Confluence.
Mermaid diagram (Level 2 Container diagram minimum).

### Components
| Component | Technology | Hosting | Owner |
|-----------|-----------|---------|-------|

### Dependencies
| Upstream | Interface | Protocol |
| Downstream | Interface | Protocol |

### SLA & Service Tier
- Tier: [1/2/3]
- RTO: [Target]
- RPO: [Target]
- On-call: [PagerDuty service name]

### Runbook
Link to ServiceNow Knowledge Base article or Confluence runbook page.

### Monitoring
Link to Dynatrace dashboard.

### Contacts
| Role | Name |
```

**Validation**: ReadMe.md is reviewed by the Infrastructure Architecture team as part of operational readiness gate before go-live.

### Layer 3 — HCL (Terraform)

Purpose: Machine-executable infrastructure definition; the source of truth for deployed configuration.

**Standards**:
- Follow [Automation & IaC Standards](../../technology-roadmap/references/automation-iac.md) for module structure, state backend, and naming conventions
- HCL files must pass `terraform validate` and `terraform plan` before merging to main branch
- State stored in S3 (AWS) or Azure Storage Account with DynamoDB/Blob lock
- Modules sourced from approved EMIS/Optum Terraform module registry (not raw Terraform Registry)
- HCL reviewed as part of Phase G (Implementation Governance) architecture check

---

## Mermaid for Automated Diagrams

Visual Studio Code and Confluence both support Mermaid for diagram generation. The automated documentation pipeline will use Mermaid to build single confluence-page overviews from YAML, ReadMe.md, and HCL inputs.

**Proven pattern**:
```
YAML + HCL inputs → AI Agent (Atlas_Architect / Copilot) → Mermaid .md → Confluence page
```

**Mermaid in VMware outputs**: Under investigation (Dave Nelson PoC). VMware-generated outputs may require pre-processing before Mermaid can render topology accurately.

**Current guidance**: Use the C4 Level 2 Container diagram as the standard Mermaid diagram type for all Backstage TechDocs. See [C4 Model Guide](../../architecture/references/c4-model-guide.md) for templates.

---

## SRE and Dynatrace Integration

Site Reliability Engineering (SRE) configuration is managed via GitHub repos:

| Repo | Scope |
|------|-------|
| `emisgroup/emishealth-sre-config` | England & Nations: EMISWeb, CCMH, Clinical Services, GPES, EMIS Connect, self-serve |
| `emisgroup/emisx-sre-config` | EMIS-X, EXA, PFS, Community Pharmacy, Pathway, self-serve |

Both repos have a `README.md` that defines the config structure. Architecture teams must ensure new solutions have SRE config submitted to the appropriate repo as part of the go-live checklist.

- Dynatrace Dashboards: https://zoh82166.apps.dynatrace.com/ui/apps/dynatrace.dashboards/dashboards
- Platform Engineering SRE Docs: https://engineering.emis-x.uk/docs/category/site-reliability/

---

## Architecture Handover to Platform Engineering — Checklist

When a new solution design reaches Operational Readiness Gate, confirm the following:

- [ ] Backstage Software Catalog entry designed (component type, owner, system, APIs)
- [ ] TechDocs `/docs` folder structure defined in the GitHub repo
- [ ] ReadMe.md written and reviewed against the standard template above
- [ ] YAML template created or existing gold path template identified
- [ ] HCL Terraform code reviewed against IaC standards
- [ ] Mermaid C4 Level 2 diagram included in TechDocs
- [ ] SRE config submitted to appropriate `emishealth-sre-config` or `emisx-sre-config` repo
- [ ] Dynatrace dashboard created and linked from catalog entry
- [ ] PagerDuty service configured and linked
- [ ] ServiceNow CMDB CIs created or will be auto-created via ITOM pipeline
- [ ] Platform Engineering team notified of new service onboarding (create item in El Capitan backlog)
