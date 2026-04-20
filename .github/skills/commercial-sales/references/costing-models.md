# Costing Models

## Overview

Infrastructure architects must present costs in a way that supports informed business decisions. This reference covers the primary costing models used at EMIS/Optum.

## Total Cost of Ownership (TCO)

### What It Includes

TCO captures ALL costs over a defined period (typically 3-5 years):

| Cost Category | Components |
|--------------|------------|
| **Infrastructure** | Compute, storage, networking, database, security services |
| **Licensing** | OS, database, middleware, application licences |
| **Operations** | FTE cost for operations (PIMS, CloudOps), monitoring tooling |
| **Migration** | One-off cost to migrate or deploy the solution |
| **Professional Services** | Architecture, consulting, training |
| **Data Transfer** | Network egress, inter-region transfer, ExpressRoute/Direct Connect |
| **Support** | Vendor support contracts (Microsoft Premier, AWS Enterprise Support) |
| **Facilities** | Data centre costs (for on-prem: power, cooling, rack space, physical security) |
| **Depreciation** | Hardware depreciation (for on-prem CapEx components) |

### TCO Comparison Template

```markdown
## TCO Comparison — [Solution Name]

### Scope
- Period: 3 years / 5 years
- Currency: GBP
- Environments: Production, Dev/Test, DR

### Year-by-Year Comparison

| Cost Category | Current (On-Prem) | | | Proposed (Azure) | | |
|---|---|---|---|---|---|---|
| | Year 1 | Year 2 | Year 3 | Year 1 | Year 2 | Year 3 |
| Infrastructure | £XXX | £XXX | £XXX | £XXX | £XXX | £XXX |
| Licensing | £XXX | £XXX | £XXX | £XXX | £XXX | £XXX |
| Operations (FTE) | £XXX | £XXX | £XXX | £XXX | £XXX | £XXX |
| Migration | — | — | — | £XXX | — | — |
| Support | £XXX | £XXX | £XXX | £XXX | £XXX | £XXX |
| Facilities | £XXX | £XXX | £XXX | — | — | — |
| **Annual Total** | **£XXX** | **£XXX** | **£XXX** | **£XXX** | **£XXX** | **£XXX** |
| **Cumulative Total** | | | **£XXX** | | | **£XXX** |
| **3-Year TCO Delta** | | | | | | **£±XXX (XX%)** |
```

## Return on Investment (ROI)

### ROI Calculation

$$ROI = \frac{Net\ Benefits - Total\ Investment}{Total\ Investment} \times 100\%$$

Where:
- **Net Benefits** = Cost savings + Revenue enabled + Risk reduction value + Productivity gains
- **Total Investment** = Migration cost + Solution cost + Operational cost delta

### ROI Analysis Template

```markdown
## ROI Analysis — [Solution Name]

### Investment

| Item | Cost |
|------|------|
| Migration / Implementation | £XXX |
| Year 1 solution cost (delta vs. current) | £XXX |
| Training & change management | £XXX |
| **Total Investment** | **£XXX** |

### Benefits (Annual)

| Benefit | Type | Annual Value | Confidence |
|---------|------|-------------|------------|
| Infrastructure cost reduction | Hard saving | £XXX | High |
| Operational FTE reduction | Hard saving | £XXX | Medium |
| Reduced downtime (availability improvement) | Soft saving | £XXX | Medium |
| Faster time-to-market | Strategic value | £XXX | Low |
| Reduced security risk | Risk reduction | £XXX | Low |
| **Total Annual Benefits** | | **£XXX** | |

### ROI Summary

| Metric | Value |
|--------|-------|
| Total Investment | £XXX |
| Annual Net Benefits | £XXX |
| ROI (Year 1) | XX% |
| Payback Period | X months |
| 3-Year Net Benefit | £XXX |
| 5-Year Net Benefit | £XXX |
```

## OpEx vs. CapEx Analysis

### Definitions

| Model | Description | Cloud Equivalent |
|-------|-------------|-----------------|
| **CapEx** (Capital Expenditure) | Upfront purchase of assets; depreciated over useful life (3-5 years) | Reserved Instances (pre-paid), ExpressRoute circuits |
| **OpEx** (Operational Expenditure) | Ongoing operational costs; expensed monthly | Pay-as-you-go, monthly subscriptions |

### Decision Factors

| Factor | Favours CapEx | Favours OpEx |
|--------|--------------|--------------|
| Workload stability | Predictable, stable 24/7 | Variable, seasonal, unpredictable |
| Budget availability | Large upfront budget available | Prefer spreading cost monthly |
| Financial reporting | Want to capitalise and depreciate | Prefer operational expense |
| Flexibility | Low change expected | May scale up/down or decommission |
| Cash flow | Healthy cash reserves | Preserve cash; pay as consumed |
| Tax implications | CapEx depreciation beneficial | OpEx immediately deductible |

### Hybrid Approach (Recommended)

EMIS/Optum typically uses a hybrid approach:
- **CapEx**: Reserved Instances (1yr or 3yr) for stable production workloads
- **OpEx**: Pay-as-you-go for variable workloads, dev/test, and new services
- **Assessment**: Review RI coverage quarterly; convert PAYG to RI when utilisation pattern is confirmed stable

## Pricing Negotiation Guidance

> **Note**: All commercial negotiations must involve the Commercial/Procurement team. Architecture provides technical validation only.

| Lever | Approach |
|-------|----------|
| **Volume discounts** | Larger commitments = better rates; negotiate across the EMIS/Optum portfolio, not per project |
| **Reserved capacity** | 1yr = ~30% savings; 3yr = ~50-60% savings; weigh against flexibility loss |
| **Enterprise Agreement (EA)** | Microsoft EA pricing (if applicable); annual true-up |
| **Hybrid Benefit** | Use existing Windows Server / SQL Server licences with SA on Azure (40-55% savings) |
| **Dev/Test pricing** | Azure Dev/Test subscription pricing (no Windows licence cost, reduced rates) |
| **Savings Plans** | AWS Savings Plans / Azure Savings Plan for Compute (flexible commitment) |
| **Spot/Preemptible** | 60-90% savings for interruptible workloads (CI/CD, batch, testing) |
