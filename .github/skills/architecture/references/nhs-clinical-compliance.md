# NHS & Clinical Compliance

## Overview

EMIS/Optum operates as a supplier to the NHS and handles patient-identifiable clinical data. In addition to HIPAA, ISO 27001, and NIST covered by the security-compliance skill, all clinical and NHS-connected systems must comply with the UK-specific standards in this reference.

> **Scope**: This reference applies to any system that: (a) connects to NHS infrastructure (Spine, HSCN, NHS login, GP Connect, etc.); (b) processes, stores, or transmits clinical data; or (c) is classified as a medical device under UK MDR 2002/MHRA guidance.

---

## Applicable Standards

| Standard | Scope | Owner | Frequency |
|----------|-------|-------|-----------|
| **DCB0129** | Clinical risk management for health IT manufacturers | Manufacturers of clinical software/infrastructure | Each release |
| **DCB0160** | Clinical risk management for health IT deployers | NHS organisations deploying health IT | Each deployment |
| **NHS DSP Toolkit** | Data Security and Protection requirements for NHS suppliers | All suppliers handling NHS patient data | Annual self-assessment |
| **Cyber Essentials Plus** | Technical security hygiene for NHS-connected systems | Required for NHS Digital connections | Annual renewal (NCSC) |
| **HSCN Code of Connection (CoCo)** | Permitted use and security requirements for HSCN network | All HSCN-connected organisations | Reviewed on connection / material change |
| **NHS API (FHIR) Standards** | HL7 FHIR R4 for clinical data exchange; NHS API Management | Clinical systems exchanging patient data via NHS APIs | As specified by NHS England API programme |

---

## DCB0129 — Clinical Risk Management for Manufacturers

DCB0129 applies to EMIS as a manufacturer of Health IT systems. Architecture changes to clinical systems must be assessed for clinical safety impact.

### When Architecture Must Trigger DCB0129

- Introducing a new clinical system or module
- Making a **clinically significant change** to an existing system (changes that affect data displayed to clinicians, dosing calculations, clinical decision support, patient-matching logic, etc.)
- Infrastructure changes that could affect system availability or data integrity for clinical workloads
- Integration changes that alter the flow of clinical data (new FHIR endpoints, Spine integrations, etc.)

### Architecture Responsibilities

| Activity | Responsibility |
|----------|---------------|
| Produce a **Hazard Log** for the change | Clinical Safety Officer (CSO) — initiated by Architecture when a significant change is proposed |
| Complete **Clinical Safety Case Report** | CSO with input from Architecture and Engineering |
| Review infrastructure design against clinical hazards | Architecture — document in HLD whether the infrastructure change has clinical safety implications |
| Sign off the Clinical Safety Case | CSO and Medical Director |

> **Action for Atlas_Architect**: When designing infrastructure for a clinical system, flag in the HLD whether the change is clinically significant and whether DCB0129 review has been initiated. Do not wait for the CSO to initiate — proactively raise this with the product owner.

### Key Hazard Categories (Infrastructure-Relevant)

| Hazard Category | Example Infrastructure Scenario |
|----------------|--------------------------------|
| **Unavailability of clinical data** | Unplanned downtime, missed RTO target, DR failover failure |
| **Data corruption** | Database failover resulting in write inconsistency, replication lag masking |
| **Incorrect data displayed** | Caching issues, CDN serving stale clinical content |
| **Unauthorised access** | IAM misconfiguration exposing patient records, public storage endpoint |
| **Loss of audit trail** | Logging failure, log retention gap |

---

## DCB0160 — Clinical Risk Management for Deployers

DCB0160 applies where EMIS's systems are deployed into NHS organisations as a clinical system. Less directly applicable to platform infrastructure design but relevant where:

- EMIS is deploying NHS-hosted infrastructure
- Infrastructure changes at the NHS trust or ICB level are required to support an EMIS deployment

> For NHS-hosted deployments, confirm whether the deploying NHS organisation has completed their DCB0160 clinical risk assessment and document the outcome in the project record.

---

## NHS Data Security and Protection (DSP) Toolkit

The DSP Toolkit is the annual self-assessment that demonstrates compliance with the National Data Guardian's 10 data security standards. EMIS must maintain a satisfactory assessment to retain NHS Digital contracts.

### Architecture-Relevant DSP Standards

| DSP Standard | Architecture Implication |
|-------------|--------------------------|
| **Standard 1**: Personal confidential data | PHI must be handled lawfully; minimum necessary access; data flows documented |
| **Standard 2**: Staff responsibilities | Access controls; MFA; training records accessible |
| **Standard 3**: Training | Systems must support audit of access by trained-only staff |
| **Standard 4**: Managing data access | RBAC, PIM, quarterly access reviews, removal of leavers — infrastructure must support these controls |
| **Standard 5**: Process reviews | DR tested annually; incident response tested; processes reviewed |
| **Standard 6**: Cybersecurity | Cyber Essentials Plus maintained; patching within defined timelines; EDR deployed |
| **Standard 7**: IG toolkit | Data flows registered; DPIA completed for new processing |
| **Standard 8**: Unsupported systems | No end-of-support OS/software in scope for NHS data processing |
| **Standard 9**: IT protection | Encryption at rest and in transit; remote wipe; device protection |
| **Standard 10**: Accountable suppliers | Third-party suppliers assessed; contracts include data protection clauses |

### DSP Design Checklist

- [ ] Data flows for the system documented in the DSP Toolkit record
- [ ] DPIA (Data Protection Impact Assessment) completed where required (NHS data above low risk)
- [ ] No end-of-support OS or middleware used in NHS-connected components
- [ ] MFA enforced for all access to systems handling NHS patient data
- [ ] Encryption at rest (AES-256) and in transit (TLS 1.2+) implemented
- [ ] RBAC and quarterly access reviews automated or scheduled
- [ ] NHS-specific audit logs retained for minimum 6 years (aligns with HIPAA)
- [ ] Incident response procedure includes NHS Data Security Centre notification — report serious incidents within 72 hours

---

## Cyber Essentials Plus

Cyber Essentials Plus is an NCSC-certified scheme required for NHS Digital connections. It covers five technical controls:

| Control | Architecture Requirement |
|---------|--------------------------|
| **Firewalls** | Boundary firewalls with deny-all default; only necessary ports open; NAT used for outbound; NSG/Security Group equivalent for cloud workloads |
| **Secure Configuration** | CIS Level 2 hardening applied; default passwords changed; unnecessary services disabled (see security-compliance skill) |
| **User Access Control** | Least-privilege RBAC; MFA enforced; admin accounts separated from user accounts; no shared credentials |
| **Malware Protection** | CrowdStrike EDR deployed on all endpoints and servers in scope; real-time scanning enabled |
| **Patch Management** | All critical patches applied within 14 days; high severity within 30 days; OS must be in-support (no EOL software) |

> **Renewal**: Cyber Essentials Plus must be renewed annually. Infrastructure changes that affect the in-scope boundary (adding new internet-facing services, new on-prem hosts, new cloud subscriptions) must be assessed for impact on the current certificate and the renewal scope.

---

## HSCN (Health and Social Care Network)

HSCN is the secure network connecting NHS and health/social care organisations. Access requires a Code of Connection (CoCo) agreement.

### Architecture Requirements for HSCN-Connected Systems

- [ ] **HSCN CoCo in place** — Confirm with Network Operations (Dave Nelson) that a valid CoCo is registered for the applicable organisation
- [ ] **No PHI traverses public internet** — All clinical data exchange must route via HSCN or N3/HSCN-equivalent encrypted private link; confirm with network design
- [ ] **Firewall rules restrict HSCN traffic** — Only permitted clinical application ports (443, SMSP, HL7) open; deny-all default; inbound HSCN traffic inspected at perimeter
- [ ] **Spine connectivity** — If connecting to NHS Spine (PDS, EPS, SCR, GP Connect), use the NHS Digital-approved Spine Security Proxy (SSP) or direct Spine connection per current NHS England API standards
- [ ] **DNS resolution for HSCN** — On-prem: HSCN DNS forwarders configured via Network Operations; AWS/Azure: HSCN DNS resolver forwarded via Direct Connect / ExpressRoute — confirm hybrid DNS design supports name resolution for `hscn.nhs.uk` domains
- [ ] **IP address management** — HSCN-connected services must use HSCN-registered IP ranges; advise network team of any new subnets before provisioning

---

## NHS FHIR API Standards

All clinical data exchange for NHS-connected systems must use HL7 FHIR R4 (or the NHS profile thereof). Architecture must ensure:

| Requirement | Detail |
|------------|--------|
| **FHIR R4** | New integrations must implement FHIR R4 (not STU3 or DSTU2); confirm with product owner if legacy STU3 exists and plan upgrade |
| **NHS England API Management** | Access to NHS national APIs (PDS, EPS, EMIS Web Public APIs) via NHS England API Management (APIM) platform; OAuth 2.0 / NHS login authentication |
| **Spine Integration** | HL7 v2/v3 or FHIR messaging via NHS Spine using NHS Messaging Spec and MHS adapter; confirmed with Digital Interoperability team |
| **API Gateway** | NHS-facing APIs should sit behind Azure API Management or AWS API Gateway with rate limiting, JWT validation, and logging |
| **Data Minimisation** | FHIR resources must only include the minimum necessary patient data; no unnecessary PHI in API responses |
| **Consent** | Patient consent for data sharing must be honoured in API design; confirm with product owner and information governance |

---

## Clinical System Architecture Checklist

Use this when reviewing infrastructure designs for clinical or NHS-connected systems:

### Clinical Safety (DCB0129)
- [ ] Confirmed with product owner whether change is clinically significant
- [ ] If clinically significant: DCB0129 review initiated with CSO
- [ ] Infrastructure-level hazards assessed against hazard categories above
- [ ] Clinical Safety Case reference number recorded in HLD

### Data Security (DSP Toolkit)
- [ ] Data flows for new/modified processing documented
- [ ] DPIA status confirmed
- [ ] No EOL OS or middleware in NHS data processing path
- [ ] Audit log retention set to 6 years for NHS patient data

### Connectivity & Network
- [ ] HSCN CoCo confirmed current and covers new scope
- [ ] No PHI traverses public internet without explicit NHS approval
- [ ] HSCN DNS resolution confirmed with Network Operations
- [ ] Spine/FHIR connectivity reviewed with Digital Interoperability team

### Security Accreditation
- [ ] Cyber Essentials Plus scope assessed for impact of this change
- [ ] New internet-facing services notified to InfoSec for CE+ scope update
- [ ] CrowdStrike EDR deployed on all in-scope hosts

---

## Key Contacts

| Area | Contact |
|------|---------|
| Clinical Safety Officer (DCB0129/0160) | [INTERNAL — confirm with programme] |
| Information Governance / DPO | [INTERNAL — confirm with programme] |
| NHS Digital Interoperability | [INTERNAL — confirm with programme] |
| HSCN / Network Connectivity | Dave Nelson (Network Operations) |
| Cyber Essentials Plus / DSP Toolkit | David Gee, Abbie Bowes (ESRO) |

---

## References

- [NHS DCB0129 Standard](https://digital.nhs.uk/data-and-information/information-standards/information-standards-and-data-collections-including-extractions/publications-and-notifications/standards-and-collections/dcb0129-clinical-risk-management-its-application-in-the-manufacture-of-health-it-systems)
- [NHS DCB0160 Standard](https://digital.nhs.uk/data-and-information/information-standards/information-standards-and-data-collections-including-extractions/publications-and-notifications/standards-and-collections/dcb0160-clinical-risk-management-its-application-in-the-deployment-and-use-of-health-it-systems)
- [NHS DSP Toolkit](https://www.dsptoolkit.nhs.uk/)
- [Cyber Essentials Plus (NCSC)](https://www.ncsc.gov.uk/cyberessentials/overview)
- [HSCN Code of Connection](https://digital.nhs.uk/services/health-and-social-care-network/hscn-technical-guidance/hscn-code-of-connection)
- [NHS England FHIR API Standards](https://digital.nhs.uk/developer/api-catalogue)
