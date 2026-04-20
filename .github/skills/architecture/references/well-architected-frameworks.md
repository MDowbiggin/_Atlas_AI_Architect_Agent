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

## AWS Well-Architected Framework Pillars

The AWS pillars mirror Azure's with the following EMIS/Optum-specific mappings:

| AWS Pillar | Azure Equivalent | Key AWS Services |
|-----------|-----------------|-----------------|
| Operational Excellence | Operational Excellence | CloudWatch, CloudFormation, Systems Manager |
| Security | Security | IAM, KMS, GuardDuty, Security Hub |
| Reliability | Reliability | Auto Scaling, Route 53, S3 Cross-Region Replication |
| Performance Efficiency | Performance Efficiency | CloudFront, ElastiCache, Auto Scaling |
| Cost Optimization | Cost Optimisation | Cost Explorer, Savings Plans, Trusted Advisor |
| Sustainability | — | Graviton instances, region selection for carbon efficiency |

> **Note**: For AWS-hosted workloads, apply the same standards and thresholds defined above. Use AWS-native services where the workload is AWS-primary; avoid mixing Azure and AWS services for the same workload unless specifically approved for multi-cloud resilience.

## Architecture Review Scorecard

Use this scorecard when reviewing architectures against WAF pillars:

```markdown
| Pillar | Score (1-5) | Evidence | Gaps | Recommendations |
|--------|-------------|----------|------|-----------------|
| Reliability | | | | |
| Security | | | | |
| Cost Optimisation | | | | |
| Operational Excellence | | | | |
| Performance Efficiency | | | | |
| **Overall** | | | | |
```

**Scoring Guide**:
- **5** — Exceeds standards; best-practice implementation with documented evidence
- **4** — Meets standards; minor improvements possible
- **3** — Partially meets standards; specific gaps identified with remediation plan
- **2** — Significant gaps; requires redesign of specific components
- **1** — Does not meet standards; fundamental architectural concerns
