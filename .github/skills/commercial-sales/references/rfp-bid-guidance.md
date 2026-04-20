# RFP & Bid Guidance

## Overview

When EMIS/Optum responds to RFPs (Request for Proposal) or prepares commercial bids, infrastructure architects provide the technical solution design and cost estimates. This guide covers how to structure the infrastructure section of an RFP response.

## RFP Response Structure (Infrastructure Section)

### 1. Executive Summary

- Brief overview of the proposed infrastructure solution
- Key differentiators and value propositions
- Alignment with the client's stated requirements
- High-level cost indication

### 2. Understanding of Requirements

- Restate the client's requirements in your own words
- Highlight any assumptions or clarifications needed
- Map requirements to proposed solution components

### 3. Proposed Solution Architecture

- Architecture overview with diagrams (C4 Context and Container level minimum)
- Technology stack selection with justification
- Platform: Azure / AWS / Hybrid with reasoning
- Compute, storage, networking, security design
- Integration points and data flows
- Disaster recovery and business continuity approach

### 4. Non-Functional Requirements Compliance

| NFR | Requirement | Proposed Solution | Compliance |
|-----|------------|-------------------|------------|
| Availability | [From RFP] | [Your design] | ✅ / ⚠️ / ❌ |
| Performance | [From RFP] | [Your design] | ✅ / ⚠️ / ❌ |
| Scalability | [From RFP] | [Your design] | ✅ / ⚠️ / ❌ |
| Security | [From RFP] | [Your design] | ✅ / ⚠️ / ❌ |
| DR/BCP | [From RFP] | [Your design] | ✅ / ⚠️ / ❌ |
| Compliance | [From RFP] | [Your design] | ✅ / ⚠️ / ❌ |

### 5. Security & Compliance

- Security architecture (IAM, network security, encryption, monitoring)
- Compliance certifications held (ISO 27001, HIPAA, etc.)
- Shared responsibility model explanation
- Data sovereignty and residency

### 6. Operations & Support

- Operational model (PIMS, CloudOps, on-call)
- Monitoring and alerting approach (Dynatrace)
- Patching and maintenance schedule
- Incident management process (ServiceNow)
- SLA commitments

### 7. Implementation Plan

- Phased delivery approach
- Key milestones and timeline
- Dependencies and risks
- Team and resource requirements
- Testing and acceptance criteria

### 8. Commercial Proposal

- Detailed BoM (see [BoM Templates](./bom-templates.md))
- Pricing options (PAYG, reserved, committed spend)
- Implementation costs (one-off)
- Ongoing operational costs (recurring)
- Payment terms and schedule
- Assumptions and exclusions

### 9. Risk Register

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | H/M/L | H/M/L | [Mitigation strategy] |

### 10. Appendices

- Detailed architecture diagrams
- Compliance certifications
- Team CVs/experience
- Case studies of similar implementations
- Glossary of terms

## Bid Review Checklist

Before submitting:

- [ ] All RFP requirements addressed and mapped
- [ ] Solution architecture reviewed by senior architect
- [ ] Security baseline compliance confirmed
- [ ] Cost estimate validated (cross-checked with pricing calculator)
- [ ] Commercial terms reviewed by commercial/legal team
- [ ] Risk register complete
- [ ] Diagrams clear and professional
- [ ] Executive summary compelling and differentiated
- [ ] Document formatted per EMIS/Optum brand guidelines
- [ ] Submission deadline confirmed; allow buffer for final review

## Common RFP Pitfalls

- **Over-engineering**: Proposing a more complex solution than required; increases cost and risk
- **Under-specifying DR**: Not adequately addressing disaster recovery and business continuity
- **Ignoring NFRs**: Focusing on functional requirements and neglecting performance, security, scalability
- **Unrealistic timelines**: Committing to delivery dates without considering dependencies and resource availability
- **Hidden costs**: Omitting data egress, licensing, operational overhead, or migration effort
- **Generic responses**: Not tailoring the response to the specific client's context and industry
