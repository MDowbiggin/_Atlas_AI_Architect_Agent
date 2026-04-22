# Risk Register Template

## Overview

The risk register is the central record for all identified risks on a project or programme. It is a living document — risks are added throughout the project lifecycle, updated at each review, and closed when they are no longer relevant.

**This register is distinct from:**
- The risk assessment section within the **Demand Review Checklist** (Stage 2 demand triage only)
- The risk column within an **Exception/Derogation record**
- Security control deficiency tracking (owned by ESRO/Security)

---

## Risk Register — Summary Table

| Risk ID | Category | Description | L | I | Score | Rating | Owner | Status | Review Date |
|---|---|---|---|---|---|---|---|---|---|
| RISK-001 | | | | | | | | Open | |
| RISK-002 | | | | | | | | Open | |

**L** = Likelihood (1–5) | **I** = Impact (1–5) | **Score** = L × I

---

## Risk Register — Full Entry Template

Complete one entry per risk. Add to the summary table above.

---

### Risk ID: RISK-XXX

| Field | Value |
|---|---|
| **Risk ID** | RISK-YYYY-NNN (project code + sequential number) |
| **Date Identified** | YYYY-MM-DD |
| **Identified By** | Name, Role |
| **Category** | See Risk Categories below |
| **Risk Title** | Short descriptive title (max 10 words) |

**Risk Description**

> _Describe the risk clearly using the format: "There is a risk that [event], resulting in [consequence]."_

**Cause**

> _What could cause this risk to materialise? Identify root drivers._

**Consequence**

> _If the risk materialises, what is the impact on the project, service, or organisation?_

---

#### Inherent Risk Assessment (before controls)

| Field | Value |
|---|---|
| **Likelihood** | 1 (Rare) / 2 (Unlikely) / 3 (Possible) / 4 (Likely) / 5 (Almost Certain) |
| **Impact** | 1 (Negligible) / 2 (Minor) / 3 (Moderate) / 4 (Major) / 5 (Critical) |
| **Risk Score** | Likelihood × Impact = |
| **Risk Rating** | Low (1–4) / Medium (5–9) / High (10–16) / Critical (17–25) |
| **Affects PHI/PII?** | Yes / No |
| **Regulatory / Compliance risk?** | Yes / No — specify standard if yes |

---

#### Mitigation Strategy

| Field | Value |
|---|---|
| **Response Type** | Avoid / Reduce / Transfer / Accept |
| **Mitigation Actions** | List specific actions being taken to reduce likelihood or impact |
| **Action Owner** | Name, Role |
| **Target Completion Date** | YYYY-MM-DD |
| **Progress Update** | Current status of mitigation actions |

---

#### Residual Risk Assessment (after controls applied)

| Field | Value |
|---|---|
| **Residual Likelihood** | 1–5 |
| **Residual Impact** | 1–5 |
| **Residual Risk Score** | L × I = |
| **Residual Risk Rating** | Low / Medium / High / Critical |

---

#### Risk Acceptance (required if residual risk is not Low)

If the residual risk remains Medium or higher and cannot be further reduced, formal acceptance is required.

| Field | Value |
|---|---|
| **Acceptance Required?** | Yes / No (if Low, acceptance may be implicit) |
| **Business Justification** | Why this risk is being accepted rather than further mitigated |
| **Risk Acceptance Authority** | See Acceptance Authority Matrix below |
| **Accepted By** | Name, Role |
| **Date Accepted** | YYYY-MM-DD |
| **Acceptance Expiry / Review Date** | YYYY-MM-DD (risk acceptances do not last indefinitely) |

---

#### Risk Tracking

| Field | Value |
|---|---|
| **Status** | Open / In Mitigation / Accepted / Transferred / Closed |
| **Next Review Date** | YYYY-MM-DD |
| **Related Exception/Derogation** | Link to EXC/DER record if applicable |
| **Related ADR** | Link to Architecture Decision Record if applicable |
| **Related ServiceNow Ticket** | If remediation work is tracked in SNOW |
| **Closure Notes** | Date and reason for closure (when moving to Closed) |

---

## Risk Categories

| Category | Description | Examples |
|---|---|---|
| **Technical** | Design, architecture, or technology risk | Platform immaturity, integration complexity, API instability |
| **Security** | Cybersecurity, data protection, or access control risk | Unpatched vulnerability, exposed endpoint, weak authentication |
| **Compliance** | Regulatory or policy non-compliance | HIPAA gap, CIS baseline deviation, NHS DSP Toolkit failure |
| **Commercial** | Cost, contract, or vendor risk | Cost overrun, licence non-compliance, vendor lock-in |
| **Operational** | BAU delivery, staffing, or support readiness | Skill gap, PIMS capacity, runbook incomplete |
| **Timeline / Delivery** | Project delivery risk | Dependency delay, scope creep, resource unavailability |
| **Strategic** | Alignment to EMIS/Optum strategy | Technology debt, deprecated platform in use, misaligned priority |

---

## Risk Scoring Matrix

|  | **1 — Negligible** | **2 — Minor** | **3 — Moderate** | **4 — Major** | **5 — Critical** |
|---|---|---|---|---|---|
| **5 — Almost Certain** | 5 (M) | 10 (H) | 15 (H) | 20 (C) | 25 (C) |
| **4 — Likely** | 4 (L) | 8 (M) | 12 (H) | 16 (H) | 20 (C) |
| **3 — Possible** | 3 (L) | 6 (M) | 9 (M) | 12 (H) | 15 (H) |
| **2 — Unlikely** | 2 (L) | 4 (L) | 6 (M) | 8 (M) | 10 (H) |
| **1 — Rare** | 1 (L) | 2 (L) | 3 (L) | 4 (L) | 5 (M) |

**L** = Low (1–4) | **M** = Medium (5–9) | **H** = High (10–16) | **C** = Critical (17–25)

---

## Risk Acceptance Authority Matrix

| Residual Risk Rating | Minimum Acceptance Authority |
|---|---|
| **Low (1–4)** | Project Manager or Technical Lead (can be implicit, documented in meeting notes) |
| **Medium (5–9)** | Senior Architect or Programme Manager (explicit sign-off required) |
| **High (10–16)** | Director/VP level + CISO for Security risks (written approval required) |
| **Critical (17–25)** | CTO/VP Engineering + CISO + ARB (ARB presentation required) |

> **Security/HIPAA risks**: Any risk affecting PHI/PII or regulatory compliance must be reviewed by ESRO/Security regardless of the overall risk score. The CISO must formally accept any residual security or compliance risk rated Medium or above.

---

## Risk Review Cadence

| Project Phase | Review Frequency |
|---|---|
| Pre-delivery / Design | At each stage gate (Demand Review, Design Review, Security Review) |
| Active delivery | Minimum fortnightly; weekly for Critical risks |
| Post-go-live (first 30 days) | Weekly |
| BAU stabilisation | Monthly until all risks are Low or Closed |
| Routine BAU | Quarterly (via operational risk review) |

---

## Risk Escalation Process

1. If a risk moves from Medium → High, immediately notify the Programme/Architecture Lead
2. If a risk moves to Critical, escalate to CTO/VP Engineering and CISO within 24 hours
3. If a risk materialises (becomes an Issue), move to the Issues Log and raise a ServiceNow incident if required
4. Risks relating to external dependencies (vendor, NHS Digital, third-party APIs) must be flagged to the Vendor Management process

---

## Issues Log — Materialised Risks

When a risk materialises and becomes an actual problem (an Issue), record it here:

| Issue ID | Original Risk ID | Description | Date Materialised | Impact | Owner | Resolution Actions | Resolution Date |
|---|---|---|---|---|---|---|---|
| ISS-001 | RISK-XXX | | | | | | |

---

## Assumptions Log

Assumptions underpin many risk assessments. Record key assumptions to highlight where new information could change the risk picture:

| Assumption ID | Assumption | Impact if Wrong | Risk IDs Affected | Status |
|---|---|---|---|---|
| ASS-001 | | | | Active |
