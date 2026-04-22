# PIMS Operating Model

## Overview

This document details how PIMS operates on a day-to-day basis and how other teams (Architecture, Engineering, Security, Product) interact with PIMS.

## Operating Rhythm

### Daily

| Activity | Time | Owner | Description |
|----------|------|-------|-------------|
| Morning Stand-Up | 09:00 | Team Leads | Review overnight incidents, P1/P2 status, day's priorities |
| Incident Triage | Continuous | On-call + Shift | Triage incoming incidents; assign priority; escalate as needed |
| Change Implementation | Per schedule | Change Implementers | Execute approved changes within maintenance windows |
| Monitoring Review | Continuous | CloudOps | Review Dynatrace problems, Azure Monitor alerts, cost anomalies |

### Weekly

| Activity | Day | Owner | Description |
|----------|-----|-------|-------------|
| Change Advisory Board (CAB) | [INTERNAL — populate: day] | Service Management | Review and approve normal changes for the coming week |
| Capacity Review | [INTERNAL — populate: day] | CloudOps | Review utilisation trends; identify right-sizing opportunities |
| Incident Review | [INTERNAL — populate: day] | Service Management | Review open incidents; trend analysis; identify recurring issues |

### Monthly

| Activity | Owner | Description |
|----------|-------|-------------|
| Service Review | PIMS Leadership | SLA performance, incident trends, cost review, improvement actions |
| Patching Cycle | Platforms & CloudOps | Monthly OS patching window; application patches as scheduled |
| CMDB Reconciliation | Operations | Reconcile CMDB against actual infrastructure |
| Cost Review (FinOps) | CloudOps + FinOps + Finance BP | Budget vs. actual; right-sizing recommendations; reserved capacity utilisation; optimisation actions |

### Quarterly

| Activity | Owner | Description |
|----------|-------|-------------|
| DR Test | All PIMS teams | Disaster recovery test for Tier 1 services |
| Security Posture Review | Security Ops | Compliance dashboard review; gap remediation tracking |
| Capacity Planning | Architecture + CloudOps | Forward-looking capacity assessment; procurement/reservation planning |
| Service Catalogue Review | Service Management | Update service catalogue; adjust SLAs/OLAs if needed |

## Interaction Model

### How to Engage PIMS

| Need | Channel | Process |
|------|---------|---------|
| **New service onboarding** | ServiceNow request → Architecture liaison → PIMS | Submit service onboarding request; architecture provides handover pack |
| **BAU incident** | ServiceNow incident | Raise incident; PIMS triages, assigns, resolves per OLA |
| **Change request** | ServiceNow change | Submit change request; approved via CAB or delegated authority |
| **Capacity request** | ServiceNow request | Submit request for additional capacity; reviewed by CloudOps |
| **Architecture consultation** | Direct contact / scheduled meeting | Engage PIMS early in design for operational feasibility review |
| **Cost optimisation review** | Monthly review / ad-hoc request | Request from CloudOps for right-sizing and optimisation analysis |

### RACI Model (Architecture ↔ PIMS)

| Activity | Architecture | CloudOps | SRE | DBA | Platforms | Operations | FinOps | Security |
|----------|-------------|----------|-----|-----|-----------|------------|--------|----------|
| Solution Design | **R/A** | C | C | C | C | I | I | C |
| Operational Readiness | **R** | C | **A** | C | C | **A** | I | C |
| Handover to BAU | **R** | C | C | C | C | **A** | I | I |
| Incident Response | C | C | **R/A** | C | C | C | I | C |
| Change Implementation | C | **R/A** | C | C | C | **A** | I | C |
| Patching & Updates | I | **R/A** | I | C | C | C | I | C |
| Database Platform Ops | I | I | I | **R/A** | I | I | I | I |
| Cloud Cost Optimisation | C | **R** | I | I | I | I | **A** | I |
| FinOps Reporting | I | **R** | I | I | I | I | **A** | I |
| Security Compliance | C | C | C | C | C | C | I | **R/A** |
| DR Testing | C | C | **R** | C | C | I | I | I |

*R = Responsible, A = Accountable, C = Consulted, I = Informed*

## Escalation Paths

### Technical Escalation

```
L1: On-Call Engineer (Operations/SRE) → L2: Discipline Lead (CloudOps/SRE/DBA/Platforms/FinOps) → L3: PIMS Manager → L4: Head of Infrastructure
```

### Management Escalation

```
PIMS Team Lead → PIMS Manager → Head of Infrastructure → CTO/CIO
```

### Cross-Team Escalation

| Scenario | Escalate To |
|----------|-------------|
| Application-level issue | Engineering/App Support team lead |
| Security incident | Security Operations (ESRO) → CISO |
| Network outage (ISP/carrier) | Network Operations → Vendor support |
| Cloud platform issue | CloudOps → Microsoft/AWS support (with Premier/Enterprise support) |
| Database platform issue | DBA discipline lead → vendor support |
| Cost anomaly or budget breach | FinOps (CloudOps) → Finance BP → budget holder |
| Architecture design concern | Solutions Architecture team lead |
| Commercial/budget issue | Finance business partner |

## Continuous Improvement

### Problem Management

- **Recurring incidents** (≥ 3 in 30 days for same root cause) trigger a Problem record in ServiceNow
- Problem investigation follows root cause analysis methodology
- Architecture engaged when structural design changes are needed
- Problem resolution may result in design enhancement, runbook update, or knowledge article

### Post-Incident Reviews (PIR)

- Mandatory for all P1 incidents; recommended for P2 incidents with architectural implications
- Conducted within 5 business days of resolution using the [PIR Template](../../output/references/pir-template.md)
- Blameless format: focus on systemic improvements, not individuals
- Actions tracked in ServiceNow; Architecture consulted for design-related findings
- Architectural findings must generate an ADR and a tracked Aha! demand within 5 business days of PIR publication
- Findings shared with relevant discipline leads for cross-learning

### Service Improvement Plan

- Improvement initiatives tracked in [INTERNAL — populate: tool/location]
- Prioritised by: customer impact, frequency, cost, effort
- Architecture provides technical guidance for infrastructure improvements
- Quarterly review of improvement plan progress
