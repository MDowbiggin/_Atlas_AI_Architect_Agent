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
