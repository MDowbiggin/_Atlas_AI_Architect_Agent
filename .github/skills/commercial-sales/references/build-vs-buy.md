# Build vs. Buy Analysis

## Overview

When a demand can be met by building a custom solution in-house, purchasing a commercial product, or adopting a SaaS offering, a structured Build vs. Buy analysis must be conducted. This prevents unvalidated decisions that result in unnecessary technical debt, excessive cost, or strategic misalignment.

> **Default disposition**: EMIS/Optum prefers buying commodity capabilities (monitoring, identity, ITSM) and building only where there is a genuine competitive differentiator or no suitable commercial alternative. Do not build what can be purchased cost-effectively.

---

## When to Conduct a Build vs. Buy Analysis

- A demand could credibly be met by either a new internal build or a commercial/SaaS product
- A vendor is proposing a proprietary solution that could alternatively be built on open-source or platform-native services
- An existing bespoke in-house solution is approaching end-of-life and a commercial alternative now exists
- A re-platforming decision requires evaluating managed PaaS vs. self-managed OSS

---

## Option Types

| Option | Description | Examples |
|--------|-------------|---------|
| **Build (custom)** | Develop in-house from scratch or on open-source foundations | Custom API service, bespoke integration |
| **Buy (COTS)** | Purchase a Commercial off-the-shelf product with licences | Dynatrace, ServiceNow, CrowdStrike |
| **SaaS** | Subscribe to a cloud-hosted managed application | Microsoft 365, Salesforce, GitHub |
| **PaaS-native** | Use a cloud-native managed service as the capability | AWS RDS vs. self-managed PostgreSQL on EC2 |
| **Open Source** | Adopt open-source software with internal operational responsibility | Prometheus, Grafana, HashiCorp Vault |
| **Do Nothing** | Retain current approach; defer or decline | Continue with existing solution |

---

## Evaluation Criteria & Weighting

Score each option 1–5 per criterion. Adjust weights to reflect the specific decision context.

| Criterion | Default Weight | Description |
|-----------|---------------|-------------|
| **Functional Fit** | 20% | Does it meet the functional requirements? |
| **Non-Functional Fit** | 15% | Performance, scalability, availability, security compliance |
| **Total Cost of Ownership** | 20% | 3-year TCO including build/licence, operations, and migration |
| **Time to Value** | 10% | How quickly can the capability be delivered? |
| **Strategic Alignment** | 10% | Does it align with cloud-first, automation-first, and platform standards? |
| **Vendor/Supplier Risk** | 10% | Stability, lock-in potential, switching cost, contract terms |
| **Operational Complexity** | 10% | How much operational overhead does this add for PIMS/CloudOps? |
| **Security & Compliance** | 5% | Meets HIPAA, CIS Level 2, ISO 27001, EMIS/Optum security baseline |

### Scoring Guide

| Score | Meaning |
|-------|---------|
| **5** | Exceeds requirement fully; no gaps |
| **4** | Meets requirement; minor gaps or caveats |
| **3** | Partially meets; notable gaps with achievable workarounds |
| **2** | Significant gaps; requires additional investment to meet requirement |
| **1** | Does not meet; fundamental gaps or prohibitive cost |

---

## Build vs. Buy Scorecard Template

```markdown
## Build vs. Buy Analysis — [Capability / Service Name]

### Decision Context
[2-3 sentences describing what capability is being evaluated and why the decision is needed]

### Options Under Consideration

| Option | Description |
|--------|-------------|
| Option A | [e.g., Build custom service using AWS Lambda + DynamoDB] |
| Option B | [e.g., Buy — Commercial product X at £XX,000/yr] |
| Option C | [e.g., PaaS-native — AWS managed service Y] |

### Evaluation Scores

| Criterion | Weight | Option A Score | Option A Weighted | Option B Score | Option B Weighted | Option C Score | Option C Weighted |
|-----------|--------|---------------|-------------------|---------------|-------------------|---------------|-------------------|
| Functional Fit | 20% | /5 | | /5 | | /5 | |
| Non-Functional Fit | 15% | /5 | | /5 | | /5 | |
| Total Cost of Ownership | 20% | /5 | | /5 | | /5 | |
| Time to Value | 10% | /5 | | /5 | | /5 | |
| Strategic Alignment | 10% | /5 | | /5 | | /5 | |
| Vendor / Supplier Risk | 10% | /5 | | /5 | | /5 | |
| Operational Complexity | 10% | /5 | | /5 | | /5 | |
| Security & Compliance | 5% | /5 | | /5 | | /5 | |
| **Weighted Total** | 100% | | **/5.0** | | **/5.0** | | **/5.0** |

### TCO Summary (3-Year)

| Cost Element | Option A | Option B | Option C |
|-------------|---------|---------|---------|
| Build / Licence cost | £XXX | £XXX | £XXX |
| Ongoing operational cost | £XXX/yr | £XXX/yr | £XXX/yr |
| Migration / integration effort | £XXX | £XXX | £XXX |
| **3-Year TCO** | **£XXX** | **£XXX** | **£XXX** |

### Risks & Trade-offs

| Option | Key Risks | Key Benefits |
|--------|----------|-------------|
| Option A | [e.g., High build effort; ongoing maintenance burden; team capacity risk] | [e.g., Full control; no vendor dependency] |
| Option B | [e.g., Vendor lock-in; proprietary integration; contract renewal risk] | [e.g., Feature-rich; quick to deploy; vendor-supported] |
| Option C | [e.g., Cloud provider lock-in; limited customisation] | [e.g., Managed; lower operational overhead; cost-effective] |

### Recommendation

**Recommended Option**: [Option X] — [Brief rationale]

**Conditions**: [Any conditions that must be met for this option to proceed]

**Decision Authority**: [Architect / ARB / Budget holder — depending on cost and strategic impact]
```

---

## Decision Tree

```
Is there a mandatory compliance or regulatory requirement this must meet?
├── Yes → Does any commercial/SaaS option meet that requirement?
│   ├── Yes → Evaluate commercial/SaaS options via scorecard
│   └── No → Build (custom) is the likely path; confirm with Security team
└── No
    ├── Is there a cloud-native (PaaS) managed service that meets the need?
    │   ├── Yes → PaaS-native is strongly preferred; score against alternatives
    │   └── No
    │       ├── Is there an approved EMIS/Optum standard product already covering this?
    │       │   ├── Yes → Use the existing standard product; no new build/buy needed
    │       │   └── No
    │       │       ├── Is there a proven Commercial/SaaS option at acceptable TCO?
    │       │       │   ├── Yes → Buy is preferred; score against build; document lock-in risk
    │       │       │   └── No → Build (or open-source with internal operations); confirm team capacity
    │       └──
    └──
```

---

## Common Patterns & Guidance

### When Build is Right

- The capability represents a genuine competitive differentiator for EMIS/Optum's products
- No commercial product meets the functional or compliance requirement
- The team has the capacity and skill to build and sustain it
- The TCO of build over 3 years is demonstrably lower than buy
- The capability is core to EMIS/Optum's IP (e.g., clinical decision logic, proprietary algorithms)

### When Buy/SaaS is Right

- The capability is a commodity (monitoring, ITSM, identity, endpoint protection)
- A commercial product is feature-rich and well-supported at acceptable TCO
- The team does not have capacity to build and sustain a bespoke solution
- Time-to-value is critical and a commercial product can be deployed faster
- The operational overhead of running open-source is prohibitive

### When PaaS-Native is Right

- A cloud-managed service meets the requirement without additional licensing overhead
- Operational complexity reduction is a priority (managed backups, patching, HA by default)
- The workload is on the same cloud platform as the managed service
- TCO is lower than self-managed alternatives when full operational cost is included

### Vendor Lock-In Assessment

For any Buy option, explicitly assess and document:

| Lock-In Factor | Low Risk | High Risk |
|----------------|---------|----------|
| Data portability | Open formats (JSON, CSV, FHIR) | Proprietary data format; no export API |
| Integration | Standard APIs (REST, OAuth 2.0) | Proprietary SDK or protocol required |
| Contract terms | Month-to-month or short-term | Multi-year with termination penalties |
| Switching cost | Low migration effort; alternatives exist | High migration cost; no alternatives |
| Pricing trajectory | Stable pricing history | Recent Broadcom-style price increases post-acquisition |

If any factor is **High Risk**, document the switching cost estimate and obtain ARB sign-off before proceeding.

---

## References

- [Costing Models](./costing-models.md) — TCO, ROI templates for the financial comparison
- [Vendor Management](./vendor-management.md) — Existing vendor relationships and enterprise agreements to consider
- [M&A Integration](../../business-strategy/references/ma-integration.md) — Relevant when evaluating build vs. buy for capabilities that came through acquisition
