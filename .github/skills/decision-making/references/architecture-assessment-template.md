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

The following is the **canonical output format** for all Atlas_Architect Architecture Assessments. Every output must follow this structure exactly — section order, heading levels, table columns, and sub-section names are fixed. Do not add, remove, or rename sections without updating this template.

```markdown
# Architecture Assessment — [Demand Title]

**Classification:** Internal
**Version:** 1.0
**Status:** Draft — Awaiting Architect Sign-off
**Date:** [DD Month YYYY]

---

## Overall Architecture Scorecard

> Complete this section last — it is the quick-reference summary for stakeholders.

| Measure | Result |
|---------|--------|
| **Benefit Score** | /20 |
| **Complexity Score** | /20 |
| **Benefit ÷ Complexity Ratio** | |
| **T-Shirt Size** | XS / S / M / L / XL |
| **Dependency Risk** | Low / Medium / High |

---

## Idea Summary

| Field | Detail |
|-------|--------|
| **Demand ID** | |
| **Demand Title** | |
| **Aha! Link** | |
| **Brief Description** | [1–2 sentences summarising the idea] |
| **Primary Driver** | - [ ] Cost &nbsp; - [ ] Resilience &nbsp; - [ ] Security &nbsp; - [ ] Speed &nbsp; - [ ] Compliance |
| **Workspace** | |
| **Created By** | |
| **Created Date** | |
| **Reviewer** | |
| **Review Date** | |

---

## Business / Operational Benefit (Score 1–5)

> Add up the four scores below (max 20) and record the total in the Overall Architecture Scorecard.

| Dimension | Guiding Question | Score (1–5) | Rationale |
|-----------|-----------------|:-----------:|-----------|
| **Business Impact** | Does this materially change outcomes, revenue, or risk? | | |
| **Operational Efficiency** | Will this reduce toil, incidents, or manual effort? | | |
| **Time Sensitivity** | Is there a deadline, dependency or regulatory driver? | | |
| **Reuse / Strategic Value** | Is this reusable across platforms or teams? | | |

**Benefit Score: /20**

---

## Technical & Delivery Complexity (Score 1–5)

> This is intentionally architecture-centric, not delivery-manager level.
> Add up the four scores below (max 20) and record the total in the Overall Architecture Scorecard.

| Dimension | Guiding Question | Score (1–5) | Rationale |
|-----------|-----------------|:-----------:|-----------|
| **Architectural Change** | New patterns, platforms, or core services? | | |
| **Integration Complexity** | Number & criticality of systems touched? | | |
| **Security / Compliance Impact** | New threat models, controls, audits required? | | |
| **Operational Change** | New runbooks, monitoring, on-call impact? | | |

**Complexity Score: /20**

---

## Effort T-Shirt Sizing (Architecture View)

> Not a commitment — a directional size to guide prioritisation.

| Size | Typical Characteristics |
|------|------------------------|
| XS | Config change, no design artefacts |
| S | Minor design, 1–2 services, known patterns |
| M | Multiple components, security involvement |
| L | Cross-domain impact, new patterns |
| XL | Platform-level capability or re-architecture |

**Indicative Size:** XS / S / M / L / XL

Rationale: [Explain the sizing choice here]

---

## Dependency & Engagement Assessment

### Internal Teams Likely Required

- [ ] **Security Architecture**
- [ ] **Networks**
- [ ] **Application Teams**
- [ ] **Product / Commercial**
- [ ] **Procurement**

### External or Non-Team Dependencies

- [ ] **Vendor / SaaS provider**
- [ ] **Regulator / External Audit**

**Dependency Risk:** Low / Medium / High

> [Expand on the dependency risk and primary driver of uncertainty here]

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
| **Benefit ÷ Complexity Ratio** | |
| **T-Shirt Size** | XS / S / M / L / XL |
| **Dependency Risk** | Low / Medium / High |

---

## Scoring Interpretation

| Benefit ÷ Complexity Ratio | Interpretation |
|---------------------------|----------------|
| > 1.5 | High value, relatively low complexity — prioritise |
| **1.0 – 1.5** | **Balanced — assess against current backlog capacity** |
| 0.5 – 1.0 | High complexity relative to benefit — challenge scope or defer |
| < 0.5 | Low value, high complexity — decline or significantly descope |

**Ratio: [x.x] — [One-line interpretation and recommendation statement]**

---

## Recommendation

### ✅ / ⚠️ / ❌ Recommended Disposition: **[Prioritise / Monitor / Defer / Decline] — [Sub-qualifier e.g. Approve with Conditions]**

[Opening rationale paragraph linking the scores, strategic alignment, and key drivers]

**Conditions for progression:** *(omit section if no conditions apply)*

1. **[Condition title]** — [Detail]
2. **[Condition title]** — [Detail]

### Suggested Next Steps

| Action | Owner | When |
|--------|-------|------|
| | | |

---

*Document generated by Atlas_Architect | [Demand ID] | Version [x.x] | Status: [Draft/Approved]*
```

---

## Scoring Interpretation Guide (Reference)

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
