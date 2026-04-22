# Bill of Materials (BoM) Templates

## Overview

A Bill of Materials itemises every infrastructure component required for a solution, with quantities, specifications, and costs. BoMs are required for all commercial proposals and architecture designs.

## Standard BoM Template

```markdown
# Bill of Materials — [Solution Name]

## Document Control

| Item | Detail |
|------|--------|
| Document ID | BoM-[XXXX] |
| Version | 1.0 |
| Author | [Architect name] |
| Date | YYYY-MM-DD |
| Status | Draft / Review / Approved |
| Classification | Internal / Confidential |

## Solution Summary

[2-3 sentence description of the solution this BoM supports]

## Assumptions

- [List key assumptions affecting the BoM]
- Pricing based on [Azure Pricing Calculator / AWS Calculator / vendor quote] as of YYYY-MM-DD
- [Currency: GBP]
- [Pricing model: Pay-as-you-go / Reserved 1yr / Reserved 3yr]

## Compute

| # | Resource | SKU / Spec | Qty | Environment | Monthly Unit Cost | Monthly Total | Annual Total |
|---|----------|-----------|-----|-------------|-------------------|---------------|-------------|
| 1 | Azure VM | Standard_D4s_v5 (4 vCPU, 16 GB) | 2 | Production | £XXX | £XXX | £XXX |
| 2 | Azure VM | Standard_D2s_v5 (2 vCPU, 8 GB) | 2 | Dev/Test | £XXX | £XXX | £XXX |
| | **Compute Subtotal** | | | | | **£XXX** | **£XXX** |

## Storage

| # | Resource | Type / Size | Qty | Environment | Monthly Unit Cost | Monthly Total | Annual Total |
|---|----------|------------|-----|-------------|-------------------|---------------|-------------|
| 3 | Managed Disk | Premium SSD P30 (1 TB) | 2 | Production | £XXX | £XXX | £XXX |
| 4 | Blob Storage | Hot tier, LRS (500 GB) | 1 | Production | £XXX | £XXX | £XXX |
| | **Storage Subtotal** | | | | | **£XXX** | **£XXX** |

## Networking

| # | Resource | SKU / Spec | Qty | Environment | Monthly Unit Cost | Monthly Total | Annual Total |
|---|----------|-----------|-----|-------------|-------------------|---------------|-------------|
| 5 | Load Balancer | Standard | 1 | Production | £XXX | £XXX | £XXX |
| 6 | Application Gateway | WAF v2 | 1 | Production | £XXX | £XXX | £XXX |
| 7 | Azure Firewall (shared) | Standard (proportional) | 0.25 | Shared | £XXX | £XXX | £XXX |
| | **Networking Subtotal** | | | | | **£XXX** | **£XXX** |

## Database

| # | Resource | SKU / Spec | Qty | Environment | Monthly Unit Cost | Monthly Total | Annual Total |
|---|----------|-----------|-----|-------------|-------------------|---------------|-------------|
| 8 | Azure SQL | Business Critical Gen5 4vCore | 1 | Production | £XXX | £XXX | £XXX |
| 9 | Azure SQL | General Purpose Gen5 2vCore | 1 | Dev/Test | £XXX | £XXX | £XXX |
| | **Database Subtotal** | | | | | **£XXX** | **£XXX** |

## Security & Monitoring

| # | Resource | SKU / Spec | Qty | Environment | Monthly Unit Cost | Monthly Total | Annual Total |
|---|----------|-----------|-----|-------------|-------------------|---------------|-------------|
| 10 | Azure Key Vault | Standard | 1 | Shared | £XXX | £XXX | £XXX |
| 11 | Dynatrace Host Units | Per host | 4 | All | £XXX | £XXX | £XXX |
| 12 | Azure Backup | 500 GB protected | 1 | Production | £XXX | £XXX | £XXX |
| | **Security/Monitoring Subtotal** | | | | | **£XXX** | **£XXX** |

## Licensing

| # | License | Type | Qty | Annual Cost |
|---|---------|------|-----|------------|
| 13 | Windows Server | AHUB (existing SA) / PAYG | 4 | £XXX |
| 14 | SQL Server | AHUB (existing SA) / PAYG | 2 | £XXX |
| | **Licensing Subtotal** | | | **£XXX** |

## One-Off Costs

| # | Item | Description | Cost |
|---|------|-------------|------|
| 15 | Migration | Azure Migrate + engineering effort (X days) | £XXX |
| 16 | Documentation | HLD, LLD, runbooks production | £XXX |
| 17 | Testing | Performance and UAT testing | £XXX |
| | **One-Off Subtotal** | | **£XXX** |

## Cost Summary

| Category | Monthly | Annual |
|----------|---------|--------|
| Compute | £XXX | £XXX |
| Storage | £XXX | £XXX |
| Networking | £XXX | £XXX |
| Database | £XXX | £XXX |
| Security & Monitoring | £XXX | £XXX |
| Licensing | — | £XXX |
| **Recurring Total** | **£XXX** | **£XXX** |
| One-Off Costs | — | £XXX |
| **Grand Total (Year 1)** | — | **£XXX** |
| **Grand Total (Year 2+)** | — | **£XXX** |

## Notes

- Prices are estimates and subject to change
- Reserved Instance pricing can reduce recurring costs by 30-60%
- Azure Hybrid Benefit can reduce Windows/SQL licensing costs if SA is available
- Data egress charges estimated at [X] GB/month
```

## BoM Best Practices

1. **Itemise everything** — Don't lump costs; list each resource individually
2. **Include all environments** — Production, Dev, Test, DR — even if shared or scaled down
3. **Show pricing options** — PAYG, Reserved 1yr, Reserved 3yr side-by-side where applicable
4. **Call out assumptions** — Region, currency, utilisation assumptions, data volumes
5. **Include soft costs** — Migration effort, documentation, testing, training
6. **Version control** — BoMs change; track versions with dates
7. **Reference the design** — Link to the HLD that this BoM supports
8. **Tag compliance** — All costed resources must be tagged: `CostCentre`, `Environment`, `Owner`, `Application`, `Project`
9. **Flag governance thresholds** — If ARR > £50,000 or one-off > £25,000, note budget holder approval is required

---

## AWS BoM Template

Use this template for AWS-hosted solutions (primary cloud platform).

```markdown
# Bill of Materials — [Solution Name] — AWS

## Document Control

| Item | Detail |
|------|--------|
| Document ID | BoM-[XXXX] |
| Version | 1.0 |
| Author | [Architect name] |
| Date | YYYY-MM-DD |
| Status | Draft / Review / Approved |
| Classification | Internal / Confidential |

## Solution Summary

[2-3 sentence description of the AWS solution this BoM supports]

## Assumptions

- Primary Region: eu-west-2 (London); Secondary (DR): eu-west-1 (Ireland) where applicable
- Pricing based on [AWS Pricing Calculator] as of YYYY-MM-DD
- Currency: GBP (USD pricing converted at rate: [X.XX])
- Pricing model: On-Demand (baseline) / Savings Plan / Reserved 1yr / Reserved 3yr
- Architecture: [arm64 Graviton / x86] — Graviton preferred for new workloads

## Compute

| # | Resource | Instance Type | vCPU | RAM | Qty | Environment | Monthly Unit (OD) | Monthly Unit (SP/RI) | Monthly Total (SP/RI) | Annual Total (SP/RI) |
|---|----------|--------------|------|-----|-----|-------------|-------------------|----------------------|-----------------------|---------------------|
| 1 | EC2 (App) | m7g.xlarge (Graviton) | 4 | 16 GB | 3 | Production | £XXX | £XXX | £XXX | £XXX |
| 2 | EC2 (App) | t4g.small (Graviton) | 2 | 2 GB | 2 | Dev/Test | £XXX | — (Spot) | £XXX | £XXX |
| 3 | EKS Node (Graviton) | m7g.2xlarge | 8 | 32 GB | 4 | Production | £XXX | £XXX | £XXX | £XXX |
| | **Compute Subtotal** | | | | | | | | **£XXX** | **£XXX** |

## Storage

| # | Resource | Type / Size | Qty | Environment | Monthly Unit Cost | Monthly Total | Annual Total |
|---|----------|-----------|-----|-------------|------------------|---------------|-------------|
| 4 | EBS Volume | gp3, 500 GB | 6 | Production | £XXX | £XXX | £XXX |
| 5 | S3 Bucket | Standard, 1 TB | 1 | Production | £XXX | £XXX | £XXX |
| 6 | S3 Bucket | IA, archival 500 GB | 1 | Compliance | £XXX | £XXX | £XXX |
| | **Storage Subtotal** | | | | | **£XXX** | **£XXX** |

## Networking

| # | Resource | SKU / Spec | Qty | Environment | Monthly Unit Cost | Monthly Total | Annual Total |
|---|----------|-----------|-----|-------------|------------------|---------------|-------------|
| 7 | Application Load Balancer | Standard | 2 | Production | £XXX | £XXX | £XXX |
| 8 | NAT Gateway | — | 3 | Production | £XXX | £XXX | £XXX |
| 9 | Data Transfer (egress) | [X] GB/month | 1 | Production | £XXX | £XXX | £XXX |
| 10 | Direct Connect (shared) | 1 Gbps hosted conn. | 0.25 | Shared | £XXX | £XXX | £XXX |
| | **Networking Subtotal** | | | | | **£XXX** | **£XXX** |

## Database

| # | Resource | Engine / SKU | Qty | Multi-AZ | Environment | Monthly Unit Cost | Monthly Total | Annual Total |
|---|----------|------------|-----|----------|-------------|------------------|---------------|-------------|
| 11 | RDS | PostgreSQL db.r7g.xlarge | 1 | Yes | Production | £XXX | £XXX | £XXX |
| 12 | RDS | PostgreSQL db.t4g.medium | 1 | No | Dev/Test | £XXX | £XXX | £XXX |
| 13 | ElastiCache | Redis cache.r7g.large | 2 | Yes | Production | £XXX | £XXX | £XXX |
| | **Database Subtotal** | | | | | | **£XXX** | **£XXX** |

## Security & Monitoring

| # | Resource | SKU / Spec | Qty | Environment | Monthly Unit Cost | Monthly Total | Annual Total |
|---|----------|-----------|-----|-------------|------------------|---------------|-------------|
| 14 | AWS Secrets Manager | Per secret | 10 | All | £XXX | £XXX | £XXX |
| 15 | AWS KMS CMK | Per key | 4 | All | £XXX | £XXX | £XXX |
| 16 | GuardDuty | Per account | 1 | All | £XXX | £XXX | £XXX |
| 17 | AWS Backup | 500 GB protected | 1 | Production | £XXX | £XXX | £XXX |
| 18 | Dynatrace Host Units | Per host | 8 | All | £XXX | £XXX | £XXX |
| | **Security/Monitoring Subtotal** | | | | | **£XXX** | **£XXX** |

## Licensing

| # | License | Type | Qty | Annual Cost |
|---|---------|------|-----|------------|
| 19 | Windows Server | BYOL / included in EC2 price | 2 | £XXX |
| 20 | SQL Server | BYOL | 1 | £XXX |
| | **Licensing Subtotal** | | | **£XXX** |

## One-Off Costs

| # | Item | Description | Cost |
|---|------|-------------|------|
| 21 | Migration | AWS Migration Hub + engineering (X days) | £XXX |
| 22 | Documentation | HLD, LLD, runbooks | £XXX |
| 23 | Landing Zone Setup | Account vending, IAM, networking | £XXX |
| | **One-Off Subtotal** | | **£XXX** |

## Cost Summary

| Category | Monthly (OD) | Monthly (SP/RI) | Annual (SP/RI) |
|----------|-------------|----------------|---------------|
| Compute | £XXX | £XXX | £XXX |
| Storage | £XXX | £XXX | £XXX |
| Networking | £XXX | £XXX | £XXX |
| Database | £XXX | £XXX | £XXX |
| Security & Monitoring | £XXX | £XXX | £XXX |
| Licensing | — | — | £XXX |
| **Recurring Total** | **£XXX** | **£XXX** | **£XXX** |
| One-Off Costs | — | — | £XXX |
| **Grand Total (Year 1)** | — | — | **£XXX** |
| **Grand Total (Year 2+)** | — | — | **£XXX** |

## Savings Plan / Reserved Instance Summary

| Commitment Type | Annual Commitment | Estimated Annual Saving | Saving % |
|----------------|-----------------|------------------------|---------|
| EC2 Savings Plan (1yr) | £XXX | £XXX | ~30% |
| EC2 Savings Plan (3yr) | £XXX | £XXX | ~50% |
| RDS Reserved (1yr) | £XXX | £XXX | ~30% |
| RDS Reserved (3yr) | £XXX | £XXX | ~50% |

## Notes

- Graviton (arm64) instances used throughout — ~20% cost and performance benefit vs. x86 equivalents
- Spot instances used for Dev/Test EC2 — include interruption handling in design
- Savings Plans / Reserved Instances recommended once workload is stable (minimum 30 days of utilisation data)
- Data egress estimated at [X] GB/month; validate against actual workload data flows
- KMS CMK in use for Confidential/Restricted data as per HIPAA and EMIS/Optum security baseline
```

---

## On-Premises / VMware BoM Template

Use this template for on-premises or VMware-hosted solutions (hybrid or retain scenarios).

```markdown
# Bill of Materials — [Solution Name] — On-Premises / VMware

## Document Control

| Item | Detail |
|------|--------|
| Document ID | BoM-[XXXX] |
| Version | 1.0 |
| Author | [Architect name] |
| Date | YYYY-MM-DD |
| Status | Draft / Review / Approved |
| Classification | Internal / Confidential |

## Solution Summary

[2-3 sentence description of the on-prem/VMware solution]

## Assumptions

- Site: [Leeds DC / Wales / Gibraltar / Doncaster / Jersey / other]
- Hardware pricing based on vendor quote from [vendor] dated YYYY-MM-DD
- VMware licensing: [Renew / Alternative — per VMware renewal decision October 2026]
- CapEx hardware depreciated over [5] years; OpEx shown for recurring costs

## Compute (Physical)

| # | Component | Spec | Qty | Unit Cost (CapEx) | Total (CapEx) | Annual Support / Licence |
|---|-----------|------|-----|-------------------|---------------|------------------------|
| 1 | Server (Blade/Rack) | 2x Intel/AMD, 256 GB RAM, 2x 10GbE | 2 | £XXX | £XXX | £XXX |
| 2 | Additional RAM | 64 GB DIMMs | 4 | £XXX | £XXX | — |
| | **Hardware Subtotal** | | | | **£XXX** | **£XXX** |

## Compute (Virtual — VMware)

| # | VM Type | vCPU | RAM | Count | Environment | VMware Licence Cost |
|---|---------|------|-----|-------|-------------|-------------------|
| 3 | App Server | 4 | 16 GB | 3 | Production | Included / £XXX |
| 4 | App Server | 2 | 8 GB | 2 | Dev/Test | Included / £XXX |
| | **VM Subtotal** | | | | | **£XXX** |

## Storage

| # | Component | Type / Capacity | Qty | Unit Cost (CapEx) | Total (CapEx) | Annual Support |
|---|-----------|---------------|-----|-------------------|---------------|---------------|
| 5 | vSAN Capacity Disk | NVMe 3.84 TB | 6 | £XXX | £XXX | £XXX |
| 6 | vSAN Cache Tier (for non All-Flash) | NVMe 1.92 TB | 3 | £XXX | £XXX | £XXX |
| 7 | Backup Target (Veeam) | Veeam Backup + storage | 1 | £XXX | £XXX | £XXX |
| | **Storage Subtotal** | | | | **£XXX** | **£XXX** |

## Networking

| # | Component | Spec | Qty | Unit Cost | Total (CapEx) | Annual Support |
|---|-----------|------|-----|-----------|---------------|---------------|
| 8 | Top-of-Rack Switch | 25GbE / 100GbE uplink | 2 | £XXX | £XXX | £XXX |
| 9 | Firewall | Palo Alto / Azure Firewall NVA | 1 | £XXX | £XXX | £XXX |
| | **Networking Subtotal** | | | | **£XXX** | **£XXX** |

## Platform Licensing

| # | License | Scope | Qty | Annual Cost |
|---|---------|-------|-----|------------|
| 10 | VMware vSphere / vSAN | Per core (Broadcom) | [X] cores | £XXX |
| 11 | Windows Server Datacenter | Per host | 2 | £XXX |
| 12 | SQL Server | Per core | [X] cores | £XXX |
| 13 | RHEL | Per socket | 4 | £XXX |
| | **Licensing Subtotal** | | | **£XXX** |

## Operational Costs

| # | Item | Description | Annual Cost |
|---|------|-------------|------------|
| 14 | Data Centre Hosting | Rack, power, cooling at [Site] — cost per rack unit/month | £XXX |
| 15 | PIMS Operations | Operational FTE contribution (proportion of PIMS headcount) | £XXX |
| 16 | Dynatrace | Host Units for on-prem monitoring | £XXX |
| 17 | Backup | Veeam licences + tape/offsite | £XXX |
| | **Operational Subtotal** | | **£XXX** |

## One-Off Costs

| # | Item | Description | Cost |
|---|------|-------------|------|
| 18 | Hardware installation | Racking, cabling, configuration | £XXX |
| 19 | Migration / deployment | Engineering effort (X days) | £XXX |
| 20 | Documentation | HLD, LLD, runbooks | £XXX |
| | **One-Off Subtotal** | | **£XXX** |

## 5-Year Cost Summary

| Category | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 | 5-Year Total |
|----------|--------|--------|--------|--------|--------|-------------|
| Hardware (CapEx / depreciation) | £XXX | £XXX | £XXX | £XXX | £XXX | £XXX |
| Licensing | £XXX | £XXX | £XXX | £XXX | £XXX | £XXX |
| Operational | £XXX | £XXX | £XXX | £XXX | £XXX | £XXX |
| One-Off | £XXX | — | — | — | — | £XXX |
| **Total** | **£XXX** | **£XXX** | **£XXX** | **£XXX** | **£XXX** | **£XXX** |

## Notes

- VMware licensing costs subject to change pending October 2026 Broadcom renewal decision
- Hardware for DR site (if applicable) not included — covered in separate DR BoM
- On-premises costs should be compared against cloud equivalent using the TCO template in [Costing Models](./costing-models.md)
```
