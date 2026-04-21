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
