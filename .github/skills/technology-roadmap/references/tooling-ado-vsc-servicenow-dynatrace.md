# Tooling Standards — ADO, VS Code, ServiceNow, Dynatrace

## Azure DevOps (ADO)

### Overview

Azure DevOps is the **strategic platform** for source control, CI/CD, work item tracking, and artifact management at EMIS/Optum.

### Organisation Structure

| Level | Standard |
|-------|----------|
| Organisation | EMIS/Optum ADO organisation |
| Project | One project per product/service area |
| Repository | One repo per deployable unit (microservice, IaC module, documentation) |
| Branch Strategy | Trunk-based development; `main` is the production branch |

### Repository Standards

- **Branch Policies on `main`**:
  - Minimum 1 reviewer (2 for production IaC)
  - Build validation (CI must pass)
  - Comment resolution required
  - Linked work items required
- **Branch Naming**: `feature/<ticket>-<description>`, `bugfix/<ticket>-<description>`, `hotfix/<ticket>-<description>`
- **Commit Messages**: `<type>(<scope>): <description>` (e.g., `feat(networking): add private endpoint for SQL`)

### Pipeline Standards

- See [Automation & IaC](./automation-iac.md) for pipeline templates
- **Environments**: Dev, Test, Staging, Production — with approval gates on Staging and Production
- **Service Connections**: Managed Identity preferred; Service Principal with certificate (no password)
- **Agents**: Self-hosted agents on Azure VMs within the EMIS/Optum VNet for network access to private resources

### Work Item Tracking

- **Boards**: Use ADO Boards for sprint planning (where Agile is used)
- **Work Item Types**: Epic → Feature → User Story → Task / Bug
- **Linking**: All PRs must link to a work item; all deployments must reference a change request

## VS Code

### Overview

Visual Studio Code is the **standard IDE** for infrastructure code, documentation, and automation scripts.

### Recommended Extensions

| Extension | Purpose |
|-----------|---------|
| HashiCorp Terraform | Terraform syntax, validation, autocomplete |
| Azure Tools | Azure resource management from VS Code |
| Bicep | Azure Bicep language support |
| Ansible | Ansible playbook editing |
| YAML | YAML syntax and validation |
| Mermaid Preview | Diagrams-as-code preview |
| Draw.io Integration | draw.io diagrams within VS Code |
| GitLens | Enhanced Git history and blame |
| Copilot | AI-assisted coding (Atlas_Architect agent) |
| Remote - SSH | Remote development on jump servers |
| Prettier | Code formatting |

### Workspace Settings

```json
{
  "editor.formatOnSave": true,
  "editor.rulers": [120],
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "[terraform]": {
    "editor.defaultFormatter": "hashicorp.terraform"
  },
  "[bicep]": {
    "editor.defaultFormatter": "ms-azuretools.vscode-bicep"
  }
}
```

## ServiceNow

### Overview

ServiceNow is the **strategic ITSM platform** for incident management, change management, request fulfilment, and Configuration Management Database (CMDB).

### Key Modules

| Module | Use Case | Infrastructure Architecture Touchpoints |
|--------|----------|----------------------------------------|
| Incident Management | P1-P4 incident lifecycle | Root cause analysis; design improvements from post-incident reviews |
| Change Management | Normal, Standard, Emergency changes | All production changes require an approved change request |
| Request Fulfilment | Service requests and catalogue items | Demand intake; new infrastructure requests |
| CMDB | Configuration Items, relationships, attributes | All infrastructure CIs must be registered; used for impact analysis |
| Knowledge Base | Runbooks, procedures, known errors | Architecture decisions and standard procedures documented here |

### Change Management Process

| Change Type | Approval | Lead Time | Use Case |
|-------------|----------|-----------|----------|
| Standard | Pre-approved (template) | Immediate | Routine, low-risk, repeatable changes |
| Normal | CAB / delegated approval | 5 business days minimum | All other changes |
| Emergency | Emergency CAB | Expedited | Critical production incidents |

**Architecture Involvement**:
- Normal changes for new infrastructure or architectural modifications require architecture sign-off
- Reference HLD/LLD and ADR in change request for traceability
- Post-implementation review to validate design conformance

### CMDB Standards

- **CI Registration**: All server, network, application, and cloud resource CIs must be registered
- **Relationships**: Map dependencies (runs on, connected to, used by) for impact analysis
- **Attributes**: Minimum: Name, IP, Environment, Owner, Application, Tier, OS, Location
- **Reconciliation**: Monthly reconciliation between CMDB and actual infrastructure (Azure/AWS resource lists, VMware inventory)
- **Discovery**: ServiceNow Discovery or Azure/AWS integration for automated CI population

## Dynatrace

### Overview

Dynatrace is the **strategic observability platform** for Application Performance Monitoring (APM), infrastructure monitoring, and digital experience management at EMIS/Optum.

### Deployment Standards

| Component | Standard |
|-----------|----------|
| OneAgent | Deploy on ALL production and pre-production servers (VM, container, bare metal) |
| ActiveGate | Deploy in each network segment that cannot directly reach Dynatrace SaaS |
| Environment | [INTERNAL — populate: Dynatrace environment URL and tenant ID] |
| Host Groups | Organised by: `<environment>-<application>-<tier>` |
| Management Zones | Aligned with application boundaries and team ownership |

### Monitoring Configuration

| Capability | Standard |
|-----------|----------|
| Full-Stack Monitoring | Enabled for all hosts: CPU, memory, disk, network |
| Application Monitoring | Auto-instrumented via OneAgent; custom services tagged |
| Synthetic Monitoring | HTTP monitors for all external URLs; browser monitors for critical user journeys |
| Log Monitoring | Ingest application and infrastructure logs; structured log parsing |
| Database Monitoring | Enabled for all database CIs; query-level visibility |
| Network Monitoring | Enabled for inter-service communication analysis |

### Alerting Standards

| Severity | Dynatrace Event | Integration | Response |
|----------|----------------|-------------|----------|
| P1 — Critical | Problem detected (Infrastructure, Application) | PagerDuty → ServiceNow (auto-create P1 incident) | Immediate response; on-call engagement |
| P2 — Major | Problem detected (slower degradation) | ServiceNow (auto-create P2 incident) | Response within 1 hour |
| P3 — Minor | Custom metric threshold breach | ServiceNow (auto-create P3 incident) | Response within 4 hours |
| Informational | Anomaly detected | Email / Teams notification | Review during business hours |

### Dashboard Standards

- **Application Dashboard**: Response time, throughput, error rate, user experience score (Apdex)
- **Infrastructure Dashboard**: Host health, CPU/Memory/Disk utilisation, network throughput
- **SLA Dashboard**: Availability, performance against SLA targets per service tier
- **Cost Dashboard**: Resource utilisation trends for right-sizing recommendations

### Integration Points

| Integration | Purpose |
|------------|---------|
| ServiceNow | Auto-create incidents from Dynatrace problems; CMDB enrichment |
| Azure Monitor | Forward Azure platform metrics and logs to Dynatrace |
| ADO Pipelines | Deployment events for change correlation |
| PagerDuty | P1 alerting and on-call escalation |
| Ansible Tower / AWX | Auto-remediation runbooks triggered by Dynatrace problems |
