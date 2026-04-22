# Post-Incident Review (PIR) Template

## Overview

A Post-Incident Review is a structured, blameless analysis of a significant incident. The goal is to understand what happened, why it happened, and what changes prevent recurrence — not to assign blame.

**When a PIR is required:**
- All P1 incidents (full or partial service outage affecting production users)
- P2 incidents with architectural root causes or significant recovery complexity
- Any incident that triggered a DR failover
- Any incident exposing a compliance or security gap

**Timeline:** PIR must be completed within 5 business days of incident resolution. Draft within 48 hours; review and publish within 5 days.

> PIR findings with architectural implications must result in an ADR (update existing or raise new) and a tracked remediation demand in Aha! or ADO. Do not rely on the PIR action list alone.

---

## Document Control

| Item | Detail |
|------|--------|
| Document ID | PIR-YYYY-NNN |
| Version | 1.0 |
| Author | [Lead investigator — typically architect or senior engineer] |
| Date | YYYY-MM-DD |
| Classification | Internal |
| Incident Reference | INC[XXXXXXX] (ServiceNow) |
| Related HLD/LLD | HLD-[XXXX] / LLD-[XXXX] |
| Reviewers | [Names and roles — include PIMS lead, security if applicable] |

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 0.1 | YYYY-MM-DD | [Name] | Initial draft |
| 1.0 | YYYY-MM-DD | [Name] | Final — reviewed and published |

---

## 1. Incident Summary

| Field | Detail |
|-------|--------|
| **Incident Title** | [Short descriptive title] |
| **Severity** | P1 / P2 |
| **Date & Time (UTC)** | Start: YYYY-MM-DD HH:MM \| End: YYYY-MM-DD HH:MM |
| **Total Duration** | [X hours Y minutes] |
| **Detection Method** | Dynatrace Alert / User Report / Monitoring Dashboard / ServiceNow Ticket |
| **Time to Detect** | [Time from first failure to alert/awareness] |
| **Time to Resolution** | [Time from detection to service restored] |
| **Services Affected** | [List affected CMDB CIs / applications] |
| **User Impact** | [Description of what users experienced / number affected (no PHI)] |
| **Data Impact** | [Any data loss or corruption — specify if none] |
| **SLA Breach?** | Yes / No — [If yes, specify SLA and breach duration] |
| **DR Invoked?** | Yes / No |

---

## 2. Incident Timeline

> Document key events in chronological order. Be specific about times. Use UTC.

| Time (UTC) | Event | Who |
|------------|-------|-----|
| HH:MM | [Event description] | [Person / system] |
| HH:MM | Incident detected | [Who detected it] |
| HH:MM | On-call notified | [Notification method] |
| HH:MM | [Diagnostic step taken] | [Who] |
| HH:MM | [Mitigation applied] | [Who] |
| HH:MM | Service restored (partial) | [Who confirmed] |
| HH:MM | Service fully restored | [Who confirmed] |
| HH:MM | Incident closed in ServiceNow | [Who] |

---

## 3. Root Cause Analysis

### 3.1 Root Cause Statement

> State the root cause in one or two sentences. Be specific and technical.

_The root cause was [specific technical cause]. This was introduced by [specific change, configuration, or condition]._

### 3.2 Five Whys Analysis

| Why | Answer |
|-----|--------|
| Why did the service fail? | |
| Why did [above] happen? | |
| Why did [above] happen? | |
| Why did [above] happen? | |
| Why did [above] happen? (root cause) | |

### 3.3 Root Cause Category

Select all that apply:

- [ ] Infrastructure failure (hardware, platform, cloud service)
- [ ] Configuration error (manual or IaC)
- [ ] Software defect (application code or dependency)
- [ ] Capacity / scale failure
- [ ] Security incident or attack
- [ ] Third-party / vendor failure
- [ ] Process failure (change management, deployment, patching)
- [ ] Monitoring / detection gap (failure not detected promptly)
- [ ] Human error (operational)
- [ ] Architectural design gap

---

## 4. Contributing Factors

> List factors that made the incident worse, harder to detect, or harder to resolve. These are not root causes themselves.

| Factor | Category | Notes |
|--------|----------|-------|
| [e.g., Alert threshold was too high] | Monitoring gap | |
| [e.g., Runbook outdated] | Documentation gap | |
| [e.g., On-call engineer unfamiliar with component] | Skills gap | |
| [e.g., No DR test had been performed] | Process gap | |

---

## 5. What Went Well

> Be specific — note things that worked and should be reinforced or replicated.

-
-
-

---

## 6. What Didn't Go Well

> Focus on systems, processes, and design — not on individuals.

-
-
-

---

## 7. Action Items

### Immediate Actions (within 48 hours — already taken)

| Action | Owner | Completed |
|--------|-------|-----------|
| [e.g., Increase alert threshold] | [Name] | ✅ YYYY-MM-DD |

### Short-Term Actions (within 2 weeks)

| # | Action | Type | Owner | Due Date | ADO/Aha! Ref |
|---|--------|------|-------|----------|--------------|
| 1 | [Action] | Monitoring / Config / Process / Doc | [Name] | YYYY-MM-DD | |
| 2 | | | | | |

### Long-Term Actions (within 90 days — architectural remediation)

| # | Action | Type | Owner | Due Date | ADO/Aha! Ref | ADR Required? |
|---|--------|------|-------|----------|--------------|---------------|
| 1 | [Action] | Architecture / Resilience / Design | [Name] | YYYY-MM-DD | | Yes / No |
| 2 | | | | | | |

> Long-term actions requiring architectural change **must** be raised as a demand in Aha! within 5 business days of PIR publication. Link the demand here once raised.

---

## 8. Architectural Implications

> Complete this section if the root cause or any contributing factor relates to the architecture of the system.

| Finding | Implication | Recommended Change | ADR Reference |
|---------|-------------|-------------------|---------------|
| [e.g., Single-region deployment caused full outage] | No DR for this service | Implement geo-replication + failover | ADR-XXXX (raise new) |

### Well-Architected Framework Assessment

Identify which pillar(s) this incident exposed a gap in:

| Pillar | Gap Identified | Action |
|--------|---------------|--------|
| Reliability | | |
| Security | | |
| Operational Excellence | | |
| Performance Efficiency | | |
| Cost Optimisation | | |
| Sustainability | | |

### Architecture Standards Review

- [ ] BC/DR design guide reviewed against incident findings — [outcome]
- [ ] Security baselines reviewed — [any gaps]
- [ ] Relevant HLD/LLD updated to reflect corrected design — [link]
- [ ] CMDB updated to reflect any changes — [reference]

---

## 9. Communication Log

> Record all stakeholder communications during and after the incident.

| Time (UTC) | Audience | Channel | Message Summary | Sent By |
|------------|----------|---------|----------------|---------|
| HH:MM | [All users / Business / Management] | [Email / Teams / Status page] | [Content summary] | [Who] |
| HH:MM | Resolution communicated | [Channel] | Service restored | [Who] |
| HH:MM | PIR published | Confluence / SharePoint | [Link to this document] | [Who] |

---

## 10. Lessons Learned

> Summarise the top 3 lessons from this incident. These should feed into architecture standards, runbook updates, or training.

| # | Lesson | Action to Embed Learning |
|---|--------|-------------------------|
| 1 | | |
| 2 | | |
| 3 | | |

---

## 11. Sign-Off

| Role | Name | Date | Notes |
|------|------|------|-------|
| Incident Lead | | | |
| Solutions Architect | | | |
| PIMS Team Lead | | | |
| Security / ESRO (if security-related) | | | |

---

## PIR Checklist

Before marking the PIR as complete and publishing:

- [ ] Timeline is accurate and complete
- [ ] Root cause is specific and technically correct (not vague, e.g., not just "human error")
- [ ] All contributing factors documented
- [ ] Action items have named owners and due dates
- [ ] All architectural implications assessed
- [ ] Long-term architectural actions raised as Aha! demands
- [ ] ADRs created or updated for architectural findings
- [ ] Relevant HLD/LLD marked for update (or updated)
- [ ] CMDB updated if system inventory changed
- [ ] Communication log complete
- [ ] Lessons learned captured
- [ ] PIR reviewed by PIMS lead and architect before publishing
- [ ] PIR stored in SharePoint/Confluence; linked from ServiceNow incident record
