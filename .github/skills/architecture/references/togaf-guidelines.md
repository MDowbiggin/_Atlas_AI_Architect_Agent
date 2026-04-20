# TOGAF Guidelines

## Overview

The Open Group Architecture Framework (TOGAF) provides the structural methodology for EMIS/Optum architecture work. Atlas_Architect uses TOGAF's Architecture Development Method (ADM) as the backbone for design activities.

## ADM Phases — Infrastructure Architecture Focus

### Preliminary Phase
- Establish architecture principles (see core principles in SKILL.md)
- Define the architecture governance framework
- Confirm tooling and standards (ADO, ServiceNow, Confluence)

### Phase A: Architecture Vision
- Define the problem statement and business drivers
- Identify stakeholders and their concerns
- Produce a high-level scope statement
- Confirm alignment with EMIS/Optum strategic priorities

**Atlas_Architect Output**: Demand Review Summary, Stakeholder Map

### Phase B: Business Architecture
- Map business capabilities to infrastructure requirements
- Identify service-level requirements (SLA/OLA)
- Define data flows and integration points

**Atlas_Architect Output**: Business Requirements Mapping, Service Level Matrix

### Phase C: Information Systems Architecture
- Define application hosting requirements (compute, memory, storage)
- Map data flows, data classification, and data residency requirements
- Identify integration patterns (API, message queue, file transfer, ETL)

**Atlas_Architect Output**: Application Hosting Matrix, Data Flow Diagrams

### Phase D: Technology Architecture
- Design the infrastructure solution (compute, storage, networking, security)
- Select technology components from approved standards
- Define deployment topology (Azure regions, availability zones, on-prem sites)
- Design disaster recovery and business continuity
- Produce cost estimates

**Atlas_Architect Output**: HLD, LLD, Network Diagrams, BoM, Cost Estimate

### Phase E: Opportunities & Solutions
- Identify migration approach (lift-and-shift, re-platform, re-architect)
- Define implementation phases and dependencies
- Assess build vs. buy decisions

**Atlas_Architect Output**: Migration Plan, Implementation Roadmap

### Phase F: Migration Planning
- Produce detailed migration runbooks
- Define rollback procedures
- Plan testing and validation gates
- Coordinate with PIMS, CloudOps, Security, and Engineering

**Atlas_Architect Output**: Migration Runbook, Test Plan, RACI Matrix

### Phase G: Implementation Governance
- Review IaC code against architecture design
- Validate deployed infrastructure against design specifications
- Monitor implementation progress via ADO

**Atlas_Architect Output**: Implementation Review Checklist, Variance Report

### Phase H: Architecture Change Management
- Assess change requests against the baseline architecture
- Evaluate impact on compliance, cost, and operations
- Update architecture artefacts

**Atlas_Architect Output**: Change Impact Assessment, Updated Design Documents

## Architecture Viewpoints

Use these viewpoints when structuring architecture documentation:

| Viewpoint | Audience | Content |
|-----------|----------|---------|
| **Business** | Business stakeholders, product owners | Capabilities, processes, service levels |
| **Application** | Application architects, developers | Application hosting, integration, data flows |
| **Technology** | Infrastructure architects, engineers | Compute, storage, networking, security topology |
| **Security** | Security team, compliance | Security controls, access management, encryption |
| **Operational** | PIMS, CloudOps | Monitoring, alerting, patching, backup, DR |
| **Cost** | Finance, budget holders | BoM, TCO, OpEx/CapEx breakdown |

## Architecture Building Blocks (ABBs)

Standard building blocks for EMIS/Optum infrastructure:

| Category | Building Block | Primary Platform | Secondary |
|----------|---------------|-----------------|-----------|
| Compute | Virtual Machines | Azure VMs | AWS EC2 / VMware vSphere |
| Compute | Containers | Azure AKS | AWS EKS |
| Compute | Serverless | Azure Functions | AWS Lambda |
| Storage | Block Storage | Azure Managed Disks | AWS EBS / VMware vSAN |
| Storage | Object Storage | Azure Blob Storage | AWS S3 |
| Storage | File Storage | Azure Files / NetApp | AWS EFS |
| Database | Relational (SQL) | Azure SQL / Azure PostgreSQL | AWS RDS |
| Database | NoSQL | Azure Cosmos DB | AWS DynamoDB |
| Networking | Virtual Network | Azure VNet | AWS VPC |
| Networking | Load Balancer | Azure Load Balancer / App Gateway | AWS ALB/NLB |
| Networking | DNS | Azure DNS / Azure Private DNS | AWS Route 53 |
| Networking | Firewall | Azure Firewall / NSG | AWS Network Firewall / SG |
| Networking | VPN / ExpressRoute | Azure VPN Gateway / ExpressRoute | AWS VPN / Direct Connect |
| Security | Identity | Azure AD / Entra ID | AWS IAM |
| Security | Secrets | Azure Key Vault | AWS Secrets Manager |
| Security | WAF | Azure Front Door / WAF | AWS WAF / CloudFront |
| Monitoring | APM | Dynatrace | — |
| Monitoring | Platform | Azure Monitor / Log Analytics | AWS CloudWatch |
| Automation | IaC | Terraform / Bicep | CloudFormation / Ansible |
| Automation | CI/CD | Azure DevOps Pipelines | — |
| ITSM | Service Management | ServiceNow | — |
