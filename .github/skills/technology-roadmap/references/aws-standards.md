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

## Governance

- **AWS Organisations**: Multi-account architecture (Production, Dev/Test, Shared Services, Security)
- **AWS Config**: Compliance rules aligned with CIS Level 2
- **Trusted Advisor**: Review weekly for cost, security, and performance recommendations
- **Cost Explorer + Savings Plans**: Reserved capacity for stable workloads
- **Resource Groups + Tag Policies**: Enforce mandatory tagging
