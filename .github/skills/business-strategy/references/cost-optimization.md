# Cost Optimisation & FinOps

## Overview

FinOps is the practice of bringing financial accountability to cloud and infrastructure spending. At EMIS/Optum, every infrastructure architect is responsible for cost-conscious design and ongoing optimisation.

## FinOps Framework

### Inform Phase — Visibility & Allocation

| Practice | Implementation |
|----------|---------------|
| **Tagging Policy** | Mandatory tags on ALL resources: `CostCentre`, `Environment`, `Owner`, `Application`, `Project` |
| **Cost Dashboards** | Azure Cost Management dashboards per subscription/resource group; AWS Cost Explorer |
| **Showback/Chargeback** | Monthly cost reports per cost centre and application owner |
| **Anomaly Detection** | Azure Cost Management anomaly alerts; review weekly |
| **Forecasting** | Monthly forecast vs. budget comparison; flag variance > 10% |

### Optimise Phase — Rate & Usage Optimisation

| Technique | Savings Potential | When to Apply |
|-----------|------------------|---------------|
| **Right-Sizing** | 20-40% | VMs with < 40% average CPU; databases with over-provisioned DTUs/vCores |
| **Reserved Instances (RI)** | 30-60% | Stable workloads running 24/7 for ≥ 12 months |
| **Savings Plans** | 20-40% | Committed compute spend across instance families |
| **Spot/Preemptible Instances** | 60-90% | Batch processing, CI/CD agents, dev/test |
| **Auto-Scaling** | 20-50% | Variable workloads; scale-to-zero non-production out-of-hours |
| **Storage Tiering** | 40-70% | Move infrequently accessed data to Cool/Archive/S3 IA |
| **Orphan Resource Cleanup** | 5-15% | Unattached disks, unused public IPs, empty resource groups |
| **Dev/Test Licensing** | 40-55% | Non-production environments using Azure Dev/Test pricing |
| **License Optimisation** | Variable | Azure Hybrid Benefit (AHUB) for Windows Server and SQL Server |

### Operate Phase — Governance & Culture

| Practice | Implementation |
|----------|---------------|
| **Budget Controls** | Azure Cost Management budgets with alerts at 75%, 90%, 100% |
| **Policy Enforcement** | Azure Policy to restrict expensive SKUs in dev/test; deny non-approved regions |
| **Cost Review Cadence** | Monthly cost review per application/project; quarterly portfolio review |
| **Accountability** | Application owner responsible for their cost centre; architect provides recommendations |
| **Training** | FinOps awareness for architects and engineers |

## Cost Estimation Framework

When producing cost estimates for designs:

### Azure Pricing Calculator Approach

1. List all Azure resources in the design
2. Use the [Azure Pricing Calculator](https://azure.microsoft.com/en-gb/pricing/calculator/) for base pricing
3. Apply discounts: Reserved Instances, Hybrid Benefit, Dev/Test pricing
4. Add operational costs: monitoring, backup, network egress, licenses
5. Calculate monthly and annual costs
6. Produce TCO comparison if replacing existing infrastructure

### Cost Estimate Template

```markdown
## Cost Estimate — [Solution Name]

### Assumptions
- Region: UK South
- Environment: Production / Dev / Test
- Pricing: Pay-as-you-go (baseline) / Reserved 1-year / Reserved 3-year
- Data transfer: [X] GB/month egress estimated

### Monthly Cost Breakdown

| Resource | SKU/Size | Qty | Monthly Cost (PAYG) | Monthly Cost (RI 1yr) | Monthly Cost (RI 3yr) |
|----------|----------|-----|--------------------|-----------------------|-----------------------|
| Virtual Machines | Standard_D4s_v5 | 2 | £XXX | £XXX | £XXX |
| Azure SQL | Business Critical Gen5 4vCore | 1 | £XXX | £XXX | £XXX |
| Storage | Premium SSD P30 | 4 | £XXX | — | — |
| Load Balancer | Standard | 1 | £XXX | — | — |
| Azure Firewall | Standard | 0.25 (shared) | £XXX | — | — |
| Backup | Azure Backup | 500 GB | £XXX | — | — |
| Monitoring | Dynatrace Host Units | 2 | £XXX | — | — |
| **Total** | | | **£XXX** | **£XXX** | **£XXX** |

### Annual Cost Summary

| Pricing Model | Annual Cost | Savings vs. PAYG |
|--------------|-------------|-----------------|
| Pay-as-you-go | £XXX | — |
| Reserved 1-year | £XXX | XX% |
| Reserved 3-year | £XXX | XX% |

### TCO Comparison (if applicable)

| Item | Current (On-Prem) | Proposed (Azure) | Delta |
|------|-------------------|------------------|-------|
| Compute | £XXX | £XXX | £±XXX |
| Storage | £XXX | £XXX | £±XXX |
| Networking | £XXX | £XXX | £±XXX |
| Licensing | £XXX | £XXX | £±XXX |
| Operations (FTE) | £XXX | £XXX | £±XXX |
| **Total** | **£XXX** | **£XXX** | **£±XXX** |
```

## Optimisation Review Checklist

When reviewing an existing environment for cost savings:

- [ ] Identify VMs with < 40% average CPU utilisation (right-size candidates)
- [ ] Identify databases with < 30% DTU/vCore utilisation
- [ ] Check for unattached managed disks and unused public IPs
- [ ] Review Reserved Instance coverage and utilisation
- [ ] Check for Azure Hybrid Benefit eligibility (Windows Server, SQL Server)
- [ ] Verify non-production environments are scaled down or stopped out-of-hours
- [ ] Review storage accounts for tiering opportunities (Hot → Cool → Archive)
- [ ] Check for duplicate or redundant resources across subscriptions
- [ ] Verify all resources have mandatory cost allocation tags
- [ ] Review Azure Advisor cost recommendations
