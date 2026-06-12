---
name: output
description: "Output templates and formatting guidelines for architecture artefacts. Use when: producing HLDs, LLDs, runbooks, cost estimates, diagrams (Mermaid/draw.io), Architecture Decision Records, architecture assessments, post-incident reviews, or any formal infrastructure architecture deliverable."
---

# Output Templates & Formatting

## When to Use

- Documenting requirements before a demand review, project, research, or design (first gate)
- Producing a High-Level Design (HLD) document
- Producing a Low-Level Design (LLD) document
- Creating operational runbooks for PIMS/CloudOps
- Generating cost estimates or Bills of Material
- Creating architecture diagrams (Mermaid, draw.io, C4 model)
- Producing an Architecture Assessment for Aha! demand triage
- Preparing an ARB submission paper
- Producing a Post-Incident Review (PIR) document
- Formatting any formal infrastructure architecture deliverable

## Available Templates

| Template | Use Case | Reference |
|----------|----------|-----------|
| **Requirements Specification** | Documented requirements record — mandatory first gate before research, demand review, or design | See `/decision-making` skill — [Requirements Specification Template](../decision-making/references/requirements-specification-template.md) |
| **HLD** | High-Level Design for new or modified solutions | [HLD Template](./references/hld-template.md) |
| **LLD** | Low-Level Design with configuration-level detail | [LLD Template](./references/lld-template.md) |
| **Runbook** | Operational procedures for PIMS/CloudOps | [Runbook Template](./references/runbook-template.md) |
| **Cost Estimate** | Cost breakdown and TCO analysis | [Cost Estimate Template](./references/cost-estimate-template.md) |
| **Diagrams** | Architecture diagrams and notation guide | [Diagram Guidelines](./references/diagram-guidelines.md) |
| **Architecture Assessment** | Aha! demand triage and benefit/complexity scoring | [Architecture Assessment Template](./references/architecture-assessment-template.md) |
| **Post-Incident Review** | Structured PIR following P1/P2 incidents | [PIR Template](./references/pir-template.md) |
| **ADR** | Architecture Decision Record | See `/decision-making` skill |
| **BoM** | Bill of Materials | See `/commercial-sales` skill |
| **Demand Review** | Full pre-design demand review | See `/decision-making` skill |
| **ARB Submission** | ARB escalation paper | See `/decision-making` skill — [ARB Guidance](../decision-making/references/arb-guidance.md) |

## Output Selection Guide

| Task | Primary Output | Supporting Outputs |
|------|---------------|-------------------|
| Requirements capture (any new ask) | Requirements Specification | — (precedes all other outputs) |
| New solution design | HLD | Diagrams, Cost Estimate, ADR(s) |
| Detailed implementation spec | LLD | Diagrams, Runbook |
| Operational handover | Runbook | CMDB entries, monitoring dashboards |
| Commercial bid | BoM + Cost Estimate | HLD (summary), Diagrams |
| Demand triage (Aha!) | Architecture Assessment | — (full Demand Review follows if prioritised) |
| Demand review | Demand Review Summary | ROM Cost Estimate |
| Technology decision | ADR | Option Analysis |
| Cost optimisation review | Cost Estimate | Recommendations document |
| ARB escalation | ARB Submission Paper | HLD, ADR, Cost Estimate |
| Post-incident review | PIR | ADR (if architectural root cause), Demand (for remediation) |

## Output Principles

1. **Template-first** — Always start from the approved template; do not produce freeform outputs where a template exists; the template structure is the minimum, not the maximum
2. **Completeness** — Every mandatory section must be present and populated in final/approved documents; placeholder text (`[TBD]`, `[TODO]`) is acceptable in drafts but not in documents submitted for review or approval
3. **Classification-first** — Assign a document classification before writing any content; classification governs who may read, store, and share the document; default to Confidential if in doubt
4. **Diagrams must match text** — Every architectural claim in prose must be reflected in or consistent with the diagrams; a contradiction between a diagram and a table is a defect that blocks approval
5. **Single source of truth** — The authoritative version of every document lives in the designated repository (SharePoint/Confluence/ADO); local copies must not diverge from the authorised version
6. **Version-controlled** — All outputs carry a version number, change history, author, and status; a document without version control is uncontrolled and should not be distributed
7. **Review before publish** — No formal artefact is distributed before peer review; HLDs and cost estimates additionally require security review and budget approval respectively before they are considered approved
8. **Audience-appropriate** — Match the level of technical detail to the audience; executive summaries are written for non-technical stakeholders, technical sections for engineers; do not embed PHI/PII in architecture documents

## Procedure

### For Any Formal Output

1. Identify the appropriate template from the Available Templates table above
2. Load the relevant reference file and follow the template structure
3. All mandatory sections must be included and populated
4. Apply EMIS/Optum document standards:
   - **Classification**: Mark all documents (Public, Internal, Confidential, Restricted)
   - **Document ID**: Use the standard naming convention (HLD-XXXX, LLD-XXXX, RB-XXXX, CE-XXXX, PIR-XXXX)
   - **Version control**: Include version number, date, author, and change history
   - **Review**: All formal documents require peer review before distribution
5. Include diagrams using approved tools (Mermaid for inline, draw.io for detailed)
6. Store the output in the appropriate location (SharePoint, Confluence, ADO)
7. For HLDs and Cost Estimates exceeding governance thresholds, route for budget holder and/or ARB approval before marking as Approved
8. For any document covering PHI/PII systems, ensure the Compliance Mapping section is complete and security review is confirmed

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
- [Architecture Assessment Template](./references/architecture-assessment-template.md) — Aha! demand triage scoring template
- [PIR Template](./references/pir-template.md) — Post-Incident Review for P1/P2 incidents with architectural implications
