# Atlas_Architect

**AI-powered Infrastructure Solutions Architect agent for EMIS/Optum.**

Atlas_Architect is a VS Code custom agent that assists Infrastructure Solutions Architects with demand reviews, high-level designs (HLD), low-level designs (LLD), cost optimisation, re-platforming assessments, BAU workstreams, commercial bids, architecture decision records, runbooks, and infrastructure design across AWS, Azure, on-prem, VMware, and hybrid environments.

> **Classification**: Internal

---

## Prerequisites

- **VS Code** with [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) and [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat) extensions installed
- A GitHub Copilot licence with agent/chat capabilities enabled
- This repository cloned or opened as a workspace in VS Code

---

## Getting Started

1. **Open this repository** in VS Code.
2. Open **Copilot Chat** (`Ctrl+Shift+I` or via the sidebar).
3. In the chat input, select the **Atlas_Architect** agent from the agent picker (the `@` menu or the agent dropdown at the top of the chat panel).
4. Type your request and press Enter.

### First Interaction

Try one of these to verify the agent is working:

```
Review this demand: We need a new customer-facing web portal hosted in AWS with
PostgreSQL backend, serving ~5,000 concurrent users with 99.9% availability.
```

```
Produce an HLD for migrating our on-prem VMware workloads to AWS.
```

```
Generate a Bill of Materials for a 3-tier web application in eu-west-2.
```

---

## What Atlas_Architect Can Do

| Task | Description |
|------|-------------|
| **Demand Review** | Assess incoming requests for feasibility, complexity, risk, and strategic alignment |
| **HLD / LLD Production** | Generate architecture design documents following TOGAF and Well-Architected principles |
| **Cost Engineering** | Produce Bills of Material (BoM), TCO analyses, and cost optimisation recommendations |
| **Re-platforming Assessment** | Evaluate and plan migrations (lift-and-shift, re-platform, re-architect) |
| **Architecture Decision Records** | Document decisions with options analysis, rationale, and consequences |
| **Commercial / Bid Support** | Support RFP responses, solution costing, and viability assessments |
| **Runbooks** | Generate operational runbooks for BAU handover |
| **IaC Design** | Design Terraform, Ansible, Bicep, and CloudFormation configurations |
| **Compliance Validation** | Check designs against HIPAA, NIST, CIS Level 2, and ISO 27001 baselines |
| **Diagram Generation** | Produce architecture diagrams using Mermaid and draw.io-compatible formats |

---

## Skills

Atlas_Architect has 9 specialist knowledge skills that it loads on-demand. You can explicitly invoke a skill by referencing it in your prompt (e.g., *"using the architecture skill, review this design"*), or the agent will load relevant skills automatically based on your request.

| Skill | Domain | When It's Used |
|-------|--------|----------------|
| `architecture` | TOGAF, Well-Architected Framework, design patterns, C4 modelling | Designing solutions, reviewing architectures, selecting patterns |
| `technology-roadmap` | Approved platforms, deprecated technologies, lifecycle status | Selecting technologies, checking standards, migration paths |
| `security-compliance` | HIPAA, NIST CSF, CIS Level 2, ISO 27001 baselines | Validating designs against compliance controls |
| `sources` | Authoritative source registry (Confluence, CMDB, vendor docs) | Looking up where to find standards, templates, previous designs |
| `business-strategy` | Strategic priorities, cloud migration, cost optimisation, modernisation | Aligning designs with business direction, assessing strategic fit |
| `commercial-sales` | BoM templates, RFP guidance, TCO/ROI models | Costing solutions, preparing bids, commercial feasibility |
| `pims` | PIMS operating model, service catalogue, SLAs, handover | Designing for operational handover, understanding BAU requirements |
| `decision-making` | ADR templates, demand review checklists, option analysis | Documenting decisions, conducting demand reviews, evaluating options |
| `output` | Templates for HLD, LLD, runbooks, cost estimates, diagrams | Producing formal architecture deliverables |

---

## Repository Structure

```
.github/
├── agents/
│   └── atlas-architect.agent.md        # Agent definition (identity, behaviour, constraints)
├── instructions/
│   └── atlas-guardrails.instructions.md # Always-on guardrails (security, compliance, governance)
└── skills/
    ├── architecture/                    # TOGAF, WAF, design patterns
    │   ├── SKILL.md
    │   └── references/
    │       ├── togaf-guidelines.md
    │       ├── well-architected-frameworks.md
    │       └── design-patterns.md
    ├── technology-roadmap/              # Technology standards and lifecycle
    │   ├── SKILL.md
    │   └── references/
    │       ├── aws-standards.md
    │       ├── azure-standards.md
    │       ├── on-prem-vmware.md
    │       ├── networking.md
    │       ├── automation-iac.md
    │       └── tooling-ado-vsc-servicenow-dynatrace.md
    ├── security-compliance/             # Compliance baselines
    │   ├── SKILL.md
    │   └── references/
    │       ├── hipaa-baseline.md
    │       ├── nist-baseline.md
    │       ├── cis-level2-baseline.md
    │       └── iso27001-baseline.md
    ├── sources/                         # Authoritative source registry
    │   └── SKILL.md
    ├── business-strategy/               # Strategic priorities
    │   ├── SKILL.md
    │   └── references/
    │       ├── cost-optimization.md
    │       ├── cloud-migration.md
    │       ├── modernization-replatform.md
    │       └── ma-integration.md
    ├── commercial-sales/                # Costing and bid support
    │   ├── SKILL.md
    │   └── references/
    │       ├── bom-templates.md
    │       ├── rfp-bid-guidance.md
    │       └── costing-models.md
    ├── pims/                            # PIMS operating model
    │   ├── SKILL.md
    │   └── references/
    │       └── pims-operating-model.md
    ├── decision-making/                 # ADRs, demand reviews
    │   ├── SKILL.md
    │   └── references/
    │       ├── adr-template.md
    │       └── demand-review-checklist.md
    └── output/                          # Output templates
        ├── SKILL.md
        └── references/
            ├── hld-template.md
            ├── lld-template.md
            ├── runbook-template.md
            ├── cost-estimate-template.md
            └── diagram-guidelines.md
```

---

## How It Works

### Agent Definition (`.agent.md`)

The [agent definition](.github/agents/atlas-architect.agent.md) defines the agent's identity, behaviour, constraints, escalation criteria, and workflows. It is loaded automatically when you select Atlas_Architect in Copilot Chat.

### Guardrails (`.instructions.md`)

The [guardrails](.github/instructions/atlas-guardrails.instructions.md) are always-on rules that apply to **every interaction**, regardless of which skill is active. They enforce:

- HIPAA compliance (no PHI/PII in outputs)
- Security-by-default (encryption, network segmentation, zero trust)
- Change control (no direct production changes)
- Cost governance (threshold-based escalation)
- Architecture review gates (demand → design → security → cost → operational readiness)

### Skills (`SKILL.md`)

Each skill folder contains a `SKILL.md` that tells the agent what the skill covers and how to use it, plus `references/` files with detailed domain knowledge (templates, standards, guidance). Skills are loaded on-demand to keep the agent's context focused.

---

## Example Prompts

### Demand Review
```
Review this demand: The Clinical Safety team needs a document management system
for storing and versioning clinical safety case reports. Expected 50 users,
500GB storage growing 20% annually. Must meet HIPAA requirements.
```

### Architecture Design
```
Produce an HLD for a new API gateway platform in AWS eu-west-2 serving
internal microservices. Requirements: 99.95% availability, mTLS between
services, auto-scaling 100-10,000 RPS, full audit logging.
```

### Cost Estimate
```
Generate a BoM and 3-year TCO for: 6x m6i.xlarge EC2 instances across 3 AZs,
Aurora PostgreSQL Multi-AZ, Application Load Balancer, 2TB S3 storage,
CloudWatch monitoring, and AWS Backup with cross-region copies.
```

### Migration Assessment
```
Assess the options for migrating our on-prem SQL Server 2016 cluster
(4 nodes, 2TB data, 8,000 TPS peak) to AWS. Consider RDS, Aurora,
and EC2-hosted SQL Server. Produce an options comparison with ADR.
```

### Compliance Check
```
Validate this proposed design against HIPAA and CIS Level 2 baselines:
[paste or describe the design]
```

### Runbook Generation
```
Generate a runbook for the EKS-hosted Patient Portal service, covering
health checks, scaling procedures, failover, common troubleshooting
scenarios, and DR procedures.
```

---

## Customisation

### Updating Skills

To update the agent's knowledge, edit the relevant files under `.github/skills/`. Each skill has:

- **`SKILL.md`** — Skill metadata and loading instructions (update `name` and `description` in the YAML frontmatter)
- **`references/`** — Detailed knowledge files the agent reads when the skill is loaded

The `name` field in each `SKILL.md` must exactly match its parent folder name.

### Updating Guardrails

Edit `.github/instructions/atlas-guardrails.instructions.md` to change always-on rules. The `applyTo: "**"` pattern ensures guardrails apply to all files and interactions.

### Adding New Skills

1. Create a new folder under `.github/skills/` (e.g., `.github/skills/my-new-skill/`)
2. Add a `SKILL.md` with YAML frontmatter:
   ```yaml
   ---
   name: my-new-skill
   description: "Short description of what this skill covers and when to use it."
   ---
   ```
3. Add reference files under `references/` if needed
4. Update the **Skill Loading** section in the agent definition to list the new skill

---

## Internal Placeholders

Several files contain `[INTERNAL — populate...]` placeholders for organisation-specific values (Confluence URLs, IP ranges, team contacts, ADO organisation URL, ServiceNow instance, etc.). These should be populated with real values as they become available.

---

## Contributing

1. Make changes on a feature branch
2. Submit a pull request for peer review
3. Ensure any new skills have correctly formatted `SKILL.md` files
4. Test changes by selecting Atlas_Architect in Copilot Chat and verifying behaviour
