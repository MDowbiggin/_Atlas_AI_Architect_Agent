# Well-Architected Frameworks

## Overview

EMIS/Optum uses both the **AWS Well-Architected Framework** (primary) and the **Azure Well-Architected Framework** (secondary) to evaluate and validate infrastructure designs. Every architecture must be assessed against all pillars.

## Azure Well-Architected Framework Pillars

### 1. Reliability

**Goal**: Ensure the system can recover from failures and continue to function.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Availability Target | Production: ≥ 99.9% (3 nines) unless otherwise specified |
| RTO | Defined per service tier (Tier 1: ≤ 1hr, Tier 2: ≤ 4hr, Tier 3: ≤ 24hr) |
| RPO | Defined per service tier (Tier 1: ≤ 15min, Tier 2: ≤ 1hr, Tier 3: ≤ 24hr) |
| Redundancy | Production workloads: minimum zone-redundant; mission-critical: region-redundant |
| Health Monitoring | Dynatrace synthetic monitoring + Azure Monitor health probes |
| Failover | Automated failover for Tier 1 services; documented manual failover for Tier 2/3 |
| Backup | Automated daily backups with tested restore procedures; geo-redundant for Tier 1 |
| Chaos Engineering | Recommended for Tier 1 services; document blast radius |

**Design Review Questions**:
- What is the defined availability SLA for this service?
- Are single points of failure identified and mitigated?
- Has disaster recovery been tested in the last 12 months?
- Are health probes configured for all critical components?

### 2. Security

**Goal**: Protect the application and data from threats.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Identity | Azure AD / Entra ID with MFA enforced; RBAC with least privilege |
| Network | Network segmentation via VNets/subnets; NSGs with deny-all default; private endpoints for PaaS |
| Data Protection | AES-256 at rest; TLS 1.2+ in transit; Azure Key Vault for secrets/certificates |
| Compliance | HIPAA, NIST, CIS Level 2, ISO 27001 — see `/security-compliance` skill |
| Threat Detection | Microsoft Defender for Cloud enabled; Dynatrace security analytics |
| Patching | Automated OS patching (Azure Update Management); application patches per vendor schedule |
| Logging | Security logs to Azure Sentinel / Log Analytics; minimum 90-day retention |

**Design Review Questions**:
- Is all data encrypted at rest and in transit?
- Are private endpoints used for all PaaS services?
- Is MFA enforced for all administrative access?
- Are security logs forwarded to the central SIEM?

### 3. Cost Optimisation

**Goal**: Manage costs to maximise business value.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Right-Sizing | Validate VM SKUs against actual utilisation (target 60-80% CPU utilisation) |
| Reserved Instances | Use 1-year or 3-year reservations for stable workloads (savings: 30-60%) |
| Auto-Scaling | Implement for variable workloads; scale-to-zero for non-production out-of-hours |
| Resource Tagging | Mandatory tags: `CostCentre`, `Environment`, `Owner`, `Application`, `Project` |
| Budget Alerts | Azure Cost Management alerts at 75%, 90%, 100% of budget |
| Orphan Resources | Monthly review to decommission unused resources |
| Dev/Test Licensing | Use Azure Dev/Test pricing for non-production environments |

**Design Review Questions**:
- Are VM sizes justified against workload requirements?
- Have reserved instances been considered for stable workloads?
- Is auto-scaling configured for variable-demand services?
- Are all resources tagged per the mandatory tagging policy?

### 4. Operational Excellence

**Goal**: Run and monitor systems to deliver business value and continuously improve.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| IaC | All infrastructure defined in Terraform or Bicep; stored in ADO Git repos |
| CI/CD | ADO Pipelines for deployment; environment promotion (Dev → Test → Staging → Prod) |
| Monitoring | Dynatrace for APM; Azure Monitor for platform metrics; ServiceNow for incident management |
| Alerting | Tiered alerting: P1 → PagerDuty/on-call; P2 → ServiceNow auto-ticket; P3 → email |
| Runbooks | Mandatory for all production services; stored in Confluence |
| Post-Incident Review | Blameless post-incident reviews for all P1/P2 incidents; findings fed back into design |
| Documentation | HLD, LLD, runbooks, and CMDB entries must be complete before go-live |

**Design Review Questions**:
- Is all infrastructure defined as code with peer-reviewed pull requests?
- Are monitoring dashboards and alerting rules defined?
- Are runbooks documented and accessible to the operations team?
- Is the CMDB updated with all configuration items?

### 5. Performance Efficiency

**Goal**: Use computing resources efficiently to meet requirements and maintain efficiency as demand changes.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Benchmarking | Baseline performance before and after changes; load test before production deployment |
| Scaling Strategy | Horizontal scaling preferred over vertical where architecturally feasible |
| Caching | Implement caching layers (Azure Redis Cache) for frequently accessed data |
| CDN | Use Azure Front Door / CDN for static content delivery |
| Database Performance | Query optimisation, indexing strategy, connection pooling |
| Latency Requirements | Define and test against latency SLAs (e.g., < 200ms API response for Tier 1) |

**Design Review Questions**:
- Has the workload been load-tested against expected peak demand?
- Is horizontal scaling possible for the compute tier?
- Are caching strategies implemented where appropriate?
- Are latency requirements defined and measurable?

### 6. Sustainability (Azure)

**Goal**: Minimise the environmental footprint of cloud workloads and align with organisational net-zero commitments.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Region Selection | UK South (`uksouth`) — Microsoft targets 100% renewable energy by 2025 and operates matched renewable energy certificates; prefer UK-based regions |
| Compute Efficiency | Right-size VMs to avoid idle/over-provisioned capacity; use B-series burstable VMs for dev/test instead of always-on premium SKUs |
| Serverless & PaaS | Azure Functions, Container Apps, and App Service preferred over IaaS for event-driven and variable workloads — consume no resources when idle |
| Auto-Scaling & Scheduling | Scale-to-zero or scheduled shutdown for non-production environments out-of-hours (Azure Automation / Azure DevOps scheduled pipelines) |
| Storage Tiering | Azure Blob lifecycle management policies to transition data to Cool/Archive tiers; delete data at end of retention period per HIPAA requirements |
| Carbon Awareness | Use Azure Carbon Optimisation in Azure Monitor to track and report on the carbon impact of Azure resources |
| Container Density | Maximise pod density per AKS node; avoid single-workload node pools that leave capacity underutilised |

**Design Review Questions**:
- Are non-production environments configured to shut down out-of-hours?
- Is a storage lifecycle policy applied to transition data to cooler tiers after defined periods?
- Are serverless or PaaS options evaluated before recommending IaaS?
- Are VMs right-sized to avoid chronic over-provisioning?

## Azure Architecture Review Scorecard

```markdown
| Pillar | Score (1-5) | Evidence | Gaps | Recommendations |
|--------|-------------|----------|------|-----------------|
| Reliability | | | | |
| Security | | | | |
| Cost Optimisation | | | | |
| Operational Excellence | | | | |
| Performance Efficiency | | | | |
| Sustainability | | | | |
| **Overall** | | | | |
```

**Scoring Guide**:
- **5** — Exceeds standards; best-practice implementation with documented evidence
- **4** — Meets standards; minor improvements possible
- **3** — Partially meets standards; specific gaps identified with remediation plan
- **2** — Significant gaps; requires redesign of specific components
- **1** — Does not meet standards; fundamental architectural concerns

---

AWS is the **primary cloud platform** for EMIS/Optum. The following EMIS/Optum standards apply for all AWS-hosted workloads, organised by the six AWS WAF pillars.

### 1. Operational Excellence (AWS)

**Goal**: Run and monitor systems to deliver business value and continuously improve supporting processes and procedures.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Infrastructure as Code | All infrastructure in Terraform with AWS provider; state in S3 + DynamoDB lock |
| Deployment | ADO Pipelines; Dev → Test → Staging → Prod promotion; manual approval gate for production |
| Monitoring | CloudWatch + Dynatrace OneAgent on all EC2/ECS/EKS; structured JSON logs |
| Alerting | P1: CloudWatch alarm → SNS → PagerDuty (5 min); P2: SNS → ServiceNow auto-ticket |
| Run Books | Published to ServiceNow Knowledge Base; cover start/stop, DR, common failures |
| Change Management | All changes via ServiceNow RFC; ADO pipeline as the only deployment path |
| Post-Incident Review | Blameless PIR for all P1/P2 within 5 business days; findings fed back to architecture |

**Design Review Questions (AWS)**:
- Is all infrastructure defined in Terraform with peer-reviewed PRs in ADO?
- Are CloudWatch dashboards and alarms defined before go-live?
- Are operational runbooks complete and accessible in ServiceNow?
- Is the CMDB updated with all AWS resource CIs?

### 2. Security (AWS)

**Goal**: Protect data, systems, and assets to take advantage of cloud technologies to improve security.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Identity & Access | IAM Identity Center (SSO) federated from Azure AD; no long-lived IAM user access keys |
| Least Privilege | IAM roles/instance profiles for services; IRSA for EKS pods; permission boundaries on developer roles |
| Network | VPC with 4-tier subnets; Security Groups deny-all default; no public SSH/RDP (SCP-enforced) |
| Data Protection | KMS CMK for Confidential/Restricted data at rest; TLS 1.2+ in transit; ACM for certificates |
| Secrets | AWS Secrets Manager (PHI/credentials); Parameter Store SecureString (config); never plaintext env vars |
| Detection | GuardDuty + Security Hub in all accounts; findings auto-ticketed in ServiceNow |
| Admin Access | Systems Manager Session Manager only; no bastion hosts; sessions logged to CloudWatch/S3 |
| Compliance | CIS AWS v3.0 conformance pack via AWS Config in all accounts |
| PHI Data | Macie enabled in production; S3 Block Public Access at account level (SCP-enforced) |

**Design Review Questions (AWS)**:
- Are all services using IAM roles — no hardcoded credentials or long-lived access keys?
- Are VPC endpoints configured for all AWS services accessed from private subnets?
- Is GuardDuty enabled and findings routed to ServiceNow?
- Is KMS CMK in use for all Confidential/Restricted data at rest?

### 3. Reliability (AWS)

**Goal**: Ensure a workload performs its intended function correctly and consistently when it's expected to.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Availability Target | Production: ≥ 99.9% unless specified; Tier 1 mission-critical: ≥ 99.99% |
| RTO | Tier 1: ≤ 1hr; Tier 2: ≤ 4hr; Tier 3: ≤ 24hr |
| RPO | Tier 1: ≤ 15min; Tier 2: ≤ 1hr; Tier 3: ≤ 24hr |
| Multi-AZ | Minimum 2 AZs for production in `eu-west-2`; 3 AZs preferred |
| Auto Scaling | Auto Scaling Groups for EC2; ECS Service Auto Scaling; Karpenter / Cluster Autoscaler for EKS |
| Database HA | RDS Multi-AZ; Aurora (Multi-AZ by default); automated failover < 60 seconds |
| Backup | AWS Backup with cross-region copy to `eu-west-1` for Tier 1; 30-day minimum retention |
| DR Testing | Tier 1: quarterly using AWS Fault Injection Service (FIS); Tier 2: 6-monthly; Tier 3: annually |
| Health Checks | ALB target group health checks; Route 53 health checks for DNS failover |
| Circuit Breakers | Implemented via ECS Service Connect / App Mesh / application-level SDK patterns |

**Design Review Questions (AWS)**:
- Are workloads distributed across ≥ 2 AZs with Auto Scaling?
- Has disaster recovery to `eu-west-1` been designed and tested?
- Is AWS Backup configured with cross-region copy for Tier 1 workloads?
- Have AWS FIS chaos tests been planned for Tier 1 services?

### 4. Performance Efficiency (AWS)

**Goal**: Use computing resources efficiently to meet system requirements and maintain efficiency as demand changes.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Compute Selection | Graviton (`arm64`) preferred for new workloads (20% savings + better price/performance) |
| Right-Sizing | AWS Compute Optimizer consulted at design; re-reviewed 30 days post go-live |
| Scaling Strategy | Horizontal scaling mandatory for stateless services; vertical only as last resort |
| Caching | ElastiCache (Redis) for session state, DB query caching; CloudFront for static content |
| Database Performance | Query analysis via Performance Insights (RDS); Connection pooling (RDS Proxy for serverless) |
| Content Delivery | CloudFront for static assets and API acceleration |
| Latency Measurement | Define and test P50/P95/P99 latency targets before go-live; monitor in CloudWatch |
| Serverless | Lambda with Graviton (`arm64`) for event-driven workloads; right-size memory via Lambda Power Tuning |

**Design Review Questions (AWS)**:
- Have Graviton instances been evaluated and adopted where compatible?
- Is caching implemented at the appropriate layer (application, database, CDN)?
- Has the workload been load-tested against expected peak demand?
- Are P95/P99 latency targets defined and monitored?

### 5. Cost Optimisation (AWS)

**Goal**: Run systems to deliver business value at the lowest price point.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Savings Plans | ≥ 70% of steady-state compute covered by Compute or EC2 Savings Plans |
| Reserved Instances | RDS, ElastiCache, Redshift: 1 or 3 year reservations for stable workloads |
| Spot Instances | Dev/Test EC2, batch jobs, EKS worker pools; Spot interruption handling required |
| Graviton | `arm64` for Lambda, Fargate, EKS — ~20% cost reduction vs x86 at same performance |
| Right-Sizing | Compute Optimizer recommendations reviewed quarterly; CPU/memory targets: 60-80% utilisation |
| Auto-Scaling | Scale-to-zero for non-production out-of-hours (EventBridge scheduled scaling) |
| Cost Anomaly Detection | Enabled per account; alert threshold ≥ £50/day or 20% above baseline |
| Tagging | Mandatory: `CostCentre`, `Environment`, `Owner`, `Application`, `Project`, `ManagedBy` |
| Resource Lifecycle | Termination protection on production; deletion policy reviews monthly; DynamoDB TTL for transient data |
| Data Transfer | Minimise cross-AZ data transfer (keep related services in same AZ where possible); use VPC endpoints to avoid NAT Gateway charge for S3/DynamoDB |

**Design Review Questions (AWS)**:
- Have Savings Plans been purchased or planned for steady-state compute?
- Are Spot instances used for eligible dev/test and batch workloads?
- Is auto-scaling configured with scheduled scale-down for non-production?
- Are all resources tagged per the mandatory tagging policy?

### 6. Sustainability (AWS)

**Goal**: Minimise the environmental impacts of running cloud workloads.

| Consideration | EMIS/Optum Standard |
|--------------|---------------------|
| Region Selection | `eu-west-2` (London) — Amazon targets 100% renewable energy; prefer over regions with lower renewable mix |
| Instance Type | Graviton favoured — AWS states up to 60% less energy vs comparable x86 workloads |
| Serverless | Lambda and Fargate consume no resources when idle — preferred for variable/event-driven workloads |
| Storage Tiering | S3 Intelligent-Tiering for data with variable access patterns; Glacier for archival; delete data at end of retention period |
| Scale-to-Zero | Dev/Test environments shut down out-of-hours via EventBridge scheduled rules |
| Container Density | Maximise pod/task density per node; avoid over-provisioned node pools |

**Design Review Questions (AWS)**:
- Is `eu-west-2` the primary region for new workloads?
- Are Graviton and serverless options evaluated for all new workload components?
- Is S3 lifecycle policy configured to transition to appropriate storage tiers?

---

## AWS Architecture Review Scorecard

Use this scorecard when reviewing AWS architectures against WAF pillars:

```markdown
| Pillar | Score (1-5) | Evidence | Gaps | Recommendations |
|--------|-------------|----------|------|-----------------|
| Operational Excellence | | | | |
| Security | | | | |
| Reliability | | | | |
| Performance Efficiency | | | | |
| Cost Optimisation | | | | |
| Sustainability | | | | |
| **Overall** | | | | |
```

**Scoring Guide** (applies to both Azure and AWS scorecards):
- **5** — Exceeds standards; best-practice implementation with documented evidence
- **4** — Meets standards; minor improvements possible
- **3** — Partially meets standards; specific gaps identified with remediation plan
- **2** — Significant gaps; requires redesign of specific components
- **1** — Does not meet standards; fundamental architectural concerns
