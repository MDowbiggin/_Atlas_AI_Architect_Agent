# Cost Estimate Template

## Overview

Use this template when producing cost estimates for infrastructure solutions. This is distinct from the BoM (which itemises components) — the cost estimate provides the financial analysis context.

## Template

```markdown
# Cost Estimate — [Solution Name]

## Document Control

| Item | Detail |
|------|--------|
| Document ID | CE-[XXXX] |
| Version | 1.0 |
| Author | [Architect name] |
| Date | YYYY-MM-DD |
| Classification | Confidential |
| Related HLD | HLD-[XXXX] |
| Pricing Source | Azure Pricing Calculator / AWS Calculator / Vendor Quote |
| Pricing Date | YYYY-MM-DD |
| Currency | GBP (£) |

---

## 1. Scope & Assumptions

### Scope

| In Scope | Out of Scope |
|----------|-------------|
| [Production infrastructure] | [Application development effort] |
| [Dev/Test environments] | [End-user devices] |
| [DR infrastructure] | [Third-party SaaS licensing] |
| [Migration costs] | [Training costs] |

### Assumptions

| # | Assumption | Impact if Different |
|---|-----------|---------------------|
| 1 | Workload runs 24/7 in production | If variable, auto-scaling could reduce cost by 20-30% |
| 2 | Azure UK South region pricing | Other regions may vary ±5% |
| 3 | Pay-as-you-go baseline (RI options shown separately) | RI commitment reduces recurring costs |
| 4 | Data egress of [X] GB/month | Egress pricing is variable and can be significant |
| 5 | [Application-specific assumptions] | [Impact] |

## 2. Recurring Costs (Monthly / Annual)

### Production Environment

| Category | Resource | Specification | Qty | Monthly | Annual |
|----------|----------|--------------|-----|---------|--------|
| Compute | Azure VM | Standard_D4s_v5 | 2 | £XXX | £XXX |
| Compute | Azure VM | Standard_D2s_v5 | 1 | £XXX | £XXX |
| Storage | Managed Disk | Premium SSD P30 | 3 | £XXX | £XXX |
| Storage | Blob Storage | Hot, ZRS, 500 GB | 1 | £XXX | £XXX |
| Database | Azure SQL | BC Gen5 4vCore | 1 | £XXX | £XXX |
| Networking | App Gateway | WAF v2 | 1 | £XXX | £XXX |
| Networking | Azure Firewall | Standard (shared 25%) | 0.25 | £XXX | £XXX |
| Networking | Data Egress | [X] GB/month | — | £XXX | £XXX |
| Security | Key Vault | Standard | 1 | £XXX | £XXX |
| Monitoring | Dynatrace | Host Units | 3 | £XXX | £XXX |
| Monitoring | Log Analytics | [X] GB/day ingestion | — | £XXX | £XXX |
| Backup | Azure Backup | [X] GB protected | — | £XXX | £XXX |
| **Production Subtotal** | | | | **£XXX** | **£XXX** |

### Dev/Test Environment

| Category | Resource | Specification | Qty | Monthly | Annual |
|----------|----------|--------------|-----|---------|--------|
| Compute | Azure VM | Standard_B2s (Dev/Test pricing) | 2 | £XXX | £XXX |
| Database | Azure SQL | GP Gen5 2vCore (Dev/Test) | 1 | £XXX | £XXX |
| Storage | Managed Disk | Standard SSD E20 | 2 | £XXX | £XXX |
| **Dev/Test Subtotal** | | | | **£XXX** | **£XXX** |

### DR Environment

| Category | Resource | Specification | Qty | Monthly | Annual |
|----------|----------|--------------|-----|---------|--------|
| Compute | Azure VM (stopped) | Standard_D4s_v5 (deallocated) | 2 | £XXX | £XXX |
| Database | Azure SQL | Geo-replica (BC Gen5 4vCore) | 1 | £XXX | £XXX |
| Storage | Blob Storage | GRS replication | — | £XXX | £XXX |
| **DR Subtotal** | | | | **£XXX** | **£XXX** |

### Licensing

| License | Type | Qty | Annual |
|---------|------|-----|--------|
| Windows Server | AHUB (existing SA) | 5 | £0 (covered by SA) |
| SQL Server | AHUB (existing SA) | 2 | £0 (covered by SA) |
| [Other license] | [Type] | [Qty] | £XXX |
| **Licensing Subtotal** | | | **£XXX** |

### Recurring Cost Summary

| Category | Monthly | Annual |
|----------|---------|--------|
| Production | £XXX | £XXX |
| Dev/Test | £XXX | £XXX |
| DR | £XXX | £XXX |
| Licensing | — | £XXX |
| **Total Recurring** | **£XXX** | **£XXX** |

## 3. One-Off Costs

| Item | Description | Days/Units | Rate | Total |
|------|-------------|-----------|------|-------|
| Architecture Design | HLD + LLD production | X days | £XXX/day | £XXX |
| Build / Implementation | IaC development, deployment, testing | X days | £XXX/day | £XXX |
| Migration | Data migration and cutover | X days | £XXX/day | £XXX |
| Testing | Performance, security, UAT | X days | £XXX/day | £XXX |
| Documentation | Runbooks, handover docs | X days | £XXX/day | £XXX |
| Training | PIMS knowledge transfer | X days | £XXX/day | £XXX |
| **One-Off Total** | | | | **£XXX** |

## 4. Cost Optimisation Options

| Optimisation | Potential Saving | Trade-Off |
|-------------|-----------------|-----------|
| Reserved Instances (1yr) | ~30% on compute | 1-year commitment; less flexibility |
| Reserved Instances (3yr) | ~50-60% on compute | 3-year commitment; locked to SKU family |
| Azure Hybrid Benefit | 40-55% on Windows/SQL | Requires active Software Assurance |
| Dev/Test shutdown (out-of-hours) | ~65% on dev/test compute | Services unavailable outside business hours |
| Right-sizing (post 30-day review) | 10-30% | Requires monitoring data; may need resize |

### Cost with Optimisation Applied

| Scenario | Annual Recurring | vs. PAYG Baseline |
|----------|-----------------|-------------------|
| PAYG (baseline) | £XXX | — |
| RI 1yr + AHUB + Dev/Test shutdown | £XXX | -XX% (£XXX saved) |
| RI 3yr + AHUB + Dev/Test shutdown | £XXX | -XX% (£XXX saved) |

## 5. Total Cost Summary

| Item | Year 1 | Year 2 | Year 3 | 3-Year Total |
|------|--------|--------|--------|-------------|
| One-Off Costs | £XXX | — | — | £XXX |
| Recurring (PAYG) | £XXX | £XXX | £XXX | £XXX |
| Recurring (RI recommended) | £XXX | £XXX | £XXX | £XXX |
| **Total (PAYG)** | **£XXX** | **£XXX** | **£XXX** | **£XXX** |
| **Total (RI recommended)** | **£XXX** | **£XXX** | **£XXX** | **£XXX** |

## 6. Approval

| Approver | Role | Threshold | Status |
|----------|------|-----------|--------|
| [Name] | Budget Holder | £0 - £25,000 one-off | Pending |
| [Name] | Head of [Function] | £25,001 - £100,000 | Pending |
| ARB | Architecture Review Board | > £100,000 annual | Pending |
```
