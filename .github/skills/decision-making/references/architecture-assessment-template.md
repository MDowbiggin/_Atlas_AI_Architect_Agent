# Architecture Assessment Template

## Overview

This is the **lightweight scoring template** used to triage new and in-progress Aha! demands. It is completed by the assigned Infrastructure Solutions Architect during initial demand review and before the full Demand Review Checklist is produced.

> **Prerequisite — Requirements Definition Gate (guardrails Section 7):** Do not score a demand on an undocumented brief. A Requirements Specification must be started first — see [Requirements Specification Template](./requirements-specification-template.md). Where requirements are incomplete, capture what is known, flag gaps and assumptions, and score on a provisional, assumption-dependent basis.

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
| **Business / Operational Value Score** | /5 |
| **Time Criticality Score** | /5 |
| **Risk Reduction Score** | /5 |
| **Job Size Score** | /5 |
| **WSJF Score** | (BV + TC + RR) ÷ JS |
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
| **Idea Category** | - [ ] Security &nbsp; - [ ] Service Improvements &nbsp; - [ ] Cost Optimisation &nbsp; - [ ] Commercial Delivery &nbsp; - [ ] BAU |
| **Primary Driver** | - [ ] Cost &nbsp; - [ ] Resilience &nbsp; - [ ] Security &nbsp; - [ ] Speed &nbsp; - [ ] Compliance |
| **Engineering Team** | - [ ] PLATENG Platform Engineering Snowden &nbsp; - [ ] PLATENG Platform Engineering El Capitan &nbsp; - [ ] PLATENG Platform Engineering Everest &nbsp; - [ ] PLATENG Platform Engineering Blanc &nbsp; - [ ] PLATENG Platform Engineering Operations &nbsp; - [ ] PLATENG Platform Engineering FinOps |
| **Workspace** | |
| **Created By** | |
| **Created Date** | |
| **Reviewer** | |
| **Review Date** | |

---

## Requirements Readiness

> Confirm requirements are documented before scoring (guardrails Section 7). Capture them in the [Requirements Specification](./requirements-specification-template.md).

| Requirement Area | Status |
|------------------|:------:|
| Functional | ✅ / ⚠️ / ❌ |
| Non-functional (availability, performance, scalability, DR — RTO/RPO) | ✅ / ⚠️ / ❌ |
| Security & compliance (HIPAA/NIST/CIS/ISO) + data classification | ✅ / ⚠️ / ❌ |
| Constraints & assumptions | ✅ / ⚠️ / ❌ |
| In-scope / out-of-scope | ✅ / ⚠️ / ❌ |
| Success / acceptance criteria | ✅ / ⚠️ / ❌ |
| Stakeholders, requestor & driver | ✅ / ⚠️ / ❌ |
| Cost / budget envelope & timeline | ✅ / ⚠️ / ❌ |

**Requirements status:** ✅ Confirmed / ⚠️ Provisional — scored against documented assumptions / ❌ Insufficient — confirmation required

---

## Business / Operational Value (Score 1–5)

> Score each dimension 1–5. The Business / Operational Value Score is the **average or consensus** of the three scores below.

| Dimension | Guiding Question | Score (1–5) | Rationale |
|-----------|-----------------|:-----------:|-----------|
| **Business Impact** | Does this materially change outcomes, revenue, or risk exposure? | | |
| **Operational Efficiency** | Will this reduce toil, incidents, or manual effort? | | |
| **Reuse / Strategic Value** | Is this reusable across platforms, products, or teams? | | |

**Business / Operational Value Score: /5**

<details>
<summary>Scoring Anchor</summary>

| Score | Meaning |
|-------|---------|
| **1** | Marginal / nice-to-have; limited measurable benefit |
| **2** | Minor improvement for a single team or workflow |
| **3** | Clear improvement for multiple teams or a key business process |
| **4** | Significant impact on revenue, cost, or operational resilience |
| **5** | Strategic or regulatory-level importance; failure to deliver creates material business risk |

</details>

---

## Time Criticality (Score 1–5)

> How rapidly does this problem need to be solved or delivered? Select the single most appropriate score.

| Score | Urgency | Rationale |
|-------|---------|-----------|
| **1** | No hard deadline — can be scheduled at convenience (12+ months) | |
| **2** | Desired within the next year (6–12 months) | |
| **3** | Needed within the next 3–6 months | |
| **4** | Urgent — required within the next quarter (1–3 months); delay creates material risk | |
| **5** | Critical — must be delivered within 6 weeks; regulatory, contractual, or security imperative | |

**Time Criticality Score: /5**

---

## Risk Reduction / Opportunity Enablement (Score 1–5)

> Score each dimension 1–5. The Risk Reduction Score is the **average or consensus** of the three scores below.

| Dimension | Guiding Question | Score (1–5) | Rationale |
|-----------|-----------------|:-----------:|-----------|
| **Security / Compliance Risk** | Does this address a known vulnerability, audit finding, or regulatory gap? | | |
| **Operational Risk** | Does this reduce incident likelihood, blast radius, or recovery time? | | |
| **Opportunity Enablement** | Does this unlock new capabilities, integrations, or market access? | | |

**Risk Reduction Score: /5**

<details>
<summary>Scoring Anchor</summary>

| Score | Meaning |
|-------|---------|
| **1** | No meaningful risk reduction; no new opportunities unlocked |
| **2** | Addresses a low-severity risk or enables a minor future enhancement |
| **3** | Mitigates a moderate, known risk or enables a valuable capability |
| **4** | Significantly reduces a high-likelihood or high-impact risk |
| **5** | Eliminates a critical / regulatory risk or is a prerequisite for a strategic initiative |

</details>

---

## Job Size (Score 1–5)

> Estimate the overall effort required to deliver this item. Consider architectural change, integration complexity, security involvement, and operational impact. The Job Size Score is the **average or consensus** of the four scores below.

| Dimension | Guiding Question | Score (1–5) | Rationale |
|-----------|-----------------|:-----------:|-----------|
| **Architectural Change** | New patterns, platforms, or core services required? | | |
| **Integration Complexity** | Number and criticality of systems touched? | | |
| **Security / Compliance Effort** | New threat models, controls, or audits required? | | |
| **Operational Change** | New runbooks, monitoring, or on-call impact? | | |

**Job Size Score: /5**

<details>
<summary>Scoring Anchor (T-Shirt Sizing)</summary>

| Score | T-Shirt | Typical Characteristics |
|-------|---------|------------------------|
| **1** | XS | Config change or extension of existing patterns |
| **2** | S | Minor design work, 1–2 services, known patterns |
| **3** | M | Multiple components, some security involvement |
| **4** | L | Cross-domain impact, new patterns required |
| **5** | XL | Platform-level capability or material re-architecture |

</details>

**Indicative T-Shirt Size:** XS / S / M / L / XL

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
| **Business / Operational Value Score** | /5 |
| **Time Criticality Score** | /5 |
| **Risk Reduction Score** | /5 |
| **Job Size Score** | /5 |
| **WSJF Score** | (BV + TC + RR) ÷ JS |
| **T-Shirt Size** | XS / S / M / L / XL |
| **Dependency Risk** | Low / Medium / High |

---

## WSJF Scoring & Interpretation

> **WSJF = (Business Value + Time Criticality + Risk Reduction) ÷ Job Size**
> Higher scores indicate higher relative priority. Use alongside strategic context and dependency risk.

| WSJF Score | Interpretation |
|------------|----------------|
| > 3.0 | High value relative to size — strong case to prioritise |
| **2.0 – 3.0** | **Balanced — assess against current backlog capacity** |
| 1.0 – 2.0 | Moderate priority — consider deferral or scope reduction |
| < 1.0 | Low value or very high complexity — challenge scope, defer, or decline |

**WSJF Score: [x.x] — [One-line interpretation and recommendation statement]**

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

## WSJF Scoring Interpretation Guide (Reference)

> **WSJF = (Business Value + Time Criticality + Risk Reduction) ÷ Job Size**

| WSJF Score | Interpretation |
|------------|----------------|
| **> 3.0** | High value relative to size — strong case to prioritise |
| **2.0 – 3.0** | Balanced — assess against current backlog capacity |
| **1.0 – 2.0** | Moderate priority — consider deferral or scope reduction |
| **< 1.0** | Low value or very high complexity — challenge scope, defer, or decline |

## Relationship to Full Demand Review

This Architecture Assessment is a **triage tool**. It is not a substitute for the full [Demand Review Checklist](./demand-review-checklist.md), which is required before design work begins.

| Stage | Tool | Purpose |
|-------|------|---------|
| **Initial Triage** | Architecture Assessment (this template) | Quick scoring of Aha! demand to inform prioritisation |
| **Pre-Design Gate** | Demand Review Checklist | Full feasibility, risk, and alignment review before HLD |
