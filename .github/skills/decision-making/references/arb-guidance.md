# Architecture Review Board (ARB) — Guidance

## What is the ARB?

The Architecture Review Board is the governance body responsible for approving significant architecture decisions, new technology introductions, and high-impact or high-risk changes within EMIS/Optum infrastructure. ARB sign-off provides formal assurance that:

- Decisions align with the EMIS/Optum technology roadmap and approved standards
- Security and compliance risks have been assessed and addressed
- Costs and operational implications are understood and budgeted
- Lessons from previous decisions have been considered

ARB decisions are final and supersede individual team preferences. Approved decisions must be recorded as ADRs.

---

## Escalation Criteria — When ARB Is Mandatory

Submit to ARB when **any** of the following apply:

| Criterion | Threshold | Notes |
|---|---|---|
| New technology | Not on the approved roadmap | Including open-source tools not previously used at scale |
| Significant architecture departure | Structural change to approved patterns | e.g., moving from IaaS to PaaS, new networking topology |
| Annual cost implication | > £100,000 ARR | New spend; check against existing approved budgets |
| One-off cost implication | > £25,000 | Infrastructure procurement, licences, professional services |
| Security/compliance impact | Reduction in security posture or policy deviation | Any CIS, HIPAA, NIST, or EMIS baseline exception |
| Cross-team or cross-platform impact | Affects 2+ PIMS domains | e.g., CloudOps + Platform Engineering + Security |
| External integration | New third-party API or system integration | Including NHS Digital, PCSE, or clinical system connections |

> **Note:** The cost thresholds above align with those in the Atlas_Architect Guardrails. If in doubt, escalate — it is always better to seek ARB review than to propose something and be rejected mid-delivery.

---

## ARB Membership

| Role | Responsibility |
|---|---|
| Architecture Lead / Principal Architect | Chair — facilitates the session and records decisions |
| Security / ESRO representative | Validates security and compliance controls |
| Platform Engineering representative | Reviews technical feasibility and platform readiness |
| CloudOps representative | Operational impact and supportability assessment |
| Finance / FinOps representative | Cost approval and budget confirmation |
| Product / Business stakeholder | Business alignment and requirements ownership |
| External SME (as required) | Vendor or specialist input where needed |

---

## How to Prepare an ARB Submission

### 1. Confirm escalation is required

Check the escalation criteria above. If one or more criteria are met, begin the submission process immediately — do not wait until the design is complete.

### 2. Complete the ARB submission paper

The submission must include the following sections:

| Section | Content |
|---|---|
| **Executive Summary** | Problem being solved, recommended option, and total cost impact (max 1 page) |
| **Strategic Alignment** | Which EMIS/Optum strategic priority this supports and how |
| **Options Considered** | Minimum 2 options plus do-nothing; compare using the Option Analysis template from the decision-making skill |
| **Recommended Option** | Rationale for the recommendation; why alternatives were rejected |
| **Architecture Overview** | High-level Mermaid diagram (C4 Level 1 or 2) and key design decisions |
| **Security & Compliance** | How the design meets the EMIS/Optum security baselines; any residual risks and mitigations |
| **Cost Summary** | CapEx, OpEx, and TCO over 3 years; confirm against budget |
| **Operational Impact** | PIMS handover requirements, SLA implications, monitoring and alerting needs |
| **Risks & Dependencies** | Top 3 risks with likelihood, impact, mitigation, and risk owner |
| **Timeline & Milestones** | Key phases and decision gates |
| **ADR Reference** | Link to the draft ADR that will be updated post-ARB |

### 3. Submit at least 5 business days before the ARB session

Send the completed paper to the ARB chair for scheduling. Late submissions may be deferred to the next session.

### 4. Prepare for questions

Expect ARB members to probe on:

- Why was this option chosen over alternatives?
- What happens if costs increase beyond the estimate?
- How does this affect the technology roadmap?
- What team owns this in BAU, and are they ready?
- What's the rollback/exit strategy if the solution doesn't work?
- Does this create vendor lock-in, and is that acceptable?

Bring a technical SME if the solution has deep technical complexity.

---

## ARB Decision Outcomes

| Decision | Meaning | Next Step |
|---|---|---|
| **Approved** | Proceed as proposed | Update ADR to Accepted; begin delivery |
| **Approved with conditions** | Proceed with specific constraints | Track conditions to closure; confirm with ARB chair before go-live |
| **Deferred** | More information required | Address ARB feedback and resubmit at next session |
| **Rejected** | Proposal cannot proceed as presented | Review the feedback; either redesign and resubmit or escalate to programme leadership |

---

## Recording the ARB Decision

1. Update the ADR status to `Accepted` (or `Rejected` with rationale)
2. Add ARB decision date, outcome, and any conditions to the ADR
3. Store the ARB submission paper in the project SharePoint/Confluence space
4. If approved with conditions, create tracked actions in the project ADO board
5. Notify all affected stakeholders of the decision within 2 business days

---

## ARB and the Change Management Process

ARB approval authorises the **architecture** — it does not replace ServiceNow change management for the **implementation**. After ARB sign-off:

- Detailed LLD must still be completed and peer reviewed
- ServiceNow Change Request must be raised before any production implementation
- BAU handover documentation must be completed before operational sign-off

---

## Frequently Asked Questions

**Q: Can I start design work before ARB approval?**
A: Yes — you can and should complete the HLD before ARB submission. You may not proceed to LLD, procurement, or implementation until ARB approves.

**Q: What if a decision is urgent and there is no ARB session scheduled?**
A: Request an emergency ARB session with the ARB chair. If truly time-critical, escalate to the Architecture Lead and CTO for an expedited decision, and retrospectively ratify at the next ARB.

**Q: Who decides if something meets the ARB escalation criteria?**
A: The Principal/Lead Architect makes the initial call. If in doubt, assume it requires ARB and escalate — it is better to submit unnecessarily than to proceed without required sign-off.

**Q: Can ARB decisions be appealed?**
A: Yes — route appeals through the Architecture Lead to CTO/VP Engineering. Document the appeal rationale fully.
