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
7. **Standards Compliance** — Designs must comply with HIPAA, NIST, CIS Level 2, ISO 27001, and EMIS/Optum Reference Architecture and Security Architecture baselines
8. **Loosely Coupled** — Components should be independently deployable, scalable, and replaceable
9. **Data Sovereignty** — Data must reside in approved geographic regions; cross-border transfers require explicit approval
10. **Operational Excellence** — Designs must include runbooks, alerting, and handover documentation for PIMS/CloudOps
11. **Zero Trust Architecture** — Never assume trust based on network location; verify every identity explicitly, enforce least privilege, segment all resources, and assume breach in all design decisions; align with Microsoft and AWS Zero Trust guidance
12. **Interoperability** — Systems must integrate via approved open standards (REST/HTTPS APIs, HL7 FHIR for clinical data, NHS API standards); proprietary integration patterns that create lock-in require ARB approval
13. **Design for Simplicity** — Choose the simplest solution that meets stated requirements; avoid speculative complexity and over-engineering; added complexity must be justified by a documented business or technical requirement
14. **Portability** — Minimise vendor lock-in through portable IaC, containerised workloads, and open standards; proprietary-only services must be documented with switching-cost and risk assessment, and require ARB sign-off

## Procedure

### For New Solution Design

1. Load this skill and review the applicable framework references
2. Identify the appropriate TOGAF ADM phase for the current work — see [TOGAF Guidelines](./references/togaf-guidelines.md)
3. Evaluate the design against Well-Architected Framework pillars — see [Well-Architected Frameworks](./references/well-architected-frameworks.md)
4. Select appropriate design patterns — see [Design Patterns](./references/design-patterns.md)
5. Produce architecture diagrams using the C4 model (Context → Container → Component) — see [C4 Model Guide](./references/c4-model-guide.md)
6. Design BC/DR strategy aligned to service tier (Tier 1/2/3) — see [BC/DR Design Guide](./references/bc-dr-design-guide.md)
7. For clinical or NHS-connected systems, validate against clinical safety and NHS compliance standards — see [NHS & Clinical Compliance](./references/nhs-clinical-compliance.md)
8. Document architecture decisions as ADRs (use the `/decision-making` skill for templates)
9. Validate against security and compliance baselines (use the `/security-compliance` skill)

### For Architecture Review

1. Map the existing design to TOGAF viewpoints and Well-Architected pillars
2. Identify gaps against the core principles above
3. Score each pillar (1-5) with evidence-based rationale
4. Produce a findings summary with prioritised recommendations

## References

- [TOGAF Guidelines](./references/togaf-guidelines.md) — ADM phases, viewpoints, building blocks
- [Well-Architected Frameworks](./references/well-architected-frameworks.md) — Azure and AWS WAF pillars and lens guidance
- [Design Patterns](./references/design-patterns.md) — Common infrastructure patterns for hybrid, cloud, and on-prem
- [C4 Model Guide](./references/c4-model-guide.md) — C4 context, container, component, and code diagram methodology
- [BC/DR Design Guide](./references/bc-dr-design-guide.md) — Business continuity and disaster recovery design by service tier
- [NHS & Clinical Compliance](./references/nhs-clinical-compliance.md) — DCB0129/DCB0160 clinical safety, NHS DSP Toolkit, HSCN, Cyber Essentials Plus
