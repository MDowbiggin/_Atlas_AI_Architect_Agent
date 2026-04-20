---
name: pims
description: "Platforms Infrastructure Managed Services (PIMS) operating model and cross-team coordination. Use when: designing for operational handover, understanding PIMS service catalogue, coordinating with CloudOps/Security/Engineering/Operations teams, defining SLAs/OLAs, planning BAU transitions, or understanding the PIMS team structure."
---

# Platforms Infrastructure Managed Services (PIMS)

## When to Use

- Designing a solution that will be operated and maintained by PIMS
- Planning the handover from project delivery to BAU operations
- Understanding the service catalogue and what PIMS supports
- Defining Service Level Agreements (SLAs) or Operational Level Agreements (OLAs)
- Coordinating with CloudOps, Security, Engineering, or Operations teams
- Assessing operational readiness for a new or modified service

## PIMS Overview

Platforms Infrastructure Managed Services (PIMS) is the operational function responsible for running, monitoring, maintaining, and supporting EMIS/Optum's infrastructure estate across Azure, AWS, on-premises, and hybrid environments.

### PIMS Mission

To deliver reliable, secure, and cost-effective infrastructure services that enable EMIS/Optum's products and business operations.

### PIMS Scope

| In Scope | Out of Scope |
|----------|-------------|
| Server (VM) management and patching | Application code deployment (Engineering) |
| Cloud platform operations (Azure, AWS) | Application-level debugging (Engineering) |
| Network infrastructure operations | Business application support (App Support teams) |
| Storage and backup management | End-user device management (EUC/Desktop) |
| Monitoring and alerting (Dynatrace, Azure Monitor) | Physical data centre management (Facilities partner) |
| Security infrastructure operations (firewalls, WAF) | Security policy and governance (InfoSec team) |
| Database infrastructure (not application DBA) | Database schema changes (Engineering/DBA) |
| IaC pipeline operations | IaC module development (Architecture/Engineering) |

## Team Structure

| Team | Responsibility | Key Contacts |
|------|---------------|-------------|
| **CloudOps** | Azure and AWS platform operations, resource management, cost monitoring | [INTERNAL — populate] |
| **Infrastructure Engineering** | IaC development, automation, tooling, pipeline management | [INTERNAL — populate] |
| **Network Operations** | Network infrastructure, firewalls, load balancers, DNS, VPN/ExpressRoute | [INTERNAL — populate] |
| **Security Operations** | Security tooling, SIEM, vulnerability management, incident response support | [INTERNAL — populate] |
| **Database Operations** | Database platform management, backups, performance, HA/DR | [INTERNAL — populate] |
| **Monitoring & Observability** | Dynatrace administration, dashboard management, synthetic monitoring | [INTERNAL — populate] |
| **Service Management** | ServiceNow administration, CMDB management, process governance | [INTERNAL — populate] |

## Service Catalogue

### Compute Services

| Service | Description | SLA | Support Hours |
|---------|-------------|-----|--------------|
| Azure VM Management | Provisioning, patching, monitoring, backup | 99.9% (zone-redundant) | 24/7 (production) |
| AWS EC2 Management | Provisioning, patching, monitoring, backup | 99.9% (multi-AZ) | 24/7 (production) |
| VMware VM Management | Provisioning, patching, monitoring, backup | 99.9% (HA cluster) | 24/7 (production) |
| AKS Cluster Management | Platform management, upgrades, node pool scaling | 99.95% | 24/7 (production) |
| Azure App Service | Platform management, scaling, certificate management | Per Azure SLA | Business hours + on-call |

### Storage Services

| Service | Description | SLA | Support Hours |
|---------|-------------|-----|--------------|
| Azure Storage Management | Blob, Files, Disks — provisioning, monitoring, lifecycle | Per Azure SLA | Business hours |
| Backup Management | Azure Backup, Veeam — policy management, restore requests | RPO per tier | 24/7 (P1 restore) |
| SAN/NAS Management | NetApp/Dell — volume provisioning, snapshots, replication | 99.99% | 24/7 |

### Network Services

| Service | Description | SLA | Support Hours |
|---------|-------------|-----|--------------|
| Firewall Management | Azure Firewall, Palo Alto — rule management, monitoring | 99.99% | 24/7 |
| Load Balancer Management | Azure LB, App Gateway, F5 — configuration, health monitoring | 99.99% | 24/7 |
| DNS Management | Azure DNS, on-prem DNS — record management | 99.99% | 24/7 |
| ExpressRoute / VPN | Connectivity monitoring, failover management | 99.95% | 24/7 |

### Security Services

| Service | Description | SLA | Support Hours |
|---------|-------------|-----|--------------|
| Vulnerability Management | Scanning, reporting, remediation tracking | Monthly scan cycle | Business hours |
| SIEM Operations | Sentinel / Log Analytics — rule management, alert triage | Real-time | 24/7 (P1/P2) |
| Certificate Management | SSL/TLS certificate provisioning, renewal, monitoring | Pre-expiry renewal | Business hours |
| Identity Operations | Azure AD administration, access provisioning, PIM | Per SLA | 24/7 (access issues) |

## Operational Level Agreements (OLAs)

### Response and Resolution Times

| Priority | Response Time | Resolution Target | Escalation |
|----------|-------------|-------------------|------------|
| P1 — Critical | 15 minutes | 4 hours | Immediate page to on-call; bridge call |
| P2 — Major | 30 minutes | 8 hours | ServiceNow escalation; team lead notified |
| P3 — Minor | 2 hours | 24 hours (business) | ServiceNow workflow |
| P4 — Low | 4 hours | 5 business days | ServiceNow queue |

### Standard Change Lead Times

| Change Type | Lead Time |
|------------|-----------|
| VM provisioning (from approved template) | 2 business days |
| Firewall rule change | 3 business days |
| DNS record change | 1 business day |
| Storage provisioning | 2 business days |
| Network subnet creation | 5 business days |
| New service onboarding (full stack) | By project plan |

## Project to BAU Handover

### Handover Requirements

Before PIMS will accept a new service into BAU operations, the following must be provided:

| Artefact | Description | Owner |
|----------|-------------|-------|
| **HLD** | Approved High-Level Design | Architecture |
| **LLD** | Approved Low-Level Design with configuration details | Architecture |
| **Runbook** | Operational procedures: start/stop, health checks, troubleshooting, DR | Architecture + Engineering |
| **Monitoring** | Dynatrace dashboards, synthetic monitors, alerting rules configured | Architecture + CloudOps |
| **CMDB** | All CIs registered in ServiceNow with relationships | Architecture + PIMS |
| **Access** | Operational team access provisioned to all components | Architecture + Identity |
| **Backup** | Backup configured and first successful backup verified | Architecture + PIMS |
| **DR** | DR procedure documented and tested | Architecture |
| **Knowledge Transfer** | Walkthrough session with PIMS team covering architecture and operations | Architecture |
| **Support Contact** | Escalation contact for application-level issues | Engineering / Product |

### Handover Checklist

- [ ] HLD approved and stored in SharePoint/Confluence
- [ ] LLD approved and stored in SharePoint/Confluence
- [ ] Runbook created and published to ServiceNow Knowledge Base
- [ ] Dynatrace monitoring configured and dashboards created
- [ ] Alerting rules configured (P1-P4 mapping)
- [ ] CMDB updated with all CIs and relationships
- [ ] Backup configured, tested, and documented
- [ ] DR procedure documented and tested
- [ ] Operational team access verified
- [ ] Knowledge transfer session completed
- [ ] Change management handover (who approves changes to this service?)
- [ ] Cost centre and budget holder confirmed for ongoing operational costs

## References

- [PIMS Operating Model](./references/pims-operating-model.md) — Detailed processes, escalation paths, and interaction model
