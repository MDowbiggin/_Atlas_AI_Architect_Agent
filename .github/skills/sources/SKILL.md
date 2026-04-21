---
name: sources
description: "Authoritative source registry for EMIS/Optum infrastructure architecture. Use when: looking up where to find standards, templates, previous designs, CMDB data, vendor documentation, Confluence spaces, or any authoritative reference material."
---

# Authoritative Sources

## When to Use

- Looking up where to find a specific standard, template, or reference document
- Verifying the authoritative source for a technology decision or architecture pattern
- Finding previous HLD/LLD designs for similar solutions
- Locating CMDB data, asset information, or configuration details
- Identifying the correct Confluence space or wiki page for a topic
- Looking up **cloud resource naming conventions** or **tagging standards** — see [references/naming-tagging-policy.md](references/naming-tagging-policy.md)
- Checking **architecture knowledge gaps**, regional knowledge areas, or vendor contact tracking — see [references/knowledge-base-tracker.md](references/knowledge-base-tracker.md)
- Reviewing **security architecture requirements** (Zero Trust, encryption, authentication, OWASP) — see [references/security-architecture.md](references/security-architecture.md)
- Applying the **AWS Well-Architected Framework** pillars and design principles — see [references/well-architected-framework.md](references/well-architected-framework.md)

## Source Registry

### Internal Sources

| Source | Type | Location | Content |
|--------|------|----------|---------|
| **Confluence — Architecture** | Wiki | [INTERNAL — populate: Confluence space URL] | Architecture standards, principles, design patterns, ADRs, review board minutes |
| **Confluence — PIMS** | Wiki | [INTERNAL — populate: Confluence space URL] | PIMS operating model, service catalogue, runbooks, operational procedures |
| **Confluence — Security** | Wiki | [INTERNAL — populate: Confluence space URL] | Security policies, compliance baselines, incident response procedures |
| **Confluence — Engineering** | Wiki | [INTERNAL — populate: Confluence space URL] | Engineering standards, coding guidelines, CI/CD templates |
| **ServiceNow — CMDB** | Database | [INTERNAL — populate: ServiceNow instance URL] | Configuration Items, relationships, attributes for all infrastructure |
| **ServiceNow — Knowledge Base** | Wiki | [INTERNAL — populate: ServiceNow instance URL] | Runbooks, known errors, standard operating procedures |
| **Azure DevOps — Repos** | Source Control | [INTERNAL — populate: ADO organisation URL] | IaC code (Terraform, Bicep), pipeline definitions, architecture documentation |
| **Azure DevOps — Boards** | Work Tracking | [INTERNAL — populate: ADO organisation URL] | Demand items, project tasks, sprint boards |
| **SharePoint — Architecture** | Document Store | [INTERNAL — populate: SharePoint site URL] | Formal HLD/LLD documents, cost estimates, presentations, diagrams |
| **Dynatrace** | Monitoring | [INTERNAL — populate: Dynatrace environment URL] | Application topology, performance baselines, service dependencies |
| **Cloud Resource Naming & Tagging Policy** | Standard | [references/naming-tagging-policy.md](references/naming-tagging-policy.md) | Naming convention format, resource type abbreviations (AWS & Azure), mandatory tags, tagging limits, platform-specific exemptions |
| **Infrastructure Architecture Knowledge Base Tracker** | Tracker | [references/knowledge-base-tracker.md](references/knowledge-base-tracker.md) | Knowledge gaps, regional architecture areas (Gibraltar, Jersey, Wales, Scotland, NI, IoM, Guernsey), vendor relationships, DC exits, progress tracking |
| **Security Architecture** | Standard | [references/security-architecture.md](references/security-architecture.md) | Security by Design principles, Zero Trust model, mandatory security requirements (encryption, auth, OWASP, least privilege, audit), child page index |
| **Well-Architected Framework** | Standard | [references/well-architected-framework.md](references/well-architected-framework.md) | EMIS adoption context for AWS WAF, 6 pillars (operational excellence, security, reliability, performance efficiency, cost optimisation, sustainability), design principles, best practices |

### Previous Design Artefacts

When designing a solution, check for similar previous designs:

| Artefact Type | Where to Find | Search By |
|---------------|---------------|-----------|
| High-Level Designs (HLD) | SharePoint Architecture library; Confluence Architecture space | Application name, technology stack, design pattern |
| Low-Level Designs (LLD) | SharePoint Architecture library; ADO Wiki | Application name, technology component |
| Architecture Decision Records | Confluence Architecture space; ADO Wiki | Decision date, technology area |
| Cost Estimates / BoM | SharePoint Architecture library | Project name, date |
| Network Diagrams | Confluence Architecture space; draw.io exports | VLAN, VNet name, application |
| Runbooks | ServiceNow Knowledge Base; Confluence PIMS space | Application name, procedure type |

### Vendor Documentation

| Vendor / Platform | Authoritative Source | Use For |
|------------------|---------------------|---------|
| **Microsoft Azure** | [Microsoft Learn — Azure](https://learn.microsoft.com/en-us/azure/) | Service documentation, SKU details, pricing, SLAs |
| **Microsoft Azure — Architecture Center** | [Azure Architecture Center](https://learn.microsoft.com/en-us/azure/architecture/) | Reference architectures, design patterns, best practices |
| **Amazon Web Services** | [AWS Documentation](https://docs.aws.amazon.com/) | Service documentation, instance types, pricing |
| **AWS — Architecture Center** | [AWS Architecture Center](https://aws.amazon.com/architecture/) | Reference architectures, design patterns, best practices by technology domain |
| **AWS — Prescriptive Guidance** | [AWS Prescriptive Guidance](https://docs.aws.amazon.com/prescriptive-guidance/latest/welcome.html) | Migration patterns, modernisation strategies, implementation guides, landing zone |
| **AWS — Well-Architected** | [AWS Well-Architected](https://aws.amazon.com/architecture/well-architected/) | Framework pillars, lens guidance, WAF Tool |
| **AWS — re:Post** | [AWS re:Post](https://repost.aws/) | Community Q&A; official AWS answers; curated knowledge base |
| **VMware** | [VMware Docs](https://docs.vmware.com/) | vSphere, vSAN, NSX documentation |
| **Terraform** | [Terraform Registry](https://registry.terraform.io/) | Provider docs, module registry |
| **Dynatrace** | [Dynatrace Docs](https://docs.dynatrace.com/) | OneAgent deployment, API reference, configuration |
| **ServiceNow** | [ServiceNow Docs](https://docs.servicenow.com/) | ITSM modules, CMDB schema, API reference |
| **CIS Benchmarks** | [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) | Hardening guides (requires CIS membership for full access) |
| **NIST** | [NIST CSF](https://www.nist.gov/cyberframework) | Cybersecurity Framework, SP 800-53 controls |

### Architecture Review Board (ARB)

| Item | Detail |
|------|--------|
| **Purpose** | Review and approve significant architecture decisions, new technology introductions, and designs exceeding defined thresholds |
| **Meeting Cadence** | [INTERNAL — populate: frequency and schedule] |
| **Submission Process** | [INTERNAL — populate: how to submit for ARB review] |
| **Required Artefacts** | HLD, cost estimate, security review, risk assessment |
| **Membership** | [INTERNAL — populate: ARB member roles] |
| **Decision Record** | Recorded in Confluence Architecture space as ADRs |

## Source Priority

When information conflicts between sources, use this priority order:

1. **EMIS/Optum internal standards** (Confluence Architecture space) — always takes precedence
2. **Regulatory requirements** (HIPAA, UK Data Protection Act) — legal compliance is non-negotiable
3. **Industry frameworks** (NIST, CIS, ISO 27001) — applied as interpreted by internal standards
4. **Vendor best practices** (Azure Architecture Center, AWS Well-Architected) — generally followed unless conflicting with internal standards
5. **Community best practices** (blog posts, Stack Overflow, etc.) — verify against official documentation before citing

## How to Reference Sources

When producing architecture artefacts, always cite your sources:

```markdown
## References

| # | Source | Title | Location | Accessed |
|---|--------|-------|----------|----------|
| 1 | EMIS/Optum Architecture Standards | Network Design Principles | [Confluence link] | YYYY-MM-DD |
| 2 | Azure Architecture Center | Hub-spoke network topology | [URL] | YYYY-MM-DD |
| 3 | CIS Benchmark | Azure CIS v2.1 | [CIS link] | YYYY-MM-DD |
```
