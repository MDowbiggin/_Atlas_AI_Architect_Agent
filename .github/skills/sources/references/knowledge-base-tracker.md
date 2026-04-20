# Infrastructure Architecture — Knowledge Base Tracker

> **Source**: Confluence — Architecture Space
> **Classification**: Internal

## Introduction

This document tracks knowledge gaps, next steps, and progress around Optum-based services, solutions, and 3rd-party vendors which Infrastructure Architects are responsible for. Each owner tracks progress until each line is completed.

---

## Architecture Areas / Knowledge Base

| Knowledge Area | Category | Description | Action Plan | Owner(s) | Status |
|---------------|----------|-------------|-------------|----------|--------|
| **Gibraltar** | VMware | VCF configuration; Licensing model & portal; Documentation gaps of clinical solutions; Gibraltar contacts (Technical); Hardware order tracking (Softcat) | Delegation of VCF build to Platforms; Ensure Platforms have relevant documentation; IAs to have understanding of licensing model & portal | Joseph Pemberton, Dave Nelson | Agreement to move forward with VCF 9. VMware offered further deep-dives and use of VCF 9 lab environment. |
| **Gibraltar** | Monitoring | SCOM retirement roadmap; Assume Dynatrace & Datadog (SQL) will be the replacement | Document and agree monitoring solution | Joseph Pemberton, Dave Nelson | Dave Nelson to pick up the monitoring piece. |
| **Gibraltar** | Connectivity | Documentation around link deployment | Document and agree Gibraltar link solution | Matt Oddy | — |
| **Jersey** | Links / HSCN connectivity, Egress exit, O365 / CoreView, Jersey API/MPLS, Automated Arrivals | Documentation gaps of clinical solutions in Jersey; Jersey contacts (Technical); O365 documentation / Architectural overview; Jersey MPLS documentation / Architectural overview and contact handover; Arrivals hosting in Leeds DC | IAs to have understanding & relevant documentation covering each category | Joseph Pemberton, Mark Dowbiggin | COMPLETED — Initial meeting held. IN PROGRESS — David Gee to document and provide account contacts for CoreView/Egress. VMware stack includes 1x Spoke VM & 1x ADDC VM per site, replicating to a pair of ADDCs within a Jersey-based datacentre. Jersey uses a single O365 tenant — all practices are children of this single tenant. |
| **Wales** | VMware | vSAN configuration; Licensing model & portal; Documentation gaps of clinical solutions; Wales contacts (Technical); Knowledge around VMware cluster downsizing post strategic migration (Symphony remains on-premise, estimated to reduce to 6x nodes per site); EXA Activation (Addition of RS Nodes) | IAs to have understanding of licensing model & portal; Ensure Platforms have relevant documentation; Option to exit DHCW datacentres via lift & shift to GVCE | Richard Davies, Mark Dowbiggin, Dave Nelson | COMPLETE — Initial meeting held. IN PROGRESS — David Gee to provide VMware portal login/link for licensing and support; HLD links for the on-premise VMware stack. |
| **Wales** | WEDS (Symphony) | Commercial end date of the product — due to cease September 2026; Potentially Swansea Bay (SBU) DC or another system supplier; James Heels is the commercial lead; Julian Simpson & Richard Henderson are the technical contacts | Arrange meeting to facilitate knowledge transfer; Document the solution in Confluence | Dave Nelson, Muneeb Hanif | Meeting held — docs shared, Muneeb to review and feedback. |
| **Scotland** | PCS, SWAN, CCMH | General knowledge transfer | Arrange meeting to facilitate knowledge transfer; Document the solution in Confluence | Joseph Pemberton, Muneeb Hanif | — |
| **Northern Ireland** | EMISWeb, CCMH, HSCN, Future site migrations / VDI | General knowledge transfer | Arrange meeting to facilitate knowledge transfer; Document the solution in Confluence | Joseph Pemberton, Muneeb Hanif | — |
| **IoM** | EMISWeb, CCMH, IQ Extracts | Documented in Confluence under the Brisbane Nations area and the Requirements section; HSCN connectivity via standard England HSCN connection via Redcentric >> AWS DX links >> AWS Nations | Already in Nations — quick knowledge check for missing detail | Richard Davies, Mark Dowbiggin | COMPLETE — Meeting held to discuss IoM. All areas covered. |
| **Guernsey** | EMISWeb | Single EMISWeb PD hosted in AWS Nations into dedicated VPC; Island in discussions to purchase their own AWS DX links | Solution discovery session planned | Mark Dowbiggin, Matt Oddy | IN PROGRESS — Discovery overview meeting with TK planned. |
| **Procurement** | Insight, Softcat | Document any external contacts; Link process documentation | Obtain list of contacts for both suppliers; Save links to documentation | Andy Bodley | IN PROGRESS — 2-weekly call setup till end of July. |
| **Vendor Relationships** | HPe, VMware / Broadcom, Microsoft / Azure, AWS, COLT, Redcentric | Obtain list of key contacts for each vendor | Introductions to each vendor | Andy Bodley | IN PROGRESS — 2-weekly call setup till end of July. |
| **Optum** | ODI, Equinix | General knowledge transfer | — | Dave Nelson, Muneeb Hanif | Initial kick-off meeting with Colm & team yet to take place. |
| **Reading** | Community Pharmacy DC Exit | — | Meeting to plan with David Gee to discuss DC exit | Dave Nelson, Muneeb Hanif | — |
| **Watford** | Community Pharmacy DC Exit, eVPN links | — | Meeting to plan with David Gee to discuss DC exit | Dave Nelson, Muneeb Hanif | — |
| **IOMart** | Pinnacle DC Exit | IaaS environment for PharmOutcomes | — | Richard Davies | — |
| **Doncaster** | VMware | Symphony Managed Service | Dave Nelson to document service | Dave Nelson, Muneeb Hanif | Docs shared, Muneeb to review and feedback. |
| **Acute Dev\Test** | AWS, VPC | — | — | Dave Nelson, Muneeb Hanif | Docs shared, Muneeb to review and feedback. |
| **Berkshire** | Hosted ePMA | — | — | Dave Nelson, Richard Davies | — |
| **Rising Sun** | Decommissioning | — | David Gee to work with Platforms/DC team | David Gee, Dave Nelson | — |
| **Dave Gee Contacts** | Technical Contact list | — | — | Andy Bodley | IN PROGRESS — 2-weekly call setup till end of July. |

---

## Next Steps & Decisions

- Joseph Pemberton / Dave Nelson — Initial conversation/meeting with David Gee regarding Gibraltar knowledge areas
- Confluence tracking page: [Infrastructure Architecture Knowledge Base Tracker](https://emishealthgroup.atlassian.net/wiki/spaces/ARCH/pages/7881818337)
