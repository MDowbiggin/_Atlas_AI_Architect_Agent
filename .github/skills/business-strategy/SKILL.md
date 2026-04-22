---
name: business-strategy
description: "Business strategy and priorities for EMIS/Optum infrastructure. Use when: aligning designs with strategic direction, cost optimisation initiatives, cloud migration strategy, modernisation assessments, re-platforming decisions, M&A integration, FinOps, or evaluating strategic fit of a solution."
---

# Business Strategy & Priorities

## When to Use

- Aligning a design or recommendation with EMIS/Optum strategic direction
- Evaluating whether a proposed solution fits the technology and business strategy
- Conducting cost optimisation reviews or FinOps assessments
- Planning cloud migration waves or modernisation initiatives
- Assessing re-platforming options for existing solutions
- Supporting M&A integration or divestiture scenarios
- Reviewing demands for strategic alignment
- Evaluating AI, automation, or intelligent tooling initiatives against the strategic roadmap
- Assessing Platform Engineering and Internal Developer Platform (IDP) proposals
- Reviewing technical debt remediation or modernisation programmes (e.g., Rising Sun, VMware renewal, certificate management)
- Assessing automated documentation or Infrastructure-as-Code documentation strategies

## Strategic Priorities

### 1. Cloud-First Transformation

**Objective**: Migrate the majority of workloads to AWS (primary) and Azure (secondary), reducing on-premises footprint while maintaining hybrid capability where required.

**Key Initiatives**:
- Assess and categorise all on-premises workloads (migrate, modernise, retain, retire)
- Establish cloud landing zones with enterprise-grade governance
- Achieve [INTERNAL — populate: target percentage]% of compute workloads in cloud by [INTERNAL — populate: target date]
- Maintain hybrid capability for regulated, latency-sensitive, or legacy workloads

**Architecture Implications**:
- New solutions default to cloud-native (AWS-first)
- On-premises deployment requires explicit justification and ARB approval
- Hybrid designs must use ExpressRoute with VPN backup
- All cloud deployments must use approved landing zone patterns

### 2. Cost Optimisation & FinOps

**Objective**: Optimise infrastructure spend through right-sizing, reserved capacity, automation, and governance — without compromising service quality or security.

**Key Initiatives**: See [Cost Optimisation Reference](./references/cost-optimization.md)

**Architecture Implications**:
- Every design must include cost impact analysis
- Right-sizing recommendations at design time (not just post-deployment)
- Reserved instances for predictable workloads; spot/preemptible for batch
- Auto-scaling and scale-to-zero for variable workloads
- Mandatory tagging for cost allocation

### 3. Modernisation & Re-Platforming

**Objective**: Modernise legacy applications and infrastructure to improve agility, reduce technical debt, and enable new capabilities.

**Key Initiatives**: See [Modernisation & Re-Platform Reference](./references/modernization-replatform.md)

**Architecture Implications**:
- Assess all new demands against the modernisation potential (not just lift-and-shift)
- Prioritise PaaS and containers over IaaS for new development
- Strangler Fig pattern for incremental migration of monoliths
- Maintain operational continuity during transition periods

### 4. Operational Excellence

**Objective**: Improve service reliability, reduce incident frequency, and increase automation of operational tasks.

**Key Initiatives**:
- Everything-as-Code: IaC, policy-as-code, pipeline-as-code
- Automated patching and compliance checking
- Self-healing infrastructure (auto-scaling, auto-recovery)
- Observability-driven operations (Dynatrace, Azure Monitor)
- Runbook automation (Ansible, Azure Automation, Logic Apps)

**Architecture Implications**:
- All designs must include monitoring, alerting, and operational readiness
- Runbooks are a mandatory deliverable alongside HLD/LLD
- Automate operational tasks by default; manual procedures are exceptions

### 5. Security & Compliance Leadership

**Objective**: Maintain and enhance security posture to meet regulatory requirements and protect patient data.

**Key Initiatives**:
- Zero Trust architecture adoption
- Continuous compliance monitoring (Azure Policy, AWS Config)
- Security-as-Code in CI/CD pipelines
- Quarterly security posture reviews

**Architecture Implications**:
- Security is a non-negotiable design constraint, not an afterthought
- All designs validated against HIPAA, NIST, CIS Level 2, ISO 27001
- Defence-in-depth approach with multiple control layers

### 6. M&A Integration Capability

**Objective**: Maintain readiness to integrate acquired entities or divest business units with minimal disruption.

**Key Initiatives**: See [M&A Integration Reference](./references/ma-integration.md)

**Architecture Implications**:
- Modular, decoupled architectures that can be extended or separated
- Standard integration patterns for identity, networking, and data
- Documented architecture boundaries per business unit

### 7. AI-Augmented Operations & Intelligent Automation

**Objective**: Embed AI and intelligent automation across infrastructure operations, SDLC, documentation, and service management to increase velocity, reduce manual effort, and improve quality.

**Key Initiatives**:
- Genesis AI Platform — internal AI platform for engineering and operations teams
- AI-assisted documentation generation and maintenance (YAML templates, ReadMe.md, HCL automated outputs)
- AI-powered demand triage and architecture assessment (Atlas_Architect and similar agents)
- GitHub Copilot and VS Code AI tooling embedded in engineering workflows
- Confluence AI (Rovo) for knowledge management
- Reviewing AI/LLM integration with ITSM via ServiceNow and Backstage
- Automated infrastructure discovery and reporting (ARMIS, Dynatrace, VMware Skyline)

**Architecture Implications**:
- New automation and tooling proposals must be assessed for AI augmentation potential before manual alternatives are approved
- AI agents must follow the EMIS/Optum AI Agent Creation Guidelines (identity, guardrails, scope, escalation, testing) — see [AI & Automation Strategy](./references/ai-automation-strategy.md)
- AI tooling must comply with data protection and HIPAA requirements — no PHI/PII in AI model training or prompts without explicit DPO sign-off
- Infrastructure supporting AI/ML workloads must be designed with GPU/accelerated compute, high-bandwidth networking, and appropriate data residency controls

### 8. Platform Engineering & Internal Developer Platform (IDP)

**Objective**: Establish a world-class Internal Developer Platform (Backstage) that provides software cataloguing, gold path templates, automated provisioning, and self-service capabilities for engineering and operations teams.

**Key Initiatives**:
- Backstage (Spotify) as the EMIS/Optum IDP — hosted on `hub.emis-x.uk`
- Software Catalog for service discovery and ownership tracking
- Gold path templates for standardised API, service, and infrastructure deployments
- TechDocs integration for markdown-rendered documentation in the catalog
- Plugin integrations: PagerDuty, ServiceNow ITOM, Dynatrace, GitHub
- YAML deployment templates covering core infrastructure, reference architecture, and VMware stack
- ReadMe.md standards for GitHub repositories backing deployed services
- See [Platform Engineering & IDP Reference](./references/platform-engineering-idp.md)

**Architecture Implications**:
- New solutions must register in the Backstage Software Catalog at go-live
- Gold path templates (not bespoke provisioning) are the default for standard infrastructure patterns
- Architecture designs must include a Backstage catalog entry and TechDocs structure as part of the operational readiness deliverable
- Platform Engineering team (Dario DeVito, Luke Smith, Ian Hardcastle, JP Drawneek, Robbie Frodsham) must review new gold path requirements before design is finalised

### 9. Technical Debt Remediation & Platform Currency

**Objective**: Systematically identify, prioritise, and remediate technical debt across infrastructure, platforms, and security tooling — maintaining platform currency and reducing operational risk.

**Key Programmes** (April 2026):
- **Rising Sun Remediation** — Security and platform remediation programme; includes CrowdStrike migration, Tenable/Nessus migration, Delinea DDE deployment, and network infrastructure work. Owners: Philip Mais / Chris King (programme), Dave Nelson (network investigation)
- **VMware Renewal Decision (October 2026)** — Broadcom licensing renewal due. Strategic options assessment required: renew VMware, migrate to alternative hypervisor, accelerate cloud migration of on-prem workloads. Document: `VMWare Host Reporting Feb 2026_Dave Nelson.xlsx`. See [Technical Debt & Platform Currency](./references/technical-debt-platform-currency.md)
- **Certificate Management Roadmap** — Backlogged on Aha! and El Capitan. Certificate lifecycle automation for all on-prem and cloud services
- **EMISWeb Containerisation** — Strategic initiative to containerise EMISWeb and migrate DB tier to RDS; Rich Davies and Mic Holden leading. Draft: `EMIS Web - Doubling down on cloud`
- **Bastion Replacement** — 60+ bastions deployed for remote access; evaluate Azure Bastion / SSM Session Manager as replacements; align with Zero Trust and CyberEssentials Plus requirements
- **Security Patching Automation** — Automate OS and application patching across AWS, Azure, and on-prem VMware; reduce manual patching effort and close compliance gaps

**Architecture Implications**:
- Technical debt must be surfaced in demand reviews and HLDs — never design on top of unacknowledged debt without a remediation plan
- The VMware renewal decision will have significant architectural implications for on-prem workload strategy; all designs involving on-prem compute must flag the October 2026 decision point
- Remediation work must be quantified (risk, cost, effort) using the same BoM and cost estimation approach as new designs

## Strategic Alignment Assessment

When reviewing a demand or design, assess alignment using this framework:

| Strategic Priority | Alignment Score (1-5) | Evidence | Gaps |
|-------------------|----------------------|----------|------|
| Cloud-First Transformation | | | |
| Cost Optimisation & FinOps | | | |
| Modernisation & Re-Platforming | | | |
| Operational Excellence | | | |
| Security & Compliance | | | |
| M&A Integration Capability | | | |
| AI-Augmented Operations & Automation | | | |
| Platform Engineering & IDP | | | |
| Technical Debt Remediation | | | |
| **Overall Strategic Fit** | | | |

**Scoring**:
- **5**: Strongly supports priority; advances strategic goals
- **4**: Supports priority; aligned with direction
- **3**: Neutral; does not advance or hinder
- **2**: Partially misaligned; may create technical debt
- **1**: Counter to strategic direction; requires ARB justification

## References

- [Cost Optimisation](./references/cost-optimization.md) — FinOps principles, right-sizing, reserved capacity, tagging
- [Cloud Migration](./references/cloud-migration.md) — Migration strategy, wave planning, tools
- [Modernisation & Re-Platform](./references/modernization-replatform.md) — Assessment frameworks, patterns
- [M&A Integration](./references/ma-integration.md) — Integration patterns, playbook
- [AI & Automation Strategy](./references/ai-automation-strategy.md) — AI agent guidelines, Genesis AI platform, intelligent automation, automated documentation
- [Platform Engineering & IDP](./references/platform-engineering-idp.md) — Backstage, software catalog, gold paths, YAML/ReadMe.md standards, deployment strategy
- [Technical Debt & Platform Currency](./references/technical-debt-platform-currency.md) — Rising Sun, VMware renewal, certificate management, debt prioritisation framework
