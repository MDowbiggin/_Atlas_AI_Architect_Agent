---
name: decision-making
description: "Architecture decision records, demand reviews, and option analysis frameworks. Use when: documenting architecture decisions (ADRs), conducting demand reviews, evaluating options with weighted scoring, performing trade-off analysis, assessing go/no-go criteria, producing ARB submissions, requesting exceptions/derogations from standards, managing project risk registers, or producing decision documentation."
---

# Outcome & Decision Making

## When to Use

- Capturing and documenting requirements before a demand review, project, research, or design begins
- Documenting a significant architecture decision (ADR)
- Conducting a demand review and producing a recommendation
- Evaluating multiple solution options with structured analysis
- Performing trade-off analysis between competing approaches
- Assessing go/no-go criteria for a project or deployment
- Producing decision documentation for Architecture Review Board (ARB)
- Preparing and submitting an ARB paper for review or new technology introduction
- Requesting a formal exception or derogation from an approved standard or technology
- Managing and maintaining a project or programme risk register
- Documenting a formal risk acceptance decision
- Conducting a post-incident architectural review to capture learning and drive design improvement

## Decision-Making Principles

0. **Requirements-first** — No demand review, research, investigation, option analysis, or design proceeds without a clear, documented set of requirements (guardrails Section 7). Where requirements are incomplete, capture what is known, explicitly list gaps and assumptions, and request confirmation before treating any assumption as fact. Findings produced against unconfirmed requirements must be caveated as assumption-dependent.
1. **Evidence-based** — Decisions are supported by data, standards, and documented rationale, not opinion alone
2. **Transparent** — Decision criteria, options considered, and trade-offs are documented and accessible
3. **Traceable** — Every decision links back to a requirement, constraint, or strategic priority
4. **Reversible where possible** — Prefer decisions that can be changed later without catastrophic cost
5. **Timely** — Decisions are made at the latest responsible moment — enough information to reduce risk, early enough to maintain momentum
6. **Accountable** — Every decision has a named decision-maker and a review/approval chain
7. **Proportionate** — The rigour and formality of the decision process must match the significance, cost, and reversibility of the decision; lightweight decisions (XS/S) do not need full ADR treatment; high-impact or irreversible decisions (L/XL, or meeting ARB escalation criteria) must follow the full process
8. **Stakeholder-inclusive** — Key stakeholders are identified and consulted before decisions are finalised; decisions that affect PIMS, Security, Engineering, or Product must include those teams' input before sign-off
9. **Risk-informed** — Risks are explicitly identified, quantified, and either mitigated or formally accepted; accepted risks have a named risk owner and are tracked in the project risk register
10. **Learn and Improve** — Post-incident and post-project reviews feed back into the architecture decision record; decisions that proved wrong are documented so the organisation learns

## Procedure

### For Requirements Definition (First Gate)

Complete this **before** any demand review, research, investigation, option analysis, or design begins. This is the first gate; all other procedures depend on it.

1. Capture the raw request / brief from the requestor (Aha!, ServiceNow, ADO, or direct)
2. Populate the Requirements Specification — see [Requirements Specification Template](./references/requirements-specification-template.md) — covering, as a minimum:
   - Functional requirements
   - Non-functional requirements (availability, performance, scalability, DR — RTO/RPO)
   - Security & compliance requirements (HIPAA, NIST, CIS Level 2, ISO 27001) and data classification
   - Constraints & assumptions
   - In-scope / out-of-scope boundaries
   - Success / acceptance criteria
   - Stakeholders, requestor & business driver
   - Cost / budget envelope & timeline
3. Complete the Requirements Readiness Summary; mark each area Confirmed / Partial / Missing
4. Apply the **proceed-but-flag** model where requirements are incomplete: record every gap, open question, and assumption in the Open Questions section and request confirmation from the requestor
5. Confirm there is no PHI/PII in the requirements record (use synthetic examples only)
6. Version-control the specification; treat it as the single source of truth that all downstream findings and decisions trace back to
7. Re-confirm and re-version the specification if requirements change after work begins

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

0. **Confirm requirements exist first** — ensure a Requirements Specification has been started (see the Requirements Definition procedure above). Do not score a demand on an undocumented brief; capture what is known and flag gaps.
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

### For ARB Submissions

Some decisions must be escalated to the Architecture Review Board. Submit when any of the following apply:
- New technology introduction (not on the approved roadmap)
- Significant departure from EMIS/Optum architecture standards
- Annual cost implication > £100,000
- Cross-team or cross-platform impact
- Security or compliance risk that cannot be fully mitigated

1. Confirm the demand meets ARB escalation criteria
2. Prepare the ARB submission paper — see [ARB Guidance](./references/arb-guidance.md)
3. Submit to the Architecture Review Board at least 5 business days before the ARB session
4. Present the paper and respond to questions at the ARB session
5. Record the ARB decision (Approved / Approved with conditions / Deferred / Rejected) as an ADR
6. If approved with conditions, track conditions to closure and confirm with ARB chair

### For Exceptions and Derogations from Standards

When a project cannot comply with an approved standard and a variance is needed:

1. Identify the specific standard or policy from which a derogation is being requested
2. Document the business justification for the variance
3. Assess the risk introduced by the variance
4. Identify compensating controls that reduce the risk to an acceptable level
5. Complete the Exception/Derogation template — see [Exception & Derogation Template](./references/exception-derogation-template.md)
6. Route for approval: Security (for security/compliance derogations) + Senior Architect + ARB if appropriate
7. Record the approved derogation with expiry date and review trigger
8. Track all open derogations in the project risk register

### For Risk Acceptance Decisions

When a risk cannot be mitigated and must be formally accepted:

1. Document the risk in the risk register — see [Risk Register Template](./references/risk-register-template.md)
2. Quantify the risk: likelihood (1–5), impact (1–5), risk score (L×I)
3. Confirm that all reasonable mitigations have been explored and documented
4. Identify the risk owner (the person accountable if the risk materialises)
5. Route for sign-off: CISO for security/compliance risks; CTO/VP Engineering for architectural risks; budget holder for cost risks
6. Record the sign-off name, date, and review date in the risk register
7. Review the risk register at each project milestone

### For Post-Incident Architectural Reviews

After a P1 or P2 incident with architectural implications:

1. Conduct the blameless post-incident review (PIR) within 5 business days (PIMS-led)
2. Identify any architectural root causes or contributing factors
3. For each architectural finding, create an ADR or update an existing one to capture the learning
4. Raise remediation work as a demand in Aha! or ADO — do not rely on the PIR action list alone
5. Review the finding against BC/DR design guide and Well-Architected pillars — is the gap systemic?
6. Update relevant HLD/LLD artefacts to reflect the corrected design

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

- [Requirements Specification Template](./references/requirements-specification-template.md) — Documented requirements record; the mandatory first gate before research, demand review, or design
- [Architecture Assessment Template](./references/architecture-assessment-template.md) — Aha! demand triage scoring template (Stage 1)
- [Demand Review Checklist](./references/demand-review-checklist.md) — Full pre-design demand review (Stage 2)
- [ADR Template](./references/adr-template.md) — Architecture Decision Record template
- [ARB Guidance](./references/arb-guidance.md) — When to escalate to ARB, submission structure, presentation guidance
- [Exception & Derogation Template](./references/exception-derogation-template.md) — Formal process for requesting variances from approved standards
- [Risk Register Template](./references/risk-register-template.md) — Project and programme risk tracking, risk acceptance, and review cadence
