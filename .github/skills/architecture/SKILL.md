---
name: architecture
description: "Architecture frameworks, design patterns, and principles for infrastructure solutions. Use when: designing solutions, reviewing architectures, applying TOGAF or Well-Architected Framework principles, selecting design patterns for hybrid/cloud/on-prem deployments, conducting architecture reviews, C4 modelling."
---

# Architecture Frameworks & Design Patterns

## When to Use

- Designing new infrastructure solutions or reviewing existing architectures
- Applying TOGAF Architecture Development Method (ADM) phases
- Evaluating designs against Azure or AWS Well-Architected Framework pillars
- Selecting design patterns for hybrid, cloud-native, or on-premises deployments
- Conducting architecture reviews or producing Architecture Decision Records (ADRs)
- Creating C4 model diagrams (Context, Container, Component, Code)

## Architecture Principles (EMIS/Optum)

### Core Principles

1. **Cloud-First, Not Cloud-Only** — Prefer cloud-native solutions (AWS primary, Azure secondary) but support hybrid and on-premises where justified by regulation, latency, or cost
2. **Design for Resilience** — All production systems must meet defined RTO/RPO targets with automated failover where possible
3. **Security by Design** — Security controls are integral to the architecture, not bolted on afterwards
4. **Cost-Conscious Design** — Right-size from day one; design for elasticity and auto-scaling; avoid over-provisioning
5. **Automation-First** — All infrastructure must be defined as code; manual provisioning is not acceptable for production
6. **Observable Systems** — Every component must emit telemetry (logs, metrics, traces) to Dynatrace and platform-native monitoring
7. **Standards Compliance** — Designs must comply with HIPAA, NIST, CIS Level 2, and ISO 27001 baselines
8. **Loosely Coupled** — Components should be independently deployable, scalable, and replaceable
9. **Data Sovereignty** — Data must reside in approved geographic regions; cross-border transfers require explicit approval
10. **Operational Excellence** — Designs must include runbooks, alerting, and handover documentation for PIMS/CloudOps

## Procedure

### For New Solution Design

1. Load this skill and review the applicable framework references
2. Identify the appropriate TOGAF ADM phase for the current work — see [TOGAF Guidelines](./references/togaf-guidelines.md)
3. Evaluate the design against Well-Architected Framework pillars — see [Well-Architected Frameworks](./references/well-architected-frameworks.md)
4. Select appropriate design patterns — see [Design Patterns](./references/design-patterns.md)
5. Document architecture decisions as ADRs (use the `/decision-making` skill for templates)
6. Validate against security and compliance baselines (use the `/security-compliance` skill)

### For Architecture Review

1. Map the existing design to TOGAF viewpoints and Well-Architected pillars
2. Identify gaps against the core principles above
3. Score each pillar (1-5) with evidence-based rationale
4. Produce a findings summary with prioritised recommendations

## References

- [TOGAF Guidelines](./references/togaf-guidelines.md) — ADM phases, viewpoints, building blocks
- [Well-Architected Frameworks](./references/well-architected-frameworks.md) — Azure and AWS WAF pillars and lens guidance
- [Design Patterns](./references/design-patterns.md) — Common infrastructure patterns for hybrid, cloud, and on-prem
