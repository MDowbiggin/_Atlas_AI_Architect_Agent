# Requirements Specification Template

## Overview

This is the **canonical requirements record** for any Aha! demand review, new project request, technology evaluation, research task, or investigation. Per **Section 7 (Requirements Definition)** of the Atlas guardrails, a clear, documented set of requirements **MUST** exist before research, option analysis, or design work begins.

This document is the single source of truth for requirements. It is version-controlled and every downstream finding, option, design decision, and recommendation must trace back to a requirement, constraint, or stated assumption recorded here.

### When to Use

- A new demand arrives in Aha! (Hosted Services or Platform Engineering pivots) and needs triage or review
- A new project request is received via ServiceNow, ADO, or directly
- Research or investigation into technologies or solutions is requested
- Before producing an Architecture Assessment, Demand Review, HLD, LLD, or any option analysis

### Proceed-but-Flag Model

Requirements are rarely complete on day one. Atlas does **not** stall — it captures everything currently known, **explicitly records the gaps, open questions, and assumptions**, and requests confirmation from the requestor before treating any assumption as fact. Research and analysis may proceed against documented assumptions, but every finding and recommendation must be clearly caveated as **assumption-dependent** until the requirements are confirmed.

---

## Template

The following is the **canonical output format** for all Atlas_Architect Requirements Specifications. Every output must follow this structure. Section order and heading levels are fixed; do not remove mandatory sections.

```markdown
# Requirements Specification — [Demand / Project Title]

**Classification:** Internal *(default; raise to Confidential/Restricted if commercially sensitive — never embed PHI/PII)*
**Version:** 0.1
**Status:** Draft — Requirements Unconfirmed / Confirmed by Requestor / Superseded
**Date:** [DD Month YYYY]
**Author:** [Architect name]

---

## Document Control

| Item | Detail |
|------|--------|
| Demand / Request ID | [Aha! / ServiceNow / ADO reference] |
| Requestor | [Name and team] |
| Business Sponsor | [Name and team] |
| Date Raised | YYYY-MM-DD |
| Required-By Date | YYYY-MM-DD |
| Reviewer | [Architect name] |

### Change History

| Version | Date | Author | Change |
|---------|------|--------|--------|
| 0.1 | YYYY-MM-DD | | Initial capture |

---

## 1. Requirements Readiness Summary

> Complete this first. It is the at-a-glance gate status for stakeholders.

| Requirement Area | Status | Notes |
|------------------|:------:|-------|
| Functional requirements | ✅ Confirmed / ⚠️ Partial / ❌ Missing | |
| Non-functional requirements | ✅ / ⚠️ / ❌ | |
| Security & compliance requirements | ✅ / ⚠️ / ❌ | |
| Constraints & assumptions | ✅ / ⚠️ / ❌ | |
| In-scope / out-of-scope | ✅ / ⚠️ / ❌ | |
| Success / acceptance criteria | ✅ / ⚠️ / ❌ | |
| Stakeholders, requestor & driver | ✅ / ⚠️ / ❌ | |
| Cost / budget envelope & timeline | ✅ / ⚠️ / ❌ | |

**Overall readiness:** ✅ Ready to proceed / ⚠️ Proceed against documented assumptions (gaps flagged below) / ❌ Insufficient — confirmation required before work begins

---

## 2. Business Context

| Item | Detail |
|------|--------|
| **Business Driver** | [Why is this needed? Cost / Resilience / Security / Speed / Compliance / Growth] |
| **Problem Statement** | [What problem is being solved?] |
| **Desired Outcome** | [What does good look like?] |
| **Consuming Users / Teams** | [Who uses the result?] |

---

## 3. Functional Requirements

> What the solution must do — capabilities, behaviours, integrations. Use MoSCoW prioritisation.

| ID | Requirement | Priority (M/S/C/W) | Source | Notes |
|----|-------------|:------------------:|--------|-------|
| FR-01 | | Must | | |
| FR-02 | | Should | | |

---

## 4. Non-Functional Requirements

| ID | Category | Requirement | Target | Notes |
|----|----------|-------------|--------|-------|
| NFR-01 | Availability | [e.g., uptime] | [e.g., 99.9%] | |
| NFR-02 | Performance | [e.g., response time] | [e.g., < 200ms] | |
| NFR-03 | Scalability | [e.g., concurrent users / throughput] | | |
| NFR-04 | DR / BCP | RTO / RPO | [e.g., RTO 1h, RPO 15m] | |
| NFR-05 | Data Residency | [e.g., UK only] | | |
| NFR-06 | Maintainability / Supportability | [PIMS handover expectations] | | |

---

## 5. Security & Compliance Requirements

| ID | Control Area | Requirement | Applicable Standard | Notes |
|----|--------------|-------------|---------------------|-------|
| SC-01 | Data Classification | [Public / Internal / Confidential / Restricted] | — | |
| SC-02 | Encryption | At rest (AES-256) + in transit (TLS 1.2+) | HIPAA / CIS | |
| SC-03 | Access Control | Least privilege; MFA; PAM via Delinea | NIST / ISO 27001 | |
| SC-04 | Audit Logging | [Audit trail requirements] | HIPAA | |
| SC-05 | Network | Segmentation; WAF/DDoS for public endpoints | CIS Level 2 | |
| SC-06 | Regulatory | [HIPAA / NHS DSPT / other] | | |

> Does this solution process PHI/PII? **Yes / No.** If Yes, a full Compliance Mapping and Security Review are mandatory before design sign-off.

---

## 6. Constraints & Assumptions

### Constraints

| ID | Type | Constraint | Impact |
|----|------|-----------|--------|
| CON-01 | Technical | [e.g., must run on approved AWS landing zone] | |
| CON-02 | Commercial | [e.g., budget cap, existing licensing] | |
| CON-03 | Regulatory | [e.g., data must remain in UK] | |
| CON-04 | Timeline | [e.g., hard go-live date] | |

### Assumptions

| ID | Assumption | Confidence | Validation Owner | Status |
|----|-----------|:----------:|------------------|--------|
| ASM-01 | | High / Med / Low | | Open / Confirmed / Rejected |

---

## 7. Scope

### In Scope

-

### Out of Scope

-

---

## 8. Success / Acceptance Criteria

> Measurable conditions that define "done" and acceptance.

| ID | Criterion | How Measured | Owner |
|----|-----------|--------------|-------|
| AC-01 | | | |

---

## 9. Stakeholders

| Role | Name | Team | Responsibility (RACI) |
|------|------|------|-----------------------|
| Requestor | | | A/R |
| Business Sponsor | | | A |
| Solutions Architect | | Infrastructure Solutions Architecture | R |
| Security | | Security Architecture | C |
| Operations | | PIMS / CloudOps | C/I |

---

## 10. Cost & Timeline Envelope

| Item | Detail |
|------|--------|
| **Indicative Budget Tolerance** | [ROM range or cap] |
| **Funding Source** | [CapEx / OpEx / project code] |
| **Required-By Date** | YYYY-MM-DD |
| **Key Milestones** | [If known] |

> Flag for review if indicative annual recurring cost > £50,000 or one-off > £25,000 (per guardrails Section 4).

---

## 11. Open Questions & Gaps (Confirmation Required)

> List every gap, ambiguity, and assumption that must be confirmed by the requestor before treating it as fact. Work performed against these items must be caveated as assumption-dependent.

| # | Open Question / Gap | Owner | Blocking? | Status |
|---|---------------------|-------|:---------:|--------|
| 1 | | Requestor | Yes / No | Open |

---

## 12. Sign-Off

| Role | Name | Confirmed Requirements? | Date |
|------|------|:-----------------------:|------|
| Requestor | | Yes / No | |
| Solutions Architect | | Yes / No | |

---

*Document generated by Atlas_Architect | [Demand / Request ID] | Version [x.x] | Status: [Draft — Unconfirmed / Confirmed]*
```

---

## Relationship to Other Artefacts

The Requirements Specification is the **first artefact** produced and the foundation for everything that follows.

| Stage | Artefact | Depends On |
|-------|----------|-----------|
| **Requirements Gate** | Requirements Specification (this template) | The raw request / brief |
| **Initial Triage** | [Architecture Assessment](./architecture-assessment-template.md) | Requirements Specification |
| **Pre-Design Gate** | [Demand Review Checklist](./demand-review-checklist.md) | Requirements Specification |
| **Design** | HLD / LLD (see `/output`) | Confirmed Requirements Specification |
| **Decisions** | [ADR](./adr-template.md) | Requirements Specification |

> If requirements change after design begins, update this document, re-confirm with the requestor, increment the version, and assess the impact on downstream artefacts.
