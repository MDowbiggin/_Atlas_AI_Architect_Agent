# AWS Standards

## Overview

Amazon Web Services is the **strategic primary cloud platform** for EMIS/Optum. All new cloud workloads should default to AWS unless there is a documented justification for Azure (e.g., M365 integration, existing Azure estate) or on-prem.

## Approved Regions

| Region | Use Case | Data Sovereignty |
|--------|----------|-----------------|
| **eu-west-2** (London) | Primary for UK workloads | UK data residency ✅ |
| **eu-west-1** (Ireland) | DR, overflow | EU data residency ⚠️ Requires approval |

> **Rule**: Same data residency rules apply as Azure — UK patient data must remain in `eu-west-2` unless explicitly approved.

## Compute Standards

### EC2 Instances

| Workload Type | Recommended Instance Family | Notes |
|--------------|---------------------------|-------|
| General purpose | m6i / m7i | Balanced; most common |
| Memory-optimised | r6i / r7i | Databases, in-memory workloads |
| Compute-optimised | c6i / c7i | Batch, high-CPU |
| Burstable (Dev/Test) | t3 / t3a | Non-production only |

**Standards**:
- Use Auto Scaling Groups with minimum 2 AZs for production
- EBS volumes: gp3 (production), gp3 lower IOPS (dev/test)
- Enable AWS Backup with 30-day retention minimum
- Enforce IMDSv2 (disable IMDSv1)
- Apply mandatory tags: `CostCentre`, `Environment`, `Owner`, `Application`, `Project`

### Elastic Kubernetes Service (EKS)

- **Version**: Keep within N-1 of latest stable
- **Networking**: VPC CNI with custom networking
- **Control Plane**: Private endpoint access
- **Node Groups**: Managed node groups with Graviton instances where compatible (cost savings ~20%)
- **Registry**: Amazon ECR with image scanning enabled
- **IAM**: IAM Roles for Service Accounts (IRSA)

## Storage Standards

| Service | Use Case |
|---------|----------|
| S3 | Object storage, backups, data lake |
| EBS | Block storage for EC2 |
| EFS | Shared file storage (NFS) |
| FSx | Windows file shares, high-performance Lustre |

**Standards**:
- S3 bucket policies: Block Public Access enabled on all buckets
- S3 versioning enabled for critical data
- S3 encryption: SSE-S3 minimum; SSE-KMS for sensitive data
- Cross-region replication for DR-critical data

## Database Standards

| Service | Use Case |
|---------|----------|
| RDS (PostgreSQL, MySQL, SQL Server) | Relational workloads |
| Aurora | High-performance relational |
| DynamoDB | NoSQL, key-value |
| ElastiCache | Redis/Memcached caching |

**Standards**:
- Multi-AZ for production databases
- Encryption at rest (KMS) and in transit (TLS)
- IAM database authentication where supported
- Automated backups with point-in-time recovery

## Networking Standards

- **VPC**: One VPC per environment per region; CIDR ranges coordinated with Azure VNet space
- **Subnets**: Public (internet-facing ALB only), Private (application), Isolated (database)
- **Security Groups**: Least-privilege; reference by security group ID, not CIDR where possible
- **NACLs**: Defence-in-depth layer; deny-all default with explicit allow rules
- **Transit Gateway**: For multi-VPC and on-prem connectivity
- **Direct Connect**: For production on-prem connectivity; VPN as backup

## Identity & Access

- **IAM**: Least-privilege roles; no long-lived access keys for production
- **AWS SSO / IAM Identity Center**: Federated from Azure AD / Entra ID
- **SCP (Service Control Policies)**: Enforce guardrails at Organisation level
- **CloudTrail**: Enabled in all regions with centralised logging

## Governance & Multi-Account

- **AWS Organisations**: Multi-account architecture — see [AWS Landing Zone](./aws-landing-zone.md) for full account hierarchy and Control Tower guidance
- **AWS Config**: Compliance rules aligned with CIS Level 2; CIS AWS v3.0 conformance pack deployed to all accounts
- **Trusted Advisor**: Review weekly for cost, security, and performance recommendations
- **Cost Explorer + Savings Plans**: Reserved capacity for stable workloads
- **Resource Groups + Tag Policies**: Enforce mandatory tagging
- **AWS Control Tower**: Automated guardrails and account vending (see [AWS Landing Zone](./aws-landing-zone.md))
- **Security Hub**: Centralised compliance aggregation across all accounts; CIS AWS v3 + HIPAA standards enabled

---

## Containers: ECS & Fargate

### ECS Fargate (Preferred over EKS for simpler container workloads)

**Use For**: Stateless microservices, API backends, scheduled tasks — where Kubernetes complexity is not justified.

| Aspect | Standard |
|--------|---------|
| Launch type | Fargate (serverless compute; no EC2 node management) |
| Networking | `awsvpc` mode — each task gets its own ENI and security group |
| Registry | Amazon ECR; image scanning (ECR Enhanced Scanning with Inspector) enabled |
| Logging | `awslogs` driver to CloudWatch Logs + Dynatrace OneAgent sidecar |
| Secrets | Injected from AWS Secrets Manager or Parameter Store (never environment variables with plaintext) |
| IAM | Task execution role (ECR pull, Secrets Manager) + task role (app permissions) — separate roles |
| Scaling | Application Auto Scaling based on CPU/memory target tracking or SQS queue depth |
| Networking placement | Private subnets only; traffic from NLB/ALB in public subnets |

### ECS EC2 Launch Type

Use only when Fargate is not suitable (GPU workloads, specific OS requirements, performance-sensitive with custom networking).

- Use managed EC2 Auto Scaling Groups
- ECS-optimised AMI from EC2 Image Builder (golden AMI process)
- Spot instances for dev/test; On-Demand or Reserved for production

### EKS (Elastic Kubernetes Service)

- **Version**: Keep within N-1 of latest stable; quarterly upgrade cadence
- **Node Groups**: Managed node groups; Graviton (`m7g` / `c7g` / `r7g`) preferred (~20% cost saving vs x86)
- **Add-ons**: VPC CNI, CoreDNS, kube-proxy, AWS Load Balancer Controller, EBS CSI driver, Secrets Store CSI driver
- **IRSA**: IAM Roles for Service Accounts — all pods use IRSA; no node-level instance profile for app permissions
- **Cluster Access**: Private API server endpoint only; kubectl via Systems Manager Session Manager or bastion in management subnet
- **Karpenter**: Preferred node autoscaler (replaces Cluster Autoscaler); mixed instance type pools for cost efficiency
- **Pod Identity**: Use EKS Pod Identity (newer, simpler) or IRSA for per-workload IAM

---

## Serverless

### Lambda

| Aspect | Standard |
|--------|---------|
| Runtime | Python 3.12 / Node.js 20 / Java 21 (LTS versions preferred) |
| Architecture | `arm64` (Graviton) preferred — 20% cost saving vs x86 |
| Memory | Right-size using Lambda Power Tuning tool; start at 512 MB |
| Execution timeout | Default 3s; maximum 15 minutes — not suitable for long-running processes |
| VPC | Deploy in VPC only when private resource access (RDS, ElastiCache) is required; adds cold start latency |
| Concurrency | Set reserved concurrency for critical downstream systems; provisioned concurrency for latency-sensitive |
| Secrets | AWS Secrets Manager via Lambda extension (cached, rotated automatically) |
| IAM | Least-privilege execution role; no `*` actions |
| Logging | Structured JSON logs to CloudWatch Logs + Lambda Insights |
| Tracing | AWS X-Ray active tracing enabled |

### API Gateway

| Type | Use Case |
|------|---------|
| **HTTP API** | Low-latency, low-cost REST APIs (70% cheaper than REST API); JWT authorisers |
| **REST API** | Advanced features: API keys, usage plans, per-route throttling, request/response transformations |
| **WebSocket API** | Real-time bi-directional (chat, notifications, live dashboards) |

**Standards**:
- Always use custom domain (ACM certificate via `us-east-1` for CloudFront/API GW) or `eu-west-2` for regional
- Throttling: configure default throttle (10,000 RPS / 5,000 burst) per stage; per-method where needed
- WAF: associate AWS WAF WebACL with all public-facing API Gateways
- Access logging: enabled; log to CloudWatch Logs + forwarded to central SIEM
- Authorisation: Cognito User Pool or Lambda authoriser (JWT); never expose unauthenticated endpoints

### Step Functions

- **Standard Workflows**: Long-running, auditable orchestration; exactly-once execution; state visible in console
- **Express Workflows**: High-throughput, short-duration (≤ 5 min); at-least-once; lower cost
- Use for: multi-step data pipelines, approval flows, retry/error handling across services

---

## Messaging & Event-Driven Services

| Service | Use Case | Standard |
|---------|---------|---------|
| **SQS Standard** | Decoupled queuing; at-least-once delivery; high throughput | Dead-letter queue mandatory for all queues; visibility timeout ≥ 6× function timeout |
| **SQS FIFO** | Ordered, exactly-once processing; lower throughput (3,000 msg/s with batching) | Use when ordering is a business requirement |
| **SNS** | Fan-out pub/sub to multiple SQS queues, Lambda, HTTP endpoints | Topic policy: restrict publishers; filter policies on subscriptions to reduce cost |
| **EventBridge** | Event bus; routing rules; schedule (cron); schema registry | Default event bus for AWS service events; custom bus for application events |
| **Kinesis Data Streams** | Real-time streaming, high-volume event ingestion | Enhanced fan-out for low-latency consumers; 7-day retention minimum for audit |
| **Kinesis Firehose** | Managed delivery to S3, Redshift, OpenSearch, Splunk | Compression (GZIP) and format conversion (Parquet) enabled |

**Common Standards for all messaging services**:
- Encryption at rest (KMS CMK for Confidential/Restricted data)
- IAM resource policies: restrict producers and consumers by ARN
- VPC endpoints for SQS, SNS, Kinesis (avoid internet traversal)
- Monitor DLQ depth as a CloudWatch alarm (alert on > 0 for 5 minutes)

---

## CDN, Edge & Certificate Management

### CloudFront

| Aspect | Standard |
|--------|---------|
| Origins | S3 (with OAC — Origin Access Control, not OAI), ALB, API Gateway, custom HTTP |
| HTTPS | Enforce HTTPS-only (redirect HTTP→HTTPS); TLS 1.2 minimum policy |
| Cache | Cache invalidation via CI/CD pipeline or versioned object keys (preferred) |
| WAF | AWS WAF WebACL attached to all CloudFront distributions serving public content |
| Geo-restriction | Block non-UK traffic unless global CDN explicitly required |
| Logging | Access logs to S3; forwarded to SIEM |
| Custom domain | ACM certificate in `us-east-1` (required for CloudFront) |
| Price class | `PriceClass_100` (North America + Europe) for most workloads; `All` only if global reach required |

### AWS WAF

- **Managed rule groups**: AWS Managed Rules (Core rule set, IP reputation, Admin protection, Known bad inputs)
- **Custom rules**: IP rate limiting (per IP threshold per 5 minutes); geographic blocks; string match for known attack patterns
- **Logging**: Full request logging to S3 / Kinesis Firehose; forwarded to SIEM for correlation
- **Bot control**: Enable AWS Bot Control for public-facing web applications
- **Apply to**: CloudFront, ALBs, API Gateway, AppSync

### AWS Shield

| Tier | Enabled By | Coverage |
|------|-----------|---------|
| **Standard** | Automatic (all accounts) | Layer 3/4 DDoS protection for all AWS resources |
| **Advanced** | Opt-in (production critical workloads) | Layer 7 DDoS, real-time visibility, 24/7 DDoS response team, cost protection |

- Enable Shield Advanced for all production internet-facing load balancers and CloudFront distributions handling patient data

### AWS Certificate Manager (ACM)

- Request certificates in `us-east-1` for CloudFront distributions
- Request certificates in `eu-west-2` for ALB, API Gateway (regional)
- Use DNS validation (not email) — automated renewal
- Monitor certificate expiry via ACM EventBridge events → SNS → PagerDuty alert 45 days before expiry
- Certificates stored in ACM are managed; never export private keys unless absolutely required

---

## Security Services

### GuardDuty

Enabled in all accounts via Control Tower. Aggregated findings to Audit account.

| Feature | Configuration |
|---------|--------------|
| Threat intelligence | AWS curated + custom IP/domain threat lists |
| S3 Protection | Enabled — detects suspicious S3 access patterns |
| EKS Protection | Enabled — runtime threat detection for EKS workloads |
| EC2 Malware Protection | Enabled for production accounts |
| Suppression rules | Create for known-good patterns (e.g., Dynatrace scanning IPs) |
| Findings | Exported to Security Hub and S3; critical findings → PagerDuty via EventBridge |

### Security Hub

Centralised security posture management. All findings from GuardDuty, Inspector, Macie, IAM Access Analyzer, and Config aggregate here.

- **Standards enabled**: CIS AWS Foundations v3.0, AWS Foundational Security Best Practices, HIPAA
- **Delegated administrator**: Audit account — all member accounts auto-enrolled
- **Findings routing**: Critical/High → EventBridge → Lambda → ServiceNow P1/P2 ticket
- **Custom Insights**: Dashboard for: unencrypted volumes, public S3 buckets, unused IAM access keys, GuardDuty high-severity

### Amazon Inspector v2

Automated vulnerability management for EC2, ECR container images, and Lambda functions.

| Scan Type | Automatic |
|-----------|-----------|
| EC2 instances | Yes — via Systems Manager agent continous scan |
| ECR images | Yes — on push and rescan on new CVE publication |
| Lambda functions | Yes — package vulnerability scan + code analysis |

- Findings aggregated to Security Hub
- Critical CVEs: auto-create ServiceNow incident; block ECR image deployment via pipeline gate
- Integration with patch baselines: Inspector findings linked to SSM Patch Manager remediation

### Amazon Macie

Automated discovery and protection of sensitive data (PHI, PII) in S3.

- Enabled in all production accounts handling patient data
- Automated sensitive data discovery: classify buckets by data sensitivity
- Findings to Security Hub; High/Critical → ServiceNow alert
- Used to verify HIPAA compliance: no unencrypted PHI in accessible S3 buckets

### IAM Access Analyzer

- Organisation-level analyser in Audit account — identifies resources accessible outside the account or organisation
- Findings: external access to S3, KMS, Lambda, IAM roles, SQS — investigated and remediated within 5 business days
- Custom archive rules for known-good cross-account access patterns (e.g., centralised monitoring ARN)
- Access Analyzer also validates IAM policies before deployment (IDE and CI/CD integration)

---

## Operations: Systems Manager

AWS Systems Manager (SSM) is the primary operations platform for EC2 and hybrid instances.

| Capability | Use |
|-----------|-----|
| **Session Manager** | Secure shell access to EC2 — no bastion hosts, no public SSH/RDP required; full audit log to CloudWatch/S3 |
| **Patch Manager** | Automated OS patching; patch baselines per OS; maintenance windows; compliance reporting |
| **Parameter Store** | Hierarchical configuration storage; `SecureString` type uses KMS; use for non-secret config |
| **Secrets Manager** | Sensitive credentials (DB passwords, API keys); auto-rotation; accessed by apps via SDK |
| **Inventory** | Software, network, patch state inventory; feeds CMDB |
| **State Manager** | Desired-state configuration (apply hardening, OS settings); Ansible integration |
| **Automation** | Runbook automation (JSON/YAML); used for AMI creation, patching, instance remediation |
| **Fleet Manager** | Windows registry, file system, process viewer without SSH; useful for troubleshooting |
| **Change Calendar** | Block changes during critical periods (go-lives, peak periods) |

**Single standard for admin access**: All administrative access to EC2 instances uses SSM Session Manager. SSH (port 22) and RDP (port 3389) are blocked via Security Groups in all production accounts (enforced by SCP).

---

## Observability: CloudWatch & X-Ray

### CloudWatch

| Feature | Standard |
|---------|---------|
| Metrics | All AWS service metrics auto-collected; custom metrics via CloudWatch Agent (installed via SSM) |
| Log Groups | Retention: 90 days (standard); 365 days (PHI/audit); 7 years (HIPAA audit logs — S3 archive) |
| Alarms | P1: ≤ 1 min evaluation; P2: ≤ 5 min; route to SNS → PagerDuty / ServiceNow |
| Dashboards | Per-workload operational dashboards; shared to Dynatrace where possible |
| Log Insights | Use for ad-hoc queries; create saved queries for common investigations |
| Metric Filters | Create metric filters from structured log patterns (JSON); drive alarms from log events |
| Container Insights | EKS/ECS Container Insights enabled for cluster and pod-level metrics |

### CloudWatch Agent Standard Config

```json
{
  "metrics": {
    "namespace": "EMISCustomMetrics",
    "metrics_collected": {
      "cpu": {"measurement": ["cpu_usage_idle", "cpu_usage_user", "cpu_usage_system"], "metrics_collection_interval": 60},
      "disk": {"measurement": ["used_percent"], "resources": ["*"]},
      "mem": {"measurement": ["mem_used_percent"]}
    }
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [{"file_path": "/var/log/messages", "log_group_name": "/ec2/{instance_id}/system"}]
      }
    }
  }
}
```

### AWS X-Ray

- Enable for Lambda, API Gateway, ECS, and EKS workloads
- Use X-Ray service maps to identify latency bottlenecks and error propagation
- Dynatrace preferred for APM in complex architectures; X-Ray as supplement for AWS service call traces

---

## Cost Optimisation

### Savings Plans & Reserved Instances

| Option | Discount | Commitment | Best For |
|--------|---------|------------|---------|
| **Compute Savings Plan** | Up to 66% | 1 or 3 year | Most flexible; covers EC2, Fargate, Lambda across instance families and regions |
| **EC2 Instance Savings Plan** | Up to 72% | 1 or 3 year | Specific instance family in a region; greater discount than Compute SP |
| **RDS Reserved Instances** | Up to 69% | 1 or 3 year | Stable RDS/Aurora database instances |
| **ElastiCache Reserved** | Up to 55% | 1 or 3 year | Stable cache clusters |
| **Redshift Reserved** | Up to 75% | 1 or 3 year | Stable data warehouse nodes |

**Coverage target**: ≥ 70% of steady-state compute covered by Savings Plans or Reserved Instances.

### Spot Instances

- **Use for**: Dev/Test workloads, batch processing, CI/CD runners, stateless ECS/EKS worker nodes
- **Avoid for**: Any stateful or production workload requiring sustained availability
- **Spot Interruption Handling**: Two-minute interruption notice via Instance Metadata; graceful shutdown hooks; checkpoint strategies for long-running batch jobs
- **Diversified pools**: Always specify multiple instance families and sizes in Spot requests (Launch Templates with multiple overrides)

### Graviton (ARM64)

- **Target**: All new Lambda functions, ECS Fargate tasks, and EKS node group additions should use ARM64 / Graviton
- **Savings**: ~20% vs equivalent x86 Intel instances; ~40% better price/performance for many workloads
- **Compatibility**: Most Linux workloads are compatible; verify container images support `linux/arm64`; Java, Python, Node fully supported

### Cost Anomaly Detection

- Enable AWS Cost Anomaly Detection for each linked account
- Threshold: alert on anomalies > £50/day or > 20% above baseline
- Route anomaly alerts to ServiceNow / cost centre owner
- Monthly FinOps review: cost explorer report per application tag

### Right-Sizing

- Use **AWS Compute Optimizer** recommendations for EC2, ECS, Lambda, and EBS
- Right-sizing review: 30 days after initial deployment (utilisation < 40% average = candidate for downsizing)
- **Target utilisation**: CPU 60-80%; memory 60-80%; EBS IOPS 50-70% of provisioned
