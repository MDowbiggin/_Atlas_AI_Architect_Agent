---
name: commercial-sales
description: "Commercial and sales support for infrastructure solutions. Use when: assessing solution viability, generating Bills of Material (BoM), preparing cost estimates, responding to RFPs, supporting commercial bids, calculating TCO/ROI, build vs. buy analysis, vendor assessments, NHS procurement frameworks, or evaluating commercial feasibility of a proposed solution."
---

# Commercial & Sales Support

## When to Use

- Assessing whether a proposed solution is commercially viable
- Generating a Bill of Materials (BoM) for a solution design (Azure, AWS, or on-premises)
- Preparing cost estimates for a bid, proposal, or demand review
- Responding to RFPs (Request for Proposal) or commercial bid requests
- Calculating Total Cost of Ownership (TCO) or Return on Investment (ROI)
- Evaluating build vs. buy decisions from a commercial perspective
- Supporting pre-sales or solution design activities
- Assessing vendor relationships, enterprise agreements, and licence compliance
- Navigating NHS procurement frameworks (G-Cloud, Digital Outcomes & Specialists, CCS)
- Applying EMIS/Optum cost governance thresholds and escalation triggers
- Assessing commercial risk from vendor lock-in or proprietary technology choices

## Commercial Principles (EMIS/Optum)

1. **Cost Estimates Are Mandatory** — Every architecture recommendation must include an indicative cost impact; no design proceeds without a ROM cost estimate
2. **Cost Governance Thresholds** — Escalate for budget holder approval when: annual recurring cost > £50,000; one-off cost > £25,000; or cost increase > 20% over current baseline
3. **Total Cost, Not Unit Price** — Evaluate TCO over 3-5 years including operations, migration, licensing, and support — not just compute cost
4. **FinOps by Default** — Always recommend right-sizing, reserved capacity, auto-scaling, and resource tagging; OpEx waste is a design defect
5. **Avoid Vendor Lock-In Premiums** — Flag when a design creates significant switching costs; propose portable alternatives where practical; proprietary-only choices require ARB approval
6. **Licence Compliance is Non-Negotiable** — Validate all software licensing terms before recommending: BYOL vs. included, core-based vs. user-based, AHUB eligibility, cloud vs. on-prem licensing
7. **Architecture Does Not Make Commercial Commitments** — Pricing, contractual terms, and procurement decisions require sign-off from the Commercial/Procurement team; architects provide technical validation and indicative costing only
8. **Transparency in Assumptions** — All cost estimates must document pricing date, region, utilisation assumptions, currency, and model (PAYG / Reserved); estimates without documented assumptions are not valid
9. **CapEx vs. OpEx Alignment** — Understand the customer's financial model; cloud can be either CapEx (reserved pre-pay) or OpEx (PAYG); align the recommendation to the budget holder's preference and financial reporting requirements
10. **NHS Procurement Compliance** — For externally facing solutions or services sold to NHS customers, validate that procurement aligns with the applicable NHS framework (G-Cloud, DoS, CCS); see [NHS Procurement](./references/nhs-procurement.md)

## Procedure

### 1. Solution Viability Assessment

Before investing in detailed design, assess commercial viability:

1. **Understand the requirement** — What is the business need? Who is the customer (internal/external)?
2. **Estimate scope** — T-shirt size the infrastructure requirement (compute, storage, network, licensing)
3. **Rough order of magnitude (ROM) cost** — Quick estimate using known baselines or pricing calculators
4. **Compare to budget/value** — Is the estimated cost proportionate to the business value?
5. **Check cost governance thresholds** — Does the ROM exceed £50k ARR or £25k one-off? If so, flag for budget holder approval before proceeding
6. **Identify commercial risks** — Licensing complexity, vendor lock-in, long-term commitment requirements
7. **Recommend: proceed / modify / decline** — With rationale

### Viability Assessment Template

```markdown
## Solution Viability Assessment

| Item | Detail |
|------|--------|
| **Request** | [Brief description of what's being asked] |
| **Requestor** | [Team/person] |
| **Business Value** | [What business outcome does this enable?] |
| **ROM Cost Estimate** | £XX,XXX - £XX,XXX per annum |
| **Complexity** | S / M / L / XL |
| **Timeline** | [Estimated delivery timeline] |
| **Threshold Flag** | ARR > £50k? One-off > £25k? Cost increase > 20%? → Budget holder approval required |
| **Key Risks** | [Commercial, technical, operational risks] |
| **Recommendation** | Proceed / Proceed with conditions / Decline |
| **Conditions** | [If proceeding with conditions, what must change?] |
```

### 2. Bill of Materials Generation

1. Load the relevant BoM template for the platform — see [BoM Templates](./references/bom-templates.md)
2. List every resource individually by category: compute, storage, networking, database, security & monitoring, licensing
3. Apply pricing from Azure Pricing Calculator / AWS Pricing Calculator / vendor quotes — document the date
4. Add one-off costs: migration effort, documentation, testing, training
5. Show pricing options (PAYG, Reserved 1yr, Reserved 3yr) side-by-side
6. Apply applicable discounts: Azure Hybrid Benefit, Dev/Test pricing, AWS Savings Plans, negotiated EA rates
7. Produce the Cost Summary with monthly, annual, and Year 1 / Year 2+ totals
8. Flag if totals exceed governance thresholds (see Commercial Principle #2)

### 3. Build vs. Buy Analysis

When a demand could be met by building in-house or purchasing a commercial solution:

1. Define the requirement clearly (scope, NFRs, integration needs)
2. Identify viable build options (custom development, open source, internal platform)
3. Identify viable buy/SaaS options (vendor products, managed services)
4. Score each option against the evaluation criteria — see [Build vs. Buy](./references/build-vs-buy.md)
5. Produce a recommendation with TCO comparison and risk assessment
6. Document as an ADR if the decision is significant (use the `/decision-making` skill)

### 4. RFP / Commercial Bid Response

1. Load the RFP response structure — see [RFP & Bid Guidance](./references/rfp-bid-guidance.md)
2. For NHS bids, confirm the applicable procurement framework — see [NHS Procurement](./references/nhs-procurement.md)
3. Map all stated requirements to the proposed solution
4. Produce the technical architecture section (use `/architecture` and `/output` skills)
5. Generate the BoM and cost model (see step 2 above)
6. Complete the NFR compliance table
7. Route the full response to Commercial/Procurement for commercial terms and submission

## References

- [BoM Templates](./references/bom-templates.md) — Bill of Materials structure for Azure, AWS, and on-premises solutions
- [RFP & Bid Guidance](./references/rfp-bid-guidance.md) — How to structure RFP responses and commercial bids
- [Costing Models](./references/costing-models.md) — TCO, ROI, OpEx vs CapEx analysis; EMIS/Optum cost thresholds
- [Build vs. Buy](./references/build-vs-buy.md) — Framework for evaluating build, buy, and SaaS options
- [Vendor Management](./references/vendor-management.md) — Key vendor relationships, enterprise agreements, licence governance
- [NHS Procurement](./references/nhs-procurement.md) — G-Cloud, Digital Outcomes & Specialists, CCS frameworks for NHS bids
