---
name: sources
description: "Authoritative source registry for EMIS/Optum infrastructure architecture. Use when: looking up where to find standards, templates, previous designs, CMDB data, vendor documentation, Confluence spaces, Aha! demand pivots, GitHub repos, NHS Digital standards, or any authoritative reference material."
---

# Authoritative Sources

## When to Use

- Looking up where to find a specific standard, template, or reference document
- Verifying the authoritative source for a technology decision or architecture pattern
- Finding previous HLD/LLD designs for similar solutions
- Locating CMDB data, asset information, or configuration details
- Identifying the correct Confluence space or wiki page for a topic
- Finding the correct Aha! demand pivot (Hosted Services or Platform Engineering) to review or raise demands
- Locating EMIS GitHub repositories (SRE config repos, IaC repos, Backstage/IDP)
- Looking up **cloud resource naming conventions** or **tagging standards** — see [references/naming-tagging-policy.md](references/naming-tagging-policy.md)
- Checking **architecture knowledge gaps**, regional knowledge areas, or vendor contact tracking — see [references/knowledge-base-tracker.md](references/knowledge-base-tracker.md)
- Reviewing **security architecture requirements** (Zero Trust, encryption, authentication, OWASP) — see [references/security-architecture.md](references/security-architecture.md)
- Applying the **AWS Well-Architected Framework** pillars and design principles — see [references/well-architected-framework.md](references/well-architected-framework.md)
- Finding the correct NHS Digital / DCB standard for a clinical or HSCN-connected system
- Locating a previous ADR, PIR, or architecture assessment for a specific system or technology

## Sources Principles

1. **Single Source of Truth** — Every artefact, standard, and decision has exactly one authoritative version in an agreed location; local copies, email attachments, and desktop files are not authoritative and must not be distributed as final; always link to the canonical source
2. **Internal Standards Override Vendor Guidance** — EMIS/Optum internal standards (Confluence Architecture space) always take precedence over vendor best practices, community posts, or framework guidance; vendor guidance is adopted as interpreted by internal standards, not verbatim
3. **Cite Your Sources** — All architecture artefacts (HLD, LLD, ADR, PIR, cost estimate) must include a references table with source, title, location, and date accessed; undocumented sources cannot be verified or challenged
4. **Verify Freshness** — Architecture sources become outdated; before citing a document, verify it is the current version; check the document version date, and for vendor documentation, verify against the current release; if a source is more than 12 months old without a review date, flag it
5. **Access-Appropriate** — Only cite sources you have verified access to; do not assume access to Restricted or Confidential documents; if a source is behind a paywall or requires a membership (e.g., CIS Benchmarks), note this when referencing
6. **Prefer Primary Sources** — Cite primary sources (official vendor docs, regulatory text, framework publications) over secondary interpretations (blog posts, community discussions, training materials); secondary sources are acceptable for supplementary context, never as the sole reference for a compliance claim
7. **Link, Don't Copy** — Reference documents by link, not by inline reproduction; reproducing large sections of vendor or regulatory content creates maintenance burden and copyright risk; summarise and link

## Source Registry

### Internal Sources

| Source | Type | Location | Content |
|--------|------|----------|---------|
| **Confluence — Architecture** | Wiki | [Infrastructure Architecture Knowledge Base Tracker](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/7881818337/Infrastructure+Architecture+Knowledge+Base+Tracker) | Architecture standards, principles, design patterns, ADRs, review board minutes |
| **Confluence — Architecture (Design Template)** | Wiki | [Solution Design Template](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6350569511/Solution+Design+Template) | Official HLD/LLD template |
| **Confluence — Architecture (WAF)** | Wiki | [Well Architected Framework Checklist](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6887803190/Well+Architected+Framework+Checklist) | WAF checklist for design reviews |
| **Confluence — Architecture (Goals)** | Wiki | [Architectural Goals](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/7781941249/Architectural+Goals) | Strategic architecture goals |
| **Confluence — Architecture (Tech Choices)** | Wiki | [Technology Choices & Benefits](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6570770654/Technology+Choices+and+Benefits) | Approved technology decisions and rationale |
| **Confluence — Architecture (AWS Adelaide)** | Wiki | [Adelaide Architecture](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/6499991902/Adelaide+Architecture) | AWS architecture reference |
| **Confluence — Brisbane Space** | Wiki | https://emishealthgroup.atlassian.net/wiki/spaces/PBA | Brisbane project documentation |
| **Confluence — PIMS / HEPK** | Wiki | [VMware vCenter Login Instructions](https://emishealthgroup.atlassian.net/wiki/spaces/HEPK/pages/6253838337/VMware+-+vCenter+Login+Instructions) | VMware access and operational guides |
| **Confluence — Hosting Services** | Wiki | [LLD Wales Expansion 2024](https://emishealthgroup.atlassian.net/wiki/spaces/HS/pages/7006814862/LLD+WALES+Expansion+2024) | On-premises and hosted infrastructure LLDs |
| **Confluence — Elvis (Rising Sun)** | Wiki | [Rising Sun space](https://emishealthgroup.atlassian.net/wiki/spaces/Elvis) | Rising Sun programme documentation (CrowdStrike, Tenable, Delinea, Darktrace) |
| **ServiceNow — CMDB** | Database | [INTERNAL — populate: ServiceNow instance URL] | Configuration Items, relationships, attributes for all infrastructure |
| **ServiceNow — Knowledge Base** | Wiki | [INTERNAL — populate: ServiceNow instance URL] | Runbooks, known errors, standard operating procedures |
| **Azure DevOps — Repos** | Source Control | [INTERNAL — populate: ADO organisation URL] | IaC code (Terraform, Bicep), pipeline definitions, architecture documentation |
| **Azure DevOps — Boards** | Work Tracking | [INTERNAL — populate: ADO organisation URL] | El Capitan, Blanc, Everest, Snowden workstream boards |
| **Aha! — Hosted Services Demand Pivot** | Backlog | https://optum.aha.io/bookmarks/custom_pivots/7631534830970022767 | Hosted Services architecture demands and prioritisation |
| **Aha! — Platform Engineering Demand Pivot** | Backlog | https://optum.aha.io/bookmarks/custom_pivots/7631536791781662911 | Platform Engineering architecture demands and prioritisation |
| **GitHub — emisgroup (EMIS-X Engineering)** | Source Control | https://github.com/emisgroup/emisx-engineering | Platform Engineering, Backstage/IDP, gold path templates |
| **GitHub — EMISHealth SRE Config** | Source Control | https://github.com/emisgroup/emishealth-sre-config | SRE Dynatrace configuration for England/Nations EMISWeb, CCMH, GPES, EMIS Connect |
| **GitHub — EMIS-X SRE Config** | Source Control | https://github.com/emisgroup/emisx-sre-config | SRE Dynatrace configuration for EMIS-X, EXA, PFS, Community Pharmacy, Pathway |
| **Backstage / Hub (IDP)** | IDP | https://hub.emis-x.uk/ | Software Catalog, gold path templates, TechDocs; internal developer platform |
| **Platform Engineering Docs** | Wiki | https://engineering.emis-x.uk/docs/category/platform-engineering | Platform Engineering hub; Backstage, SRE, IaC standards |
| **SharePoint — Architecture** | Document Store | [INTERNAL — populate: SharePoint site URL] | Formal HLD/LLD documents, cost estimates, presentations, diagrams |
| **Dynatrace** | Monitoring | https://zoh82166.apps.dynatrace.com/ui/apps/dynatrace.dashboards/dashboards | Application topology, performance baselines, service dependencies |
| **Cloud Resource Naming & Tagging Policy** | Standard | [references/naming-tagging-policy.md](references/naming-tagging-policy.md) | Naming convention format, resource type abbreviations (AWS & Azure), mandatory tags |
| **Infrastructure Architecture Knowledge Base Tracker** | Tracker | [references/knowledge-base-tracker.md](references/knowledge-base-tracker.md) | Knowledge gaps, regional architecture areas, vendor relationships, DC exits |
| **Security Architecture** | Standard | [references/security-architecture.md](references/security-architecture.md) | Security by Design, Zero Trust, mandatory requirements, OWASP; links to security-compliance skill |
| **Well-Architected Framework (AWS)** | Standard | [references/well-architected-framework.md](references/well-architected-framework.md) | AWS WAF 6 pillars, design principles, best practices |
| **Confluence Space Index** | Index | [references/confluence-space-index.md](references/confluence-space-index.md) | Consolidated index of all key Confluence spaces, pages, and internal URLs |

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
| **Microsoft Azure — Resource Naming Rules** | [Azure Naming Rules](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) | Resource naming character limits and rules |
| **Amazon Web Services** | [AWS Documentation](https://docs.aws.amazon.com/) | Service documentation, instance types, pricing |
| **AWS — Architecture Center** | [AWS Architecture Center](https://aws.amazon.com/architecture/) | Reference architectures, design patterns, best practices by technology domain |
| **AWS — Prescriptive Guidance** | [AWS Prescriptive Guidance](https://docs.aws.amazon.com/prescriptive-guidance/latest/welcome.html) | Migration patterns, modernisation strategies, landing zone |
| **AWS — Well-Architected** | [AWS Well-Architected](https://aws.amazon.com/architecture/well-architected/) | Framework pillars, lens guidance, WAF Tool |
| **AWS — re:Post** | [AWS re:Post](https://repost.aws/) | Community Q&A; official AWS answers; curated knowledge base |
| **AWS — HIPAA Eligible Services** | [AWS HIPAA Eligible Services](https://aws.amazon.com/compliance/hipaa-eligible-services-reference/) | Services permitted to handle PHI under AWS BAA |
| **Broadcom / VMware (VCF 9)** | [VMware Docs](https://docs.vmware.com/) | vSphere, vSAN, VCF 9, NSX documentation; renewal Oct 2026 |
| **Terraform** | [Terraform Registry](https://registry.terraform.io/) | Provider docs, module registry, Terraform language reference |
| **Dynatrace** | [Dynatrace Docs](https://docs.dynatrace.com/) | OneAgent deployment, API reference, configuration |
| **Dynatrace SRE Docs** | [EMIS SRE Docs](https://engineering.emis-x.uk/docs/category/site-reliability/) | EMIS-specific SRE configuration, dashboards, and GitHub config repos |
| **ServiceNow** | [ServiceNow Docs](https://docs.servicenow.com/) | ITSM modules, CMDB schema, API reference |
| **CrowdStrike Falcon** | [CrowdStrike Docs](https://falcon.crowdstrike.com/documentation) | EDR/AV platform — deployment, policy management, API |
| **Tenable / tenable.io** | [Tenable Docs](https://docs.tenable.com/agent.htm) | Agent deployment, scan configuration, vulnerability management |
| **Delinea Secret Server** | [Delinea Docs](https://docs.delinea.com/) | PAM, Secret Server, SSH proxy (Pinnacle), SIEM forwarding |
| **Darktrace** | [Darktrace Docs](https://customerportal.darktrace.com/) | Network AI threat detection, appliance configuration |
| **Palo Alto Networks** | [Palo Alto Docs](https://docs.paloaltonetworks.com/) | Next-gen firewall, Panorama, network security |
| **Backstage** | [Backstage.io](https://backstage.io/) | IDP platform docs, plugin catalogue, Spotify open-source project |
| **CIS Benchmarks** | [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) | Hardening guides for OS, cloud, and network (membership required for full access) |
| **NIST Cybersecurity Framework** | [NIST CSF](https://www.nist.gov/cyberframework) | CSF v2.0, SP 800-53 controls, SP 800-161 (supply chain) |
| **HIPAA / HHS** | [HHS HIPAA](https://www.hhs.gov/hipaa/for-professionals/security/index.html) | HIPAA Security Rule text, guidance, breach notification requirements |
| **ISO 27001** | [ISO 27001](https://www.iso.org/standard/82875.html) | ISO/IEC 27001:2022 standard (purchase required for full text) |
| **OWASP** | [OWASP Top 10](https://owasp.org/www-project-top-ten/) | Top 10 application security risks; input validation, injection, auth defects |
| **NHS Digital — DCB Standards** | [NHS Digital Standards](https://digital.nhs.uk/data-and-information/information-standards/information-standards-and-data-collections-including-extractions/publications-and-notifications) | DCB0129 (clinical risk management product), DCB0160 (deployment) |
| **NHS DSP Toolkit** | [DSP Toolkit](https://www.dsptoolkit.nhs.uk/) | Data Security and Protection Toolkit — 10 standards for NHS suppliers |
| **HSCN (NHS)** | [HSCN Guidance](https://digital.nhs.uk/services/health-and-social-care-network) | Health and Social Care Network connectivity requirements and CoCo |
| **Sigstore / Cosign** | [Sigstore Docs](https://docs.sigstore.dev/) | Container image signing; supply chain security |
| **SLSA Framework** | [SLSA](https://slsa.dev/) | Supply-chain Levels for Software Artifacts — provenance and integrity |

### Architecture Review Board (ARB)

| Item | Detail |
|------|--------|
| **Purpose** | Review and approve significant architecture decisions, new technology introductions, and designs exceeding defined thresholds |
| **Escalation Criteria** | New technology, significant design departure, cost > £100k ARR, cross-team impact, security/compliance risk — see [ARB Guidance](..\decision-making\references\arb-guidance.md) |
| **Meeting Cadence** | [INTERNAL — populate: frequency and schedule] |
| **Submission Process** | See [ARB Guidance](..\decision-making\references\arb-guidance.md) for submission paper structure, required artefacts, and 5-day lead time |
| **Required Artefacts** | HLD, cost estimate, security review, risk assessment, options analysis |
| **Membership** | [INTERNAL — populate: ARB member roles] |
| **Decision Record** | Recorded in Confluence Architecture space as ADRs; update ADR status post-ARB |

## Source Priority

When information conflicts between sources, use this priority order:

1. **EMIS/Optum internal standards** (Confluence Architecture space) — always takes precedence
2. **Regulatory requirements** (HIPAA, UK Data Protection Act 2018, GDPR) — legal compliance is non-negotiable
3. **NHS clinical standards** (DCB0129, DCB0160, DSP Toolkit) — mandatory for any system connecting to HSCN or handling NHS patient data
4. **Industry security frameworks** (NIST, CIS Level 2, ISO 27001, Cyber Essentials Plus) — applied as interpreted by internal standards
5. **Vendor best practices** (Azure Architecture Center, AWS Well-Architected) — generally followed unless conflicting with internal standards
6. **Community best practices** (blog posts, Stack Overflow, etc.) — verify against official documentation before citing; never sole reference for compliance claims

## Source Freshness

Sources degrade over time. Apply the following freshness checks before citing:

| Source Type | Freshness Check | Action if Stale |
|-------------|----------------|----------------|
| Internal standards (Confluence) | Check page last-modified date; > 12 months without review — flag | Contact document owner; do not cite as current until reviewed |
| Vendor documentation | Check version/release date; ensure it matches the version in use | Link to version-specific docs where available (e.g., Terraform provider version) |
| Regulatory/compliance text | Check for amendments; HIPAA Security Rule last updated 2013 but HHS issues sub-regulatory guidance regularly | Cross-check with HHS website; consult CISO if uncertain |
| Architecture Decision Records | Check ADR status (Proposed/Accepted/Deprecated/Superseded); deprecated ADRs must not be cited as current | Reference the superseding ADR; update design documentation |
| Vendor pricing | Pricing changes frequently; pricing data older than 6 months should be refreshed from calculator | Re-export from Azure/AWS pricing calculator before submitting any formal cost estimate |
| Previous HLD/LLD | Check if the referenced design is still in service and unchanged | Validate against CMDB/Dynatrace topology before citing as reference architecture |

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

## References

| Reference File | Purpose |
|----------------|---------|
| [references/knowledge-base-tracker.md](references/knowledge-base-tracker.md) | Architecture knowledge gaps, regional coverage, vendor relationships, DC exit tracking |
| [references/naming-tagging-policy.md](references/naming-tagging-policy.md) | Cloud resource naming conventions for AWS and Azure; mandatory tagging standard |
| [references/security-architecture.md](references/security-architecture.md) | EMIS/Optum Security by Design principles, Zero Trust requirements, mandatory controls |
| [references/well-architected-framework.md](references/well-architected-framework.md) | AWS Well-Architected Framework — 6 pillars, EMIS adoption context, design principles |
| [references/confluence-space-index.md](references/confluence-space-index.md) | Master consolidated index of all key Confluence spaces, key pages, and internal tool URLs |
