# Exception & Derogation Template

## Overview

An **exception** is a one-off departure from an approved standard for a specific project or workstream.  
A **derogation** is a recognised ongoing variance from a standard for a specific system or environment.

Both must be formally documented, risk-assessed, approved, and time-limited. Exceptions and derogations are not permanent — they expire and must be reviewed before renewal.

> **IMPORTANT**: An exception/derogation does not grant permission to skip the associated security controls. Compensating controls must be in place to reduce the risk to an acceptable level.

---

## Exception / Derogation Register (summary index)

Maintain a summary register of all active exceptions and derogations. Update this whenever a new one is created, extended, or closed.

| ID | Standard / Policy | System / Project | Approved By | Expiry Date | Status |
|---|---|---|---|---|---|
| EXC-001 | | | | | Active |
| DER-001 | | | | | Active |

---

## Exception / Derogation Request Template

### 1. Reference Information

| Field | Value |
|---|---|
| **Exception ID** | EXC-YYYY-NNN (auto-assign or use next sequential number) |
| **Type** | Exception (one-off) / Derogation (ongoing) |
| **Date Raised** | YYYY-MM-DD |
| **Raised By** | Name, Role |
| **System / Project** | Name of the system or project requiring the variance |
| **Environment** | Production / Non-Production / All |

---

### 2. Standard or Policy Being Deviated From

| Field | Value |
|---|---|
| **Standard / Policy Reference** | e.g., EMIS Security Baseline v2.1, CIS Level 2 Control 5.1, NIST AC-6, Atlas_Architect Guardrails Section 2 |
| **Requirement Text** | Paste the specific requirement being deviated from |
| **Approved Standard (what should be in place)** | Describe what full compliance looks like |

---

### 3. What Is Being Requested

Describe clearly and specifically what the variance is:

> _e.g., "Permission to use HTTP (port 80) for internal health check endpoints on the EKS cluster, rather than HTTPS as required by the EMIS network security baseline."_

---

### 4. Business Justification

Explain **why** full compliance is not achievable for this case:

> _e.g., "The target load balancer health check mechanism does not support certificate-based HTTPS for internal traffic on the private subnet. Implementing a custom certificate chain would add 6 weeks to the delivery timeline and £15k in engineering cost. The risk is limited to internal traffic only."_

---

### 5. Risk Assessment

| Risk Factor | Assessment |
|---|---|
| **Risk Description** | What could go wrong if this variance is permitted |
| **Likelihood** | 1 (Rare) / 2 (Unlikely) / 3 (Possible) / 4 (Likely) / 5 (Almost Certain) |
| **Impact** | 1 (Negligible) / 2 (Minor) / 3 (Moderate) / 4 (Major) / 5 (Critical) |
| **Risk Score** | Likelihood × Impact = |
| **Risk Rating** | Low (1–4) / Medium (5–9) / High (10–16) / Critical (17–25) |
| **Data Classification** | Does this affect PHI/PII or regulated data? Yes / No |

---

### 6. Compensating Controls

List the controls that will reduce the risk introduced by the variance. For every exception or derogation, at least one compensating control is required:

| Control | Description | Owner | Implemented By |
|---|---|---|---|
| | | | |
| | | | |

---

### 7. Time Limit and Review

| Field | Value |
|---|---|
| **Requested Duration** | e.g., 90 days / 6 months / 1 year |
| **Proposed Expiry Date** | YYYY-MM-DD |
| **Review Trigger** | What would cause this to be reviewed earlier? e.g., compliance audit, platform upgrade, incident |
| **Remediation Plan** | What is the long-term plan to achieve full compliance? If no remediation is planned, state why. |

---

### 8. Approval Chain

| Approver | Role | Decision | Date | Signature / JIRA Ref |
|---|---|---|---|---|
| Senior Architect | Technical peer reviewer | Approve / Reject | | |
| ESRO / Security | Security impact validation | Approve / Reject | | |
| CISO (if Risk ≥ High) | Risk owner sign-off | Approve / Reject | | |
| ARB Chair (if escalation criteria met) | ARB-level deviation | Approve / Reject | | |

> See [ARB Guidance](./arb-guidance.md) for escalation criteria.

---

### 9. Related Records

| Field | Value |
|---|---|
| **Related ADR** | Link to Architecture Decision Record |
| **Related Demand / Project** | Aha! or ADO reference |
| **Related Risk Register Entry** | Risk ID in project risk register |
| **ServiceNow Change Request** | If this exception is linked to a live change |

---

## Renewal Process

Exceptions and derogations must be reviewed before their expiry date:

1. At least 4 weeks before expiry, the raising team must assess whether the derogation is still required
2. If still required: re-assess the risk, update compensating controls, re-route through the approval chain, and issue a new expiry date
3. If no longer required: mark as Closed in the register and confirm that full compliance has been achieved
4. If expired without renewal: the system is non-compliant; a remediation plan must be raised immediately

---

## Exception vs Derogation Decision Guide

| Scenario | Correct Type |
|---|---|
| Single project, one-time delivery need, will be resolved within 12 months | **Exception** |
| System-level, long-standing limitation due to legacy technology, affects multiple projects | **Derogation** |
| A temporary workaround while the permanent fix is delivered | **Exception** |
| Permanent architectural choice that deviates from a standard | **Derogation** — but first assess whether a design change is possible |
| You're not sure | Raise as Exception; review at expiry |

---

## Approval Authority Matrix

| Risk Rating | Required Approvers |
|---|---|
| Low (1–4) | Senior Architect + Security review |
| Medium (5–9) | Senior Architect + ESRO/Security sign-off |
| High (10–16) | CISO sign-off required; ARB if any ARB escalation criteria met |
| Critical (17–25) | CTO/VP Engineering + CISO + ARB mandatory |
