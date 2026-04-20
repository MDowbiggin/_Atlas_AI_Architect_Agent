---
name: output
description: "Output templates and formatting guidelines for architecture artefacts. Use when: producing HLDs, LLDs, runbooks, cost estimates, diagrams (Mermaid/draw.io), Architecture Decision Records, or any formal infrastructure architecture deliverable."
---

# Output Templates & Formatting

## When to Use

- Producing a High-Level Design (HLD) document
- Producing a Low-Level Design (LLD) document
- Creating operational runbooks for PIMS/CloudOps
- Generating cost estimates or Bills of Material
- Creating architecture diagrams (Mermaid, draw.io, C4 model)
- Formatting any formal architecture deliverable

## Available Templates

| Template | Use Case | Reference |
|----------|----------|-----------|
| **HLD** | High-Level Design for new or modified solutions | [HLD Template](./references/hld-template.md) |
| **LLD** | Low-Level Design with configuration-level detail | [LLD Template](./references/lld-template.md) |
| **Runbook** | Operational procedures for PIMS/CloudOps | [Runbook Template](./references/runbook-template.md) |
| **Cost Estimate** | Cost breakdown and TCO analysis | [Cost Estimate Template](./references/cost-estimate-template.md) |
| **Diagrams** | Architecture diagrams and notation guide | [Diagram Guidelines](./references/diagram-guidelines.md) |
| **ADR** | Architecture Decision Record | See `/decision-making` skill |
| **BoM** | Bill of Materials | See `/commercial-sales` skill |
| **Demand Review** | Demand review summary | See `/decision-making` skill |

## Output Selection Guide

| Task | Primary Output | Supporting Outputs |
|------|---------------|-------------------|
| New solution design | HLD | Diagrams, Cost Estimate, ADR(s) |
| Detailed implementation spec | LLD | Diagrams, Runbook |
| Operational handover | Runbook | CMDB entries, monitoring dashboards |
| Commercial bid | BoM + Cost Estimate | HLD (summary), Diagrams |
| Demand review | Demand Review Summary | ROM Cost Estimate |
| Technology decision | ADR | Option Analysis |
| Cost optimisation review | Cost Estimate | Recommendations document |

## Procedure

### For Any Formal Output

1. Identify the appropriate template from the table above
2. Load the relevant reference file
3. Follow the template structure — all mandatory sections must be included
4. Apply EMIS/Optum document standards:
   - **Classification**: Mark all documents (Public, Internal, Confidential, Restricted)
   - **Version control**: Include version number, date, author, change history
   - **Review**: All formal documents require peer review before distribution
5. Include diagrams using approved tools (Mermaid for inline, draw.io for detailed)
6. Store the output in the appropriate location (SharePoint, Confluence, ADO)

## Document Classification

| Level | Definition | Handling |
|-------|-----------|---------|
| **Public** | Can be shared externally | No restrictions |
| **Internal** | EMIS/Optum employees and authorised contractors only | Do not share externally |
| **Confidential** | Need-to-know within EMIS/Optum | Restricted distribution; encrypted storage |
| **Restricted** | PHI, PII, or highly sensitive commercial data | Encrypted storage and transit; formal access control; audit logged |

## References

- [HLD Template](./references/hld-template.md)
- [LLD Template](./references/lld-template.md)
- [Runbook Template](./references/runbook-template.md)
- [Cost Estimate Template](./references/cost-estimate-template.md)
- [Diagram Guidelines](./references/diagram-guidelines.md)
