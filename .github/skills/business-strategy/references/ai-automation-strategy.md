# AI & Automation Strategy

## Overview

EMIS/Optum's AI and automation strategy is focused on augmenting the engineering and operations SDLC, reducing manual operational effort, and enabling intelligent self-service. The Genesis AI Platform is the internal capability hub. AI agents (Atlas_Architect, GitHub Copilot, Confluence Rovo) are being progressively embedded across teams.

> **Data Protection Constraint**: No PHI/PII may be included in AI model prompts, training data, or outputs without explicit DPO and CISO sign-off. All AI tooling must comply with HIPAA minimum-necessary and EMIS/Optum data classification policies.

---

## AI Platform — Genesis

Genesis is the EMIS/Optum internal AI platform, built and maintained by the Platform Engineering team.

| Resource | Link |
|----------|------|
| Genesis AI Overview | https://69a6a9b4fc07a0da83d6d9fe--emisx-engineering.netlify.app/genesis-ai/ |
| Platform Engineering AI Strategy | https://69a6a9b4fc07a0da83d6d9fe--emisx-engineering.netlify.app/docs/platform-engineering/our-strategy/augment-sdlc-with-ai |
| Key Contact | Dario DeVito, Luke Smith (Genesis platform) |

**Capabilities**:
- Foundation model hosting (VS Code agents: GPT-Codex, Claude Sonnet 4.6, Claude Opus 4.6)
- GitHub Copilot MCP integration — build via Genesis Platform
- Confluence AI (Rovo) — knowledge base querying and page generation
- AI Agent scaffolding and deployment tooling

---

## AI Tooling Standards

| Tool | Purpose | Status | Owner |
|------|---------|--------|-------|
| **GitHub Copilot** | Code generation, code review, documentation in VS Code and IDEs | Strategic — Active | Engineering |
| **Atlas_Architect** | Infrastructure architecture agent — demand reviews, HLD, LLD, BoM | Strategic — Active | Infrastructure Architecture |
| **Confluence Rovo** | Knowledge management, page generation, search | Strategic — Active | Platform Engineering / PIMS |
| **Genesis AI Platform** | Internal AI capability hub; model hosting; agent deployment | Strategic — Active | Platform Engineering (Dario DeVito) |
| **Claude Sonnet / Opus (via VS Code)** | AI-assisted architecture and infrastructure design | Strategic — Active | Infrastructure Architecture |

---

## Automated Documentation Strategy

### Goal

Create a near-fully-automated solution for generating, updating, and maintaining documentation for all Dev, Staging, and Production solutions and services — covering both public cloud and on-premises environments.

### MoSCoW Prioritisation

| Priority | Requirement |
|----------|------------|
| **Must** | Automation covers all AWS and Azure services and solutions |
| **Must** | Automation covers all on-premises services (VMware vSphere stack) |
| **Must** | Documentation links to or is generated from Reference Architecture, Architecture Landscape, Goals & Ways of Working guides |
| **Must** | Solution supports all teams in detailing what resources and configuration a solution/service is made up of |
| **Should** | Automate documentation from GitHub repositories (ReadMe.md, YAML, HCL files) |
| **Should** | Automated discovery reports for migration and hardware refresh scopes |
| **Could** | AI Agent-generated and AI-maintained documentation using Mermaid diagrams rendered from IaC inputs |
| **Could** | Confluence AI Agent builds pages from YAML/ReadMe/HCL files following architecture guidelines |

### Approach

The agreed approach produces documentation through three artefact layers in IaC repositories:

| Layer | Artefact | Purpose |
|-------|---------|---------|
| **1** | `YAML templates` | Standard and core configuration; core infrastructure detail, reference architecture pointers, VMware detail (see Daniel Kaminski for VMware guide standards) |
| **2** | `ReadMe.md` files | Human-readable service/solution description following a standard structure derived from Reference Architecture; consumed by Backstage TechDocs |
| **3** | `HCL files` | Terraform configuration; validated against current standards (see [Automation & IaC reference](../../technology-roadmap/references/automation-iac.md)) |

### AI-Assisted Generation Pipeline (Target State)

```mermaid
graph TB
    subgraph "Source Data"
        GH[GitHub Repos\nYAML / HCL / ReadMe.md]
        CMDB[ServiceNow CMDB]
        DT[Dynatrace\nTopology API]
        VC[VMware vCenter\nvSphere API]
        AWS[AWS Resource\nExplorer API]
        AZ[Azure Resource\nGraph API]
    end
    subgraph "AI Processing Layer"
        AGENT[AI Agent\nAtlas_Architect / Copilot]
        MERMAID[Mermaid Diagram\nGenerator]
    end
    subgraph "Output"
        CONF[Confluence Page\n(auto-generated/updated)]
        BSTG[Backstage TechDocs\n(ReadMe.md rendered)]
        REPORT[Discovery Reports\n(migration/refresh)]
    end

    GH --> AGENT
    CMDB --> AGENT
    DT --> AGENT
    VC --> AGENT
    AWS --> AGENT
    AZ --> AGENT
    AGENT --> MERMAID
    AGENT --> CONF
    AGENT --> BSTG
    AGENT --> REPORT
```

### Read-Only Access Requirements

For the automated documentation pipeline to function, the following read-only access is needed by infrastructure architects and AI agents:

| System | Access Type | How to Obtain |
|--------|-----------|---------------|
| **AWS accounts** | `HolisticViewer` permission set: ViewOnlyAccess + SecurityAudit + AWSResourceExplorerReadOnlyAccess | Log ticket with SecOps: https://emishealthgroup.atlassian.net/servicedesk/customer/portal/1/group/3/create/10332 |
| **Azure (EMISHealth Enterprise)** | Entra ID `Global Reader` role + `EHE Platform Managers` Reader on root tenant | Contact CloudOps (Rich Davies, Matt Jackson, Nabeel) |
| **GitHub repos** | Read-only access to all emisgroup repos | Contact Platform Engineering |
| **VMware vCenter/vSphere** | Read-only vCenter access | Contact Network Operations (Dave Nelson) |
| **Dynatrace** | Read API token (topology, entity, metrics) | Contact Monitoring team (JP, Robbie Frodsham, Navid Hussein) |
| **ServiceNow CMDB** | Read API access | Contact Service Management (Aaron Riley, Sam Hart, Ben De Caet, James Croll) |

> **CSV fallback**: Where API/direct access cannot be granted, export CSV data and import into AI agent context. This is the interim approach for VMware where vCenter API access is pending.

---

## AI Agent Design Guidelines

The following guidelines apply to all AI agents built and operated by EMIS/Optum. They are distilled from operational experience and the EMIS/Optum agent design principles. See also the `agent-customization` VS Code skill for implementation patterns.

### 1. Identity and Purpose First

Every agent must have a clear identity statement that answers:
- **Role name and function** — precise, scoped (e.g., "Infrastructure Architecture Agent for demand reviews and HLD production", not "assistant")
- **Audience** — who the agent serves (architects, engineers, PIMS, business stakeholders)
- **Depth calibration** — how far to go in analysis; high-level summary vs. exhaustive detail
- **End-use context** — what happens to the output (ARB presentation, runbook, cost estimate)
- **Tone** — formal/precise with domain expertise assumed; no casual language; no legal advice

### 2. Instructions That Work

- **Positive framing** — define expected behaviour with templates and positive instructions; use negative guardrails as supplementary constraints
- **Output format specified as a contract** — length, structure, headings, error handling all defined; if JSON is required, enforce JSON
- **Decision trees for multi-mode agents** — explicit branch triggers to prevent mode-blending
- **Stepwise reasoning** — instruct the agent to think through before producing output; separates reasoning from generation
- **Conditional instructions for edge cases** — happy path + out-of-scope + ambiguous input all handled

### 3. Guardrails

**Behavioural guardrails**:
- Irreversible actions (file writes, API calls, resource provisioning) require explicit confirmation before execution
- Uncertainty must be surfaced, not resolved by guessing; use structured uncertainty reports
- Communications (email, Slack, Confluence) are drafted for human review — never sent autonomously by default

**Scope guardrails**:
- Hard-code what the agent is **not** for; pair with a redirect to the correct resource or team
- Define escalation triggers: task needs access agent doesn't have; action affects more than threshold of records; ambiguity that could cause significant errors

### 4. Context and Memory Management

- **Persistent layer** (system prompt): identity, rules, guardrails, output format — stable; changing it changes behaviour broadly
- **Working memory** (current task): what the user asked; what the agent has done; what remains
- **Retrieved context** (on-demand): search results, tool outputs — enter context only when directly relevant
- Summarise completed steps at defined intervals for long-running agents; archive detailed history
- State handoffs must include: where it is in the workflow, what's complete, what's pending, and what the next step is

### 5. Tool Use Design

- **Minimum viable toolset** — start narrow; add tools only when there is a demonstrated need
- **Tool descriptions specify when to use** — not just what the tool does; prevents misapplication
- **Fallback instructions for every tool** — retry, surface failure, alternative approach, or escalate
- **Sequential structuring** — complete and confirm each step before planning the next; produce a plan, get confirmation, then execute
- **Tool output processing** — extract relevant fields; summarise verbose outputs; flag anomalies before using in reasoning

### 6. Uncertainty and Escalation

- **Typed uncertainty** — distinguish between: information gap / evidential conflict / competence boundary / consequential uncertainty
- **Confidence thresholds** — high / medium / low rating on major claims with basis explained
- **Graceful degradation** — answer what can be answered; be specific about what remains outstanding
- **Escalation routing is specific** — define who gets notified, through what channel, with what information, and what state the agent leaves the task in

### 7. Testing and Iteration

- Build evaluation suite in parallel with system prompt — not after the fact
- Test cases cover: happy path, edge cases, scope boundary cases, failure modes
- **Regression testing** — a change that fixes one failure can introduce others; keep the test suite stable
- **Iterative scope expansion** — start narrow, test thoroughly, expand incrementally; re-run full suite after each expansion
- Reference: Anthropic docs.claude.com for prompt engineering and tool use implementation

---

## References

- [Genesis AI Platform](https://69a6a9b4fc07a0da83d6d9fe--emisx-engineering.netlify.app/genesis-ai/) — Internal AI capability hub
- [Platforms Engineering AI Strategy](https://69a6a9b4fc07a0da83d6d9fe--emisx-engineering.netlify.app/docs/platform-engineering/our-strategy/augment-sdlc-with-ai) — SDLC augmentation with AI
- [Platform Engineering & IDP](./platform-engineering-idp.md) — Backstage, gold paths, ReadMe.md standards
- [Automation & IaC Standards](../../technology-roadmap/references/automation-iac.md) — Terraform, Ansible, Bicep, HCL standards
