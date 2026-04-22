# Business Continuity & Disaster Recovery Design Guide

## Overview

Every production system at EMIS/Optum must have a defined BC/DR strategy. This guide defines the design requirements by service tier, the mandatory design elements, and the EMIS/Optum-specific standards for recovery in Azure and AWS.

> **BC vs DR**: Business Continuity (BC) is the broader capability to sustain operations during a disruption. Disaster Recovery (DR) is the specific technical process of restoring IT systems after a failure. Both must be considered in architecture design.

---

## Service Tier Definitions

Service tiers determine the BC/DR investment level. When designing, confirm the tier with the product owner and document it in the HLD.

| Tier | Description | Typical Systems |
|------|-------------|-----------------|
| **Tier 1 — Mission Critical** | Loss causes patient safety risk, regulatory breach, or significant revenue impact | Patient-facing clinical applications, prescription systems, NHS-connected services |
| **Tier 2 — Business Critical** | Loss causes operational disruption; no immediate patient safety risk | Internal clinical tools, reporting systems, administrative platforms |
| **Tier 3 — Standard** | Loss causes inconvenience; recoverable within 24 hours | Non-critical internal tools, developer environments, batch/analytics |

---

## Recovery Targets by Tier

| Tier | RTO (Recovery Time Objective) | RPO (Recovery Point Objective) | Availability Target |
|------|------|------|------|
| **Tier 1** | ≤ 1 hour | ≤ 15 minutes | ≥ 99.99% |
| **Tier 2** | ≤ 4 hours | ≤ 1 hour | ≥ 99.9% |
| **Tier 3** | ≤ 24 hours | ≤ 24 hours | ≥ 99.5% |

> **Note**: These are the EMIS/Optum minimums. Contractual SLAs or NHS requirements may impose stricter targets. Always validate against the applicable service contract.

---

## Recovery Strategies

### Hot Standby (Active-Active)

**When to Use**: Tier 1 where RTO ≤ 15 minutes and zero data loss is required.

| Platform | Implementation |
|----------|---------------|
| **AWS (Primary)** | Multi-Region Active-Active using Route 53 Geoproximity or Latency routing; Aurora Global Database (< 1s replication lag); DynamoDB Global Tables |
| **Azure (Secondary)** | Azure Front Door with active-active backend pools; Azure SQL auto-failover groups across paired regions (UK South / UK West) |

**Cost**: ~2-3x single region. Justify explicitly in HLD cost section.

---

### Warm Standby (Active-Passive)

**When to Use**: Tier 1/2 where RTO ≤ 1-4 hours is acceptable.

| Platform | Implementation |
|----------|---------------|
| **AWS (Primary)** | Scaled-down ASG in secondary region (`eu-west-1` Ireland); RDS cross-region read replica (promote on failover); Route 53 health-check failover routing |
| **Azure (Secondary)** | Stopped VM Scale Set in UK West; Azure SQL geo-replica; Traffic Manager with priority routing |

**Cost**: ~1.5x single region (secondary resources at reduced scale).

---

### Backup & Restore (Cold DR)

**When to Use**: Tier 2/3 where RTO 4-24 hours is acceptable.

| Platform | Implementation |
|----------|---------------|
| **AWS (Primary)** | AWS Backup with cross-region copy to `eu-west-1`; EC2 AMI snapshots; RDS automated snapshots; S3 Cross-Region Replication |
| **Azure (Secondary)** | Azure Backup with geo-redundant vault; VM snapshots; Azure SQL geo-redundant backups |

**Cost**: Minimal — only backup storage costs for secondary region.

---

## Design Requirements by Tier

### Tier 1 — Mandatory Design Elements

- [ ] **Multi-AZ deployment** — Minimum 3 AZs (AWS) or zones (Azure) for all stateful components
- [ ] **Multi-Region DR configuration** — Active-Active or Warm Standby (see above)
- [ ] **Automated failover** — DNS-based failover (Route 53 / Azure Front Door) with health check; target failover ≤ 60 seconds for DNS propagation
- [ ] **Database HA** — Aurora Multi-AZ with Global Database (AWS) or Azure SQL auto-failover group (Azure)
- [ ] **Data replication** — Synchronous replication within region; asynchronous cross-region (document the lag and acceptance by product owner)
- [ ] **Backup** — Daily automated backup with cross-region copy; 30-day minimum retention; 6-year retention for HIPAA audit data
- [ ] **DR test** — Quarterly DR failover test documented and evidenced (use AWS FIS / Azure Chaos Studio); test results reviewed by Architecture
- [ ] **Runbook** — Documented failover and failback procedure in Confluence; practised by PIMS at least annually

### Tier 2 — Mandatory Design Elements

- [ ] **Multi-AZ deployment** — Minimum 2 AZs / zones
- [ ] **Warm Standby or Backup/Restore DR** — Per recovery targets
- [ ] **Database HA** — RDS Multi-AZ (AWS) / Zone-redundant replica (Azure)
- [ ] **Backup** — Daily automated backup; 30-day retention; cross-region backup for PHI data
- [ ] **DR test** — 6-monthly DR test; results reviewed by Architecture
- [ ] **Runbook** — Documented failover procedure; PIMS familiar with it

### Tier 3 — Mandatory Design Elements

- [ ] **Multi-AZ recommended** — At least across 2 AZs / zones where possible
- [ ] **Backup/Restore DR** — Daily snapshot; same-region retention minimum
- [ ] **Backup** — 7-day minimum retention for non-PHI; 30-day for PHI data
- [ ] **DR test** — Annual test; basic restore validation
- [ ] **Runbook** — Basic restart and restore procedure documented

---

## Platform-Specific DR Standards

### AWS BC/DR Standards

| Capability | Tier 1 Standard | Tier 2 Standard | Tier 3 Standard |
|-----------|----------------|----------------|----------------|
| **Primary Region** | `eu-west-2` (London) | `eu-west-2` (London) | `eu-west-2` (London) |
| **Secondary Region** | `eu-west-1` (Ireland) | `eu-west-1` (Ireland) — warm standby or backup | Same region, different AZ |
| **Database** | Aurora Global Database or RDS Multi-AZ + cross-region replica | RDS Multi-AZ | RDS Single-AZ or Multi-AZ |
| **DNS Failover** | Route 53 health-check failover policy (< 60s) | Route 53 failover policy (manual or automated) | Manual DNS update |
| **Compute DR** | Auto Scaling Group + pre-warmed capacity in secondary | Scaled-down ASG in secondary region | Restore from AMI |
| **Backup Tool** | AWS Backup — cross-region vault | AWS Backup — cross-region for PHI | AWS Backup — single region |
| **DR Test Tool** | AWS Fault Injection Service (FIS) — quarterly | Manual failover test — 6-monthly | Restore test — annually |
| **RTO Validation** | Evidence required each quarter | Evidence required each 6 months | Evidence required annually |

### Azure BC/DR Standards

| Capability | Tier 1 Standard | Tier 2 Standard | Tier 3 Standard |
|-----------|----------------|----------------|----------------|
| **Primary Region** | UK South (`uksouth`) | UK South | UK South |
| **Secondary Region** | UK West (`ukwest`) | UK West — warm standby or backup | Same region, different zone |
| **Database** | Azure SQL auto-failover group (zone + region redundant) | Azure SQL zone-redundant replica | Azure SQL Basic / Standard |
| **DNS / Traffic Management** | Azure Front Door with active-active or failover routing | Traffic Manager (failover priority) | Manual DNS update |
| **Compute DR** | Zone-redundant VM Scale Set + pre-warmed secondary region | Deallocated VMs in secondary region | Restore from backup/snapshot |
| **Backup Tool** | Azure Backup — geo-redundant vault | Azure Backup — geo-redundant for PHI | Azure Backup — locally redundant |
| **DR Test Tool** | Azure Chaos Studio — quarterly | Manual failover test — 6-monthly | Restore test — annually |
| **ASR** | Azure Site Recovery for IaaS workloads requiring VM-level orchestration | ASR for critical VMs | Snapshot restore |

---

## HIPAA-Specific BC/DR Requirements

For all systems processing, storing, or transmitting PHI, HIPAA mandates:

- **Emergency Mode Operation Plan** — documented procedure to enable continuation of critical processes during an emergency. Must be part of BCDR runbook.
- **Data Backup Plan** — documented procedure for creating and maintaining retrievable exact copies of PHI.
- **Disaster Recovery Plan** — documented procedure restoring any data loss in the event of an emergency.
- **Testing and Revision Procedures** — regular testing of contingency plans; documentation of revision history.
- **Applications and Data Criticality Analysis** — document which applications are most critical; used to prioritise recovery order.

> All HIPAA BC/DR documentation must be version-controlled and reviewed annually. Retain test evidence for 6 years.

---

## BC/DR Artefacts Required in HLD

For every solution that goes through the Architecture Review process, the HLD must include:

| Section | Content Required |
|---------|----------------|
| **Service Tier** | Declared Tier (1/2/3) with justification and sign-off from product owner |
| **RTO/RPO Targets** | Specific targets (numeric); may be stricter than tier minimums if contractually required |
| **Recovery Strategy** | Hot/Warm/Cold; platform-specific implementation described |
| **DR Architecture Diagram** | C4 Level 2 diagram showing primary and secondary topology |
| **Data Replication** | Mechanism, replication lag (if async), and product owner acceptance of RPO |
| **Failover Procedure** | High-level summary in HLD; full procedure in Confluence runbook |
| **DR Test Schedule** | Planned frequency; who conducts it; who reviews results |
| **Cost Impact** | Incremental cost of DR standby capacity; documented in BoM |

---

## DR Test Procedure Template

Use this structure in Confluence for DR test runbooks:

```
## DR Test — [System Name] — [Date]
**Test Type**: [Failover / Restore / Chaos Injection]
**Tier**: [1 / 2 / 3]
**Test Scope**: [Describe what is being tested]
**Pre-Test State**: [Describe the system state before testing]
**Test Steps**:
  1. [Step]
  2. [Step]
**Expected RTO**: ≤ [X] hours
**Expected RPO**: ≤ [X] minutes
**Actual RTO**: [Measured] — PASS / FAIL
**Actual RPO**: [Measured] — PASS / FAIL
**Issues Found**: [List any issues]
**Remediation Actions**: [JIRA/ADO ticket references]
**Reviewed By**: [Architect name, PIMS lead]
```
