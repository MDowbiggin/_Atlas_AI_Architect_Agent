# Architecture Assessment Template

## Overview

This is the **lightweight scoring template** used to triage new and in-progress Aha! demands. It is completed by the assigned Infrastructure Solutions Architect during initial demand review and before the full Demand Review Checklist is produced.

### Aha! Demand Sources

New and in-progress demands are reviewed from the following Aha! pivot views:

| Team | Aha! View |
|------|-----------|
| **Hosted Services** | [Aha! Hosted Services Demand Pivot](https://optum.aha.io/bookmarks/custom_pivots/7631534830970022767) |
| **Platform Engineering** | [Aha! Platform Engineering Demand Pivot](https://optum.aha.io/bookmarks/custom_pivots/7631536791781662911) |

---

## Template

```markdown
# Architecture Assessment — [Demand Title]

## Idea Summary

| Field | Detail |
|-------|--------|
| **Demand Title** | [Title from Aha!] |
| **Aha! Link** | [Link to Aha! demand] |
| **Brief Description** | [1–2 sentences summarising the idea] |
| **Primary Driver** | Cost / Resilience / Security / Speed / Compliance |
| **Reviewer** | [Architect Name] |

---

## Business / Operational Benefit (Score 1–5)

> Add up the four scores below (max 20) and record the total in the Overall Architecture Scorecard.

| Dimension | Guiding Question | Score (1–5) |
|-----------|-----------------|-------------|
| **Business Impact** | Does this materially change outcomes, revenue, or risk? | |
| **Operational Efficiency** | Will this reduce toil, incidents, or manual effort? | |
| **Time Sensitivity** | Is there a deadline, dependency or regulatory driver? | |
| **Reuse / Strategic Value** | Is this reusable across platforms or teams? | |

**Scoring Anchors:**
- **1** — Marginal / nice-to-have
- **3** — Clear improvement for a subset of teams
- **5** — Strategic or regulatory-level importance

---

## Technical & Delivery Complexity (Score 1–5)

> This is intentionally architecture-centric, not delivery-manager level.
> Add up the four scores below (max 20) and record the total in the Overall Architecture Scorecard.

| Dimension | Guiding Question | Score (1–5) |
|-----------|-----------------|-------------|
| **Architectural Change** | New patterns, platforms, or core services? | |
| **Integration Complexity** | Number & criticality of systems touched? | |
| **Security / Compliance Impact** | New threat models, controls, audits required? | |
| **Operational Change** | New runbooks, monitoring, on-call impact? | |

**Scoring Anchors:**
- **1** — Config / extension of existing patterns
- **3** — New component, known pattern
- **5** — Net-new platform or material re-architecture

---

## Effort T-Shirt Sizing (Architecture View)

> Not a commitment — a directional size to guide prioritisation.

| Size | Typical Characteristics |
|------|------------------------|
| **XS** | Config change, no design artefacts |
| **S** | Minor design, 1–2 services, known patterns |
| **M** | Multiple components, security involvement |
| **L** | Cross-domain impact, new patterns |
| **XL** | Platform-level capability or re-architecture |

**Indicative Size:** XS / S / M / L / XL

---

## Dependency & Engagement Assessment

Tick all that apply.

### Internal Teams Likely Required

- [ ] Security Architecture
- [ ] Networks
- [ ] Application Teams
- [ ] Product / Commercial
- [ ] Procurement

### External or Non-Team Dependencies

- [ ] Vendor / SaaS provider
- [ ] Regulator / External Audit

**Dependency Risk:** Low / Medium / High

---

## Risk & Uncertainty (Qualitative)

### Key Assumptions

-

### Known Unknowns

-

### Likely Pain Points

-

---

## Overall Architecture Scorecard

| Measure | Result |
|---------|--------|
| **Benefit Score** | /20 |
| **Complexity Score** | /20 |
| **Benefit ÷ Complexity Ratio** | e.g. 1.6 |
| **T-Shirt Size** | XS / S / M / L / XL |
| **Dependency Risk** | Low / Med / High |
```

---

## Scoring Interpretation Guide

| Benefit ÷ Complexity Ratio | Interpretation |
|---------------------------|----------------|
| **> 1.5** | High value, relatively low complexity — prioritise |
| **1.0 – 1.5** | Balanced — assess against current backlog capacity |
| **0.5 – 1.0** | High complexity relative to benefit — challenge scope or defer |
| **< 0.5** | Low value, high complexity — decline or significantly descope |

## Relationship to Full Demand Review

This Architecture Assessment is a **triage tool**. It is not a substitute for the full [Demand Review Checklist](./demand-review-checklist.md), which is required before design work begins.

| Stage | Tool | Purpose |
|-------|------|---------|
| **Initial Triage** | Architecture Assessment (this template) | Quick scoring of Aha! demand to inform prioritisation |
| **Pre-Design Gate** | Demand Review Checklist | Full feasibility, risk, and alignment review before HLD |
