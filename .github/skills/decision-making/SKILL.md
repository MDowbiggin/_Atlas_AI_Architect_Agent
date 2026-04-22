---
name: decision-making
description: "Architecture decision records, demand reviews, and option analysis frameworks. Use when: documenting architecture decisions (ADRs), conducting demand reviews, evaluating options with weighted scoring, performing trade-off analysis, assessing go/no-go criteria, or producing decision documentation."
---

# Outcome & Decision Making

## When to Use

- Documenting a significant architecture decision (ADR)
- Conducting a demand review and producing a recommendation
- Evaluating multiple solution options with structured analysis
- Performing trade-off analysis between competing approaches
- Assessing go/no-go criteria for a project or deployment
- Producing decision documentation for Architecture Review Board (ARB)

## Decision-Making Principles

1. **Evidence-based** — Decisions are supported by data, standards, and documented rationale, not opinion alone
2. **Transparent** — Decision criteria, options considered, and trade-offs are documented and accessible
3. **Traceable** — Every decision links back to a requirement, constraint, or strategic priority
4. **Reversible where possible** — Prefer decisions that can be changed later without catastrophic cost
5. **Timely** — Decisions are made at the latest responsible moment — enough information to reduce risk, early enough to maintain momentum
6. **Accountable** — Every decision has a named decision-maker and a review/approval chain

## Procedure

### For Architecture Decisions

1. Identify that a decision needs to be made (technology choice, pattern selection, trade-off)
2. Document the decision using the ADR template — see [ADR Template](./references/adr-template.md)
3. Evaluate options using the weighted scoring framework (for significant decisions)
4. Get peer review from a senior architect
5. Submit to ARB if the decision meets escalation criteria:
   - New technology introduction
   - Significant departure from standards
   - Annual cost implication > £100,000
   - Cross-team or cross-platform impact
6. Record the final decision and rationale

### For Demand Reviews

**Stage 1 — Aha! Triage (Architecture Assessment)**

New and in-progress demands originate in Aha! and are reviewed from two pivot views:

| Team | Aha! View |
|------|-----------|
| **Hosted Services** | [Aha! Hosted Services Demand Pivot](https://optum.aha.io/bookmarks/custom_pivots/7631534830970022767) |
| **Platform Engineering** | [Aha! Platform Engineering Demand Pivot](https://optum.aha.io/bookmarks/custom_pivots/7631536791781662911) |

1. Access the relevant Aha! pivot view for the demand being assessed
2. Complete the **Architecture Assessment** scoring template — see [Architecture Assessment Template](./references/architecture-assessment-template.md)
3. Score Business/Operational Benefit (1–5 per dimension, max 20) and Technical & Delivery Complexity (1–5 per dimension, max 20)
4. Calculate the Benefit ÷ Complexity ratio to inform prioritisation
5. Assign an indicative T-shirt size (XS/S/M/L/XL) and dependency risk rating
6. Use the scorecard to recommend: prioritise, monitor, defer, or decline

**Stage 2 — Full Demand Review (Pre-Design Gate)**

Once a demand is approved for progression, complete the full demand review:

1. Receive the confirmed demand (via ServiceNow request, ADO work item, or direct request)
2. Use the Demand Review Checklist — see [Demand Review Checklist](./references/demand-review-checklist.md)
3. Assess across all dimensions: feasibility, alignment, risk, cost, complexity
4. Produce a recommendation: Approve / Approve with conditions / Request more info / Decline
5. Present findings to the requesting team

### For Option Analysis

1. Define the decision to be made and the evaluation criteria
2. Identify all viable options (minimum 2; include "do nothing" where applicable)
3. Weight the criteria based on business priorities
4. Score each option against each criterion
5. Calculate weighted totals
6. Document trade-offs and risk implications
7. Recommend an option with supporting rationale

## Option Analysis Framework

### Weighted Scoring Template

```markdown
## Option Analysis — [Decision Title]

### Context
[What decision is being made and why]

### Evaluation Criteria

| # | Criterion | Weight (%) | Description |
|---|----------|------------|-------------|
| 1 | Cost | 25% | Total cost of ownership over 3 years |
| 2 | Technical Fit | 20% | Alignment with approved technology stack |
| 3 | Operational Complexity | 15% | Ease of operation and maintenance by PIMS |
| 4 | Security & Compliance | 15% | Compliance with HIPAA, NIST, CIS, ISO 27001 |
| 5 | Scalability | 10% | Ability to scale with growing demand |
| 6 | Time to Deliver | 10% | Implementation timeline |
| 7 | Risk | 5% | Overall risk profile |

### Options

| # | Option | Description |
|---|--------|-------------|
| A | [Option A name] | [Brief description] |
| B | [Option B name] | [Brief description] |
| C | [Option C name] | [Brief description] |

### Scoring (1-5 scale: 1=Poor, 3=Adequate, 5=Excellent)

| Criterion | Weight | Option A | Weighted A | Option B | Weighted B | Option C | Weighted C |
|-----------|--------|----------|-----------|----------|-----------|----------|-----------|
| Cost | 25% | X | X.XX | X | X.XX | X | X.XX |
| Technical Fit | 20% | X | X.XX | X | X.XX | X | X.XX |
| Op. Complexity | 15% | X | X.XX | X | X.XX | X | X.XX |
| Security | 15% | X | X.XX | X | X.XX | X | X.XX |
| Scalability | 10% | X | X.XX | X | X.XX | X | X.XX |
| Time to Deliver | 10% | X | X.XX | X | X.XX | X | X.XX |
| Risk | 5% | X | X.XX | X | X.XX | X | X.XX |
| **Total** | **100%** | | **X.XX** | | **X.XX** | | **X.XX** |

### Trade-Off Analysis

| Factor | Option A | Option B | Option C |
|--------|----------|----------|----------|
| Pros | | | |
| Cons | | | |
| Key Risk | | | |
| Mitigation | | | |

### Recommendation

**Recommended Option**: [X]

**Rationale**: [Why this option was selected, referencing the scoring and any qualitative factors]

**Conditions / Caveats**: [Any conditions that must be met]
```

## Go/No-Go Assessment

Use this framework before major deployments or go-live decisions:

```markdown
## Go/No-Go Assessment — [Service/Project Name]

### Date: YYYY-MM-DD
### Decision: GO / NO-GO / CONDITIONAL GO

### Criteria Assessment

| # | Criterion | Status | Evidence | Blocker? |
|---|----------|--------|----------|----------|
| 1 | HLD/LLD approved | ✅/❌ | [Link to doc] | Yes/No |
| 2 | Security review passed | ✅/❌ | [Link to review] | Yes |
| 3 | Runbooks complete | ✅/❌ | [Link to KB] | Yes |
| 4 | Monitoring configured | ✅/❌ | [Dashboard link] | Yes |
| 5 | CMDB updated | ✅/❌ | [CI numbers] | No |
| 6 | Backup tested | ✅/❌ | [Test result] | Yes |
| 7 | DR tested | ✅/❌ | [Test result] | Yes |
| 8 | Performance tested | ✅/❌ | [Test result] | No |
| 9 | UAT signed off | ✅/❌ | [Sign-off] | Yes |
| 10 | Change request approved | ✅/❌ | [CHG number] | Yes |
| 11 | Rollback plan documented | ✅/❌ | [Link] | Yes |
| 12 | PIMS handover complete | ✅/❌ | [Handover record] | Yes |
| 13 | Cost approved | ✅/❌ | [Approval ref] | No |

### Outstanding Items (if Conditional Go)

| Item | Owner | Due Date | Impact if Not Resolved |
|------|-------|----------|----------------------|
| | | | |

### Decision & Sign-Off

| Role | Name | Decision | Date |
|------|------|----------|------|
| Solutions Architect | | GO/NO-GO | |
| PIMS Team Lead | | GO/NO-GO | |
| Security | | GO/NO-GO | |
| Product Owner | | GO/NO-GO | |
```

## References

- [Architecture Assessment Template](./references/architecture-assessment-template.md) — Aha! demand triage scoring template (Stage 1)
- [Demand Review Checklist](./references/demand-review-checklist.md) — Full pre-design demand review (Stage 2)
- [ADR Template](./references/adr-template.md) — Architecture Decision Record template
