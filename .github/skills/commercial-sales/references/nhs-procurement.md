# NHS Procurement Frameworks

## Overview

EMIS/Optum sells and supplies technology solutions to NHS and public sector health organisations across England, Scotland, Wales, and the Crown Dependencies. Commercial bids to NHS customers must comply with the applicable procurement framework. This reference covers the primary NHS and public sector frameworks used to procure infrastructure and technology services.

> **Key principle**: NHS and public sector organisations are bound by public procurement regulations. They cannot simply purchase from a preferred supplier outside a compliant procurement route without running the risk of challenge. Architecture must confirm the procurement framework before committing significant commercial effort to a bid.

---

## Primary NHS Procurement Frameworks

### 1. G-Cloud (Crown Commercial Service)

**What it is**: A framework agreement operated by the Crown Commercial Service (CCS) that allows public sector buyers to procure cloud technology services without running a full OJEU/PCR procurement. Services are listed on the [Digital Marketplace](https://www.digitalmarketplace.service.gov.uk/).

| Item | Detail |
|------|--------|
| **Operated by** | Crown Commercial Service (CCS) |
| **Framework** | RM1557 (current iteration — confirm current lot number) |
| **Lots** | Lot 1: Cloud Hosting; Lot 2: Cloud Software (SaaS); Lot 3: Cloud Support |
| **Buyer** | Any UK public sector organisation (NHS trusts, ICBs, NHSE, local authorities) |
| **Call-off** | Direct award (no further competition required if requirements can be mapped to a listed service) or further competition between listed suppliers |
| **Max value** | No ceiling on individual call-offs, but proportionality guidance applies |

**When EMIS/Optum bids via G-Cloud**:
- Solution and pricing must be listed on the Digital Marketplace under the applicable lot
- Pricing on the Marketplace is the ceiling — cannot charge more than the listed rate
- Scope must match what is listed; significant variations require a new listing or alternative framework
- Document the G-Cloud framework reference and lot number in the commercial proposal

**Architecture implications**:
- Infrastructure services sold via G-Cloud Lot 1 must meet GDS (Government Digital Service) service standards where applicable
- Cloud hosting solutions must demonstrate data residency within the UK (Lot 1 requirement for most NHS buyers)
- Security accreditation evidence (ISO 27001, Cyber Essentials Plus, DSPTK) must be current and available to buyers on request

---

### 2. Digital Outcomes and Specialists (DOS / DOS+)

**What it is**: A framework for procuring specialist digital outcomes, resources, and research and testing. Buyers post a requirement and suppliers apply to be shortlisted, then a mini-competition or assessment determines the winner.

| Item | Detail |
|------|--------|
| **Operated by** | Crown Commercial Service (CCS) / CDDO |
| **Framework** | DOS6 / DOS+ (confirm current iteration) |
| **Outcomes** | Digital outcomes (e.g., build a service, design a solution) |
| **Resources** | Individual contractors (architects, engineers, project managers) |
| **Research and Testing** | User research, usability testing |
| **Buyer** | Public sector organisations |
| **Process** | Apply to opportunity → shortlist → written proposal → presentation/demonstration → score and award |

**When EMIS/Optum bids via DOS**:
- Must be a registered DOS supplier in the applicable lot
- Responses are evaluated on technical approach, team capability, and price
- Infrastructure architecture outputs (HLD, solution design) may be required as part of the bid artefact
- Timeline is typically 4-8 weeks from opportunity to award

**Architecture implications**:
- Infrastructure architects may be named as key delivery personnel; CVs and evidence of capability required
- Technical approaches must be solution-agnostic in the proposal stage unless the buyer has pre-specified a platform
- Cloud architecture for NHS outcomes work must reference NHS Technology Standards and NHS Digital API standards

---

### 3. NHS Shared Business Services (NHS SBS) Frameworks

**What it is**: NHS SBS operates procurement frameworks specifically for NHS organisations, covering IT and digital services.

| Framework | Scope |
|-----------|-------|
| **IT Solutions** | Hardware, software, and IT services |
| **Digital Transformation** | Digital consultancy and delivery |
| **Managed Services** | Infrastructure managed services |

**When relevant**: For NHS trusts and ICBs that prefer to procure through NHS SBS rather than CCS. Confirm with the buyer which route they intend to use before committing to a bid structure.

---

### 4. Crown Commercial Service (CCS) — Technology Products & Services (TPS)

**What it is**: CCS manages a portfolio of technology frameworks covering hardware, software, and technology services for central government and public sector. Relevant for EMIS/Optum when selling to government-adjacent health bodies.

| Framework | Scope | Notes |
|-----------|-------|-------|
| **Technology Products 3 (TP3)** | Hardware and software products | Largely replaced by newer frameworks |
| **Network Services 3 (NS3)** | Connectivity, WAN, SD-WAN | Relevant for HSCN connectivity services |
| **Cyber Security Services 4 (CSS4)** | Managed security services | Relevant for security consultancy and tooling |

---

### 5. NHS England Direct Procurement

For contracts with NHS England (NHSE) or NHS Transformation Directorate directly, procurement may be conducted outside a framework through:
- **Open tender** (OJEU/Find a Tender above threshold)
- **Negotiated procedure** (for genuinely unique or innovative solutions)
- **Competitive dialogue** (for highly complex contracts)

**Thresholds (approximate, subject to PCR 2015 / Procurement Act 2023)**:
- Services above ~£213,000 require full public procurement process
- Services below threshold may use simplified processes (3-quote minimum for most routes)

> Check current thresholds with the Procurement team — the Procurement Act 2023 (effective February 2025) changed some thresholds and procedures.

---

## Bid Qualification Checklist for NHS Opportunities

Before committing commercial and architecture effort to an NHS bid:

- [ ] **Framework confirmed** — Which framework is the buyer using? G-Cloud, DOS, SBS, direct tender?
- [ ] **EMIS/Optum is listed on the framework** — Confirm with Procurement that we are an approved supplier on the relevant lot
- [ ] **Scope maps to listed services** — For G-Cloud, confirm the bid scope matches what is listed on the Digital Marketplace
- [ ] **Data residency confirmed** — NHS buyers require UK data residency for patient-identifiable data; confirm AWS `eu-west-2` / Azure UK South primary hosting
- [ ] **Security accreditations current** — ISO 27001, Cyber Essentials Plus, DSPTK satisfactory status — confirm with InfoSec (David Gee, Abbie Bowes)
- [ ] **HSCN/Spine connectivity** — If the solution requires HSCN access, confirm CoCo is in place or can be obtained; involve Dave Nelson (Network Operations)
- [ ] **Clinical safety** — If the solution is a clinical system, DCB0129 review must be in progress; confirm with CSO
- [ ] **Commercial team engaged** — Commercial/Procurement team must validate the pricing approach and contract terms before submission
- [ ] **ARB required?** — If the solution cost exceeds £100k ARR or introduces new technology, confirm whether ARB sign-off is needed before bid submission
- [ ] **Submission timeline** — Confirm deadline; allow 3 days buffer for internal review before submission

---

## NHS-Specific Requirements in Bid Responses

### Security & Compliance Evidence

NHS buyers will typically ask for:
- Current **ISO 27001 certificate** — provide certificate reference and expiry date
- **Cyber Essentials Plus certificate** — provide certificate reference, scope, and expiry date
- **NHS DSPTK Toolkit status** — provide latest assessment status and score
- **Pen test results** — confirm frequency and last test date (do not include raw pen test results; provide executive summary or attestation)
- **Data Protection Agreement** — DPA aligned with UK GDPR / NHS standard clauses

### Data Sovereignty Statement

Standard statement for NHS bids:

> "All patient-identifiable data (PHI) will be stored and processed within the United Kingdom, using AWS EU (London) `eu-west-2` as the primary region and AWS EU (Ireland) `eu-west-1` for disaster recovery replication only. No PHI will be stored, processed, or accessible from outside the UK without explicit written consent from the Data Controller. Data residency is enforced through AWS region restrictions applied via Service Control Policies (SCPs) at the AWS Organizations level."

Adjust for Azure UK South / UK West equivalent as appropriate.

### NHS API & Interoperability Statement

For clinical solutions:

> "This solution implements HL7 FHIR R4 in compliance with NHS England API standards. All clinical data exchange uses the NHS API Management (APIM) platform with OAuth 2.0 / NHS Login authentication. Integration with NHS Spine services (PDS, EPS, GP Connect) uses the NHS-approved Spine Security Proxy (SSP) and Message Exchange for Social Care and Health (MESH) where applicable."

---

## Pricing in NHS Bids

- **G-Cloud**: Pricing is posted publicly on the Digital Marketplace; be cautious about commercially sensitive detail
- **DOS**: Pricing typically submitted as day rates per role; infrastructure costs as a separate BoM
- **Direct tender**: Full BoM and assumptions document required; confidential; submitted as part of the bid
- **Price escalation**: For multi-year contracts, NHS buyers expect a price escalation mechanism (typically linked to CPI or agreed annual uplift %)
- **Payment terms**: NHS standard is 30-day payment terms post invoice; confirm deviations with Procurement

---

## Useful Links

| Resource | Link |
|----------|------|
| Digital Marketplace (G-Cloud / DOS) | https://www.digitalmarketplace.service.gov.uk/ |
| Crown Commercial Service | https://www.crowncommercial.gov.uk/ |
| NHS Shared Business Services | https://www.sbs.nhs.uk/ |
| Find a Tender Service | https://www.find-tender.service.gov.uk/ |
| Procurement Act 2023 Guidance | https://www.gov.uk/government/collections/procurement-act-2023-transforming-public-procurement |
| NHS DSPTK | https://www.dsptoolkit.nhs.uk/ |
| Cyber Essentials Plus (NCSC) | https://www.ncsc.gov.uk/cyberessentials/overview |

---

## References

- [RFP & Bid Guidance](./rfp-bid-guidance.md) — Bid structure and review checklist
- [NHS & Clinical Compliance](../../architecture/references/nhs-clinical-compliance.md) — DCB0129/0160, DSPTK, HSCN, FHIR requirements
- [Vendor Management](./vendor-management.md) — Framework supplier registrations and commercial relationships
