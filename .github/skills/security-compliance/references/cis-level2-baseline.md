# CIS Level 2 Hardening Baseline

## Overview

The Center for Internet Security (CIS) Benchmarks provide prescriptive hardening guidance. EMIS/Optum mandates **CIS Level 2** compliance for all production infrastructure. Level 2 extends Level 1 with additional controls that may reduce functionality but provide stronger security.

## Azure CIS Benchmark (v2.1+)

### Identity & Access Management

| # | Control | Requirement |
|---|---------|-------------|
| 1.1 | Security Defaults / Conditional Access | Conditional Access policies enforced (not Security Defaults) |
| 1.2 | MFA | Enabled for ALL users (not just admins) |
| 1.3 | Guest access | Restricted; guest invite policy set to "Admins only" |
| 1.4 | Self-service password reset | Enabled with MFA verification |
| 1.5 | Password policy | Minimum 14 characters; no expiration (per NIST 800-63B) but compromised password detection enabled |
| 1.6 | PIM | Enabled for all Global Admin and privileged roles |
| 1.7 | Named locations | Trusted locations defined for Conditional Access |

### Microsoft Defender for Cloud

| # | Control | Requirement |
|---|---------|-------------|
| 2.1 | Defender for Cloud | Enabled on all subscriptions |
| 2.2 | Security contact | Email and phone configured; notifications for high-severity alerts |
| 2.3 | Auto-provisioning | Log Analytics agent or AMA auto-provisioned to all VMs |
| 2.4 | Defender plans | Servers, Storage, SQL, Containers, App Service, Key Vault plans enabled |
| 2.5 | Security policy | Custom policy initiative applied (EMIS/Optum standards) |

### Storage

| # | Control | Requirement |
|---|---------|-------------|
| 3.1 | Secure transfer | "Secure transfer required" enabled (HTTPS only) |
| 3.2 | Public access | Blob public access disabled at account level |
| 3.3 | Storage encryption | Microsoft-managed keys minimum; CMK for Confidential/Restricted data |
| 3.4 | Network access | Default deny; private endpoints or selected VNets only |
| 3.5 | Soft delete | Enabled with 14-day retention |
| 3.6 | Logging | Storage Analytics logging enabled; sent to Log Analytics |

### Networking

| # | Control | Requirement |
|---|---------|-------------|
| 6.1 | RDP access | No public RDP (port 3389) allowed via NSG |
| 6.2 | SSH access | No public SSH (port 22) allowed via NSG |
| 6.3 | NSG on all subnets | Every subnet must have an NSG attached |
| 6.4 | Network Watcher | Enabled in all regions with active subscriptions |
| 6.5 | NSG Flow Logs | Enabled for all production NSGs; v2 format; Traffic Analytics on |

### Virtual Machines

| # | Control | Requirement |
|---|---------|-------------|
| 7.1 | VM agent | Azure Monitor Agent (AMA) installed on all VMs |
| 7.2 | OS disk encryption | Azure Disk Encryption or Encryption at Host enabled |
| 7.3 | Endpoint protection | Defender for Endpoint or approved EDR installed |
| 7.4 | System updates | Azure Update Manager configured; compliance monitored |
| 7.5 | Diagnostic settings | Boot diagnostics and guest metrics enabled |

### Database

| # | Control | Requirement |
|---|---------|-------------|
| 4.1 | Auditing | SQL auditing enabled; logs to Log Analytics |
| 4.2 | TDE | Transparent Data Encryption enabled |
| 4.3 | Firewall | Default deny; only approved IPs/VNets |
| 4.4 | Azure AD auth | Azure AD authentication enabled (preferred over SQL auth) |
| 4.5 | Advanced Threat Protection | Enabled for all SQL databases |

### Logging & Monitoring

| # | Control | Requirement |
|---|---------|-------------|
| 5.1 | Diagnostic settings | Enabled for all resources; sent to Log Analytics workspace |
| 5.2 | Activity Log | Forwarded to Log Analytics; retention ≥ 90 days |
| 5.3 | Activity Log alerts | Configured for: Create/Update NSG, Delete NSG, Create/Update Policy Assignment |
| 5.4 | Key Vault logging | Diagnostic logging enabled for all Key Vaults |
| 5.5 | Resource locks | CanNotDelete lock on all production resource groups |

## AWS CIS Benchmark (v3.0+)

### Identity & Access Management

| # | Control | Requirement |
|---|---------|-------------|
| 1.1 | Root account | MFA enabled; no access keys; usage monitored via CloudTrail |
| 1.2 | MFA | Enabled for all IAM users with console access |
| 1.3 | Access keys | Rotated within 90 days; inactive keys disabled |
| 1.4 | Password policy | 14+ characters, uppercase, lowercase, numbers, symbols |
| 1.5 | IAM policies | No inline policies on users; use groups/roles |
| 1.6 | SCP | Guardrail SCPs applied at OU level |

### Logging

| # | Control | Requirement |
|---|---------|-------------|
| 3.1 | CloudTrail | Enabled in all regions; multi-region trail |
| 3.2 | CloudTrail log validation | Log file integrity validation enabled |
| 3.3 | CloudTrail S3 bucket | Not publicly accessible; SSE-S3/SSE-KMS encryption |
| 3.4 | CloudWatch integration | CloudTrail integrated with CloudWatch Logs |
| 3.5 | AWS Config | Enabled in all regions; recording all resource types |
| 3.6 | VPC Flow Logs | Enabled for all VPCs; sent to CloudWatch/S3 |

### Networking

| # | Control | Requirement |
|---|---------|-------------|
| 5.1 | Default SG | No inbound rules in default security group |
| 5.2 | No public RDP | Port 3389 not open to 0.0.0.0/0 |
| 5.3 | No public SSH | Port 22 not open to 0.0.0.0/0 |
| 5.4 | VPC peering routing | Least-privilege routing tables for peered VPCs |
| 5.5 | VPC Flow Logs | Enabled for all VPCs; sent to CloudWatch Logs; Version 5 |
| 5.6 | Security Groups | Reference by SG ID not CIDR where possible; no 0.0.0.0/0 on administrative ports |
| 5.7 | Network ACLs | Restrict ingress to only required ports; no 0.0.0.0/0 on sensitive ports |

### Compute (EC2 & AMI)

| # | Control | Requirement |
|---|---------|-------------|
| 6.1 | IMDSv2 | Required on all EC2 instances; IMDSv1 disabled (SCP + Config rule) |
| 6.2 | EBS encryption | Default EBS encryption enabled at account level (KMS) |
| 6.3 | Public AMI | No AMIs shared publicly without security review |
| 6.4 | Instance Profile | All EC2 instances use an IAM instance profile; no access keys on instances |
| 6.5 | Systems Manager agent | SSM Agent installed on all instances; used for patching and session management |
| 6.6 | Public IP | No public IP addresses on EC2 instances in application or database subnets |
| 6.7 | Snapshots | EBS snapshots not shared publicly; encrypted at rest |

### Storage (S3)

| # | Control | Requirement |
|---|---------|-------------|
| 7.1 | Block Public Access | Enabled at account level (all 4 settings) — SCP-enforced |
| 7.2 | Bucket encryption | SSE-S3 minimum; SSE-KMS CMK for Confidential/Restricted data |
| 7.3 | Versioning | Enabled for buckets containing: Config delivery, CloudTrail logs, Terraform state, application data backups |
| 7.4 | MFA Delete | Enabled on Log Archive buckets containing immutable audit logs |
| 7.5 | Bucket policy | Deny HTTP (`aws:SecureTransport: false`); deny `s3:*` to `*` without explicit allow |
| 7.6 | Lifecycle policy | Configured; transition to Glacier/Intelligent-Tiering after retention threshold |
| 7.7 | Replication | Cross-region replication to eu-west-1 for Tier 1 critical data |
| 7.8 | Object Lock | Enabled for Log Archive and compliance-retention buckets (WORM) |

### Database (RDS)

| # | Control | Requirement |
|---|---------|-------------|
| 8.1 | Encryption at rest | KMS encryption enabled on all RDS instances and Aurora clusters |
| 8.2 | Encryption in transit | `force_ssl=1` parameter group setting; TLS connections required |
| 8.3 | Multi-AZ | Enabled for all production RDS instances |
| 8.4 | Automated backups | Enabled; minimum 7-day retention (30-day for production) |
| 8.5 | Public access | `publicly_accessible = false` on all RDS instances |
| 8.6 | IAM authentication | Enabled; prefer IAM DB auth over username/password for application connections |
| 8.7 | Enhanced monitoring | Enabled (60-second granularity for production) |
| 8.8 | Performance Insights | Enabled; 7-day free retention; 2 years paid for production |
| 8.9 | Minor version upgrade | Auto minor version upgrades enabled |
| 8.10 | Deletion protection | Enabled on all production RDS instances |

### KMS & Secrets

| # | Control | Requirement |
|---|---------|-------------|
| 9.1 | Key rotation | Automatic rotation enabled for all customer-managed KMS CMKs (annual) |
| 9.2 | Secrets Manager rotation | Automatic rotation enabled for all database credentials and API keys |
| 9.3 | No plaintext secrets | No hardcoded secrets in code, Lambda environment variables, or CloudFormation templates |
| 9.4 | KMS key policies | Deny `kms:*` to `*` (no full admin via key policy alone); require IAM policy + key policy |

### Monitoring & Alerting

| # | Control | Requirement |
|---|---------|-------------|
| 10.1 | CloudTrail metric filters | Configured for: Root account usage, IAM policy changes, CloudTrail config changes, S3 bucket policy changes, failed console logins |
| 10.2 | GuardDuty high severity | CloudWatch alarm → SNS → PagerDuty / ServiceNow on CRITICAL/HIGH findings |
| 10.3 | Security Hub findings | Events routed to ServiceNow via EventBridge; Critical → P1 ticket |
| 10.4 | Unused credentials | Config rule: IAM credential age > 90 days → alert |
| 10.5 | Root account usage | CloudTrail + EventBridge rule; alert immediately on any root account API call |
| 10.6 | Budget alerts | AWS Budgets configured per account at 80% and 100% of monthly budget |

## OS Hardening (CIS Level 2)

### Windows Server 2022

Key controls (subset — full benchmark applied via Group Policy / DSC):

- Password policy: 14+ characters, lockout after 5 attempts for 30 minutes
- Audit policy: Success + Failure for Logon, Account Management, Policy Change, Object Access
- Windows Firewall: Enabled on all profiles; deny inbound by default
- Remote Desktop: NLA required; restricted to authorised groups; session timeout 15 minutes
- Services: Disable unnecessary services (Print Spooler, LLMNR, NetBIOS)
- SMB: Disable SMBv1; require signing
- TLS: Disable TLS 1.0/1.1; enable TLS 1.2/1.3 only
- PowerShell: Script block logging + transcription enabled; Constrained Language Mode for non-admins

### Red Hat Enterprise Linux 9

Key controls (subset — full benchmark applied via Ansible hardening role):

- SSH: Protocol 2 only; PermitRootLogin no; MaxAuthTries 4; idle timeout 300s
- Password: minlen=14; dcredit=-1; ucredit=-1; lcredit=-1; ocredit=-1; remember=5
- Audit: auditd enabled; rules for privileged commands, file access, user/group changes
- Filesystem: nodev, nosuid, noexec on /tmp, /var/tmp, /dev/shm

## Container & Kubernetes Hardening (CIS Benchmarks)

### Docker / Container Images

| # | Control | Requirement |
|---|---------|-------------|
| C.1 | Base image | Use minimal, trusted base images (distroless or official vendor images); no `latest` tag in production |
| C.2 | Non-root user | Container processes run as non-root (UID ≥ 1000); `USER` instruction set in Dockerfile |
| C.3 | Read-only filesystem | Root filesystem mounted read-only where possible; write paths explicitly defined |
| C.4 | No privileged containers | `--privileged` flag disallowed; validate via admission controller (OPA/Kyverno) |
| C.5 | Secrets | No secrets in Dockerfile, environment variables, or image layers; use Azure Key Vault / AWS Secrets Manager CSI driver |
| C.6 | Image scanning | Images scanned for CVEs in CI/CD pipeline (Trivy / ECR scanning / Defender for Containers); HIGH/CRITICAL CVEs block pipeline |
| C.7 | Image signing | Images signed (Cosign / Notation); admission policy validates signature before deployment |
| C.8 | SBOM | Software Bill of Materials generated for every image build; stored in registry or artefact store |

### AKS (Azure Kubernetes Service)

| # | Control | Requirement |
|---|---------|-------------|
| AKS.1 | Private cluster | API server is private (not internet-accessible) |
| AKS.2 | Azure AD integration | Azure AD authentication enabled; RBAC at cluster and namespace level |
| AKS.3 | Workload Identity | Workload Identity used for pod-level Azure access; no service account tokens with Azure permissions |
| AKS.4 | Network policy | Network policies enforced (Calico or Azure CNI); default deny between namespaces |
| AKS.5 | Node hardening | CIS Level 2 OS hardening applied to node pools; auto-upgrades enabled for patch releases |
| AKS.6 | Admission control | OPA Gatekeeper or Kyverno deployed; policies enforce: no privileged, no latest tag, non-root user, resource limits |
| AKS.7 | Secret encryption | etcd secrets encrypted at rest with CMK |
| AKS.8 | Audit logging | Kubernetes audit logs and diagnostic settings forwarded to Log Analytics |
| AKS.9 | Container insights | Azure Monitor Container Insights enabled; Dynatrace OneAgent DaemonSet deployed |
| AKS.10 | Image pull | Images pulled only from ACR (private); `imagePullPolicy: Always` for production workloads |

### EKS (AWS Elastic Kubernetes Service)

| # | Control | Requirement |
|---|---------|-------------|
| EKS.1 | Private endpoint | EKS cluster API endpoint private; no public access (or restricted to known CIDRs if unavoidable) |
| EKS.2 | IRSA | IAM Roles for Service Accounts (IRSA) used for all pod-level AWS access; no EC2 instance profile with broad permissions |
| EKS.3 | Network policy | Calico or VPC-CNI network policies enforced; default deny between namespaces |
| EKS.4 | Node hardening | CIS AL2/AL2023 benchmark on node groups; managed node groups preferred; launch template with hardened AMI |
| EKS.5 | IMDSv2 | IMDSv2 required on EKS nodes (hop limit = 1 for containers) |
| EKS.6 | Secrets encryption | Kubernetes secrets encrypted with a KMS CMK (envelope encryption) |
| EKS.7 | Admission control | OPA Gatekeeper or Kyverno; policies match AKS.6 above |
| EKS.8 | Audit logging | EKS control plane logging enabled (API, audit, authenticator, scheduler, controller manager) → CloudWatch Logs |
| EKS.9 | GuardDuty for EKS | GuardDuty EKS Protection enabled (Runtime Monitoring + Audit Log monitoring) |
| EKS.10 | ECR image scanning | ECR enhanced scanning enabled; CRITICAL findings block deployment via deployment policy |
- Network: IP forwarding disabled; ICMP redirects rejected; TCP SYN cookies enabled
- Services: Disable unused services (avahi, cups, dhcpd); firewalld enabled
- SELinux: Enforcing mode; targeted policy
- Logging: rsyslog forwarding to centralised log server; journald persistent storage

## Compliance Automation

| Tool | Platform | Purpose |
|------|----------|---------|
| Azure Policy (CIS initiative) | Azure | Automated compliance assessment and remediation |
| AWS Config Rules (CIS conformance pack) | AWS | Automated compliance assessment |
| Ansible CIS Hardening Roles | Linux/Windows | Automated OS hardening |
| Group Policy (CIS GPO templates) | Windows | Automated Windows hardening |
| Defender for Cloud Regulatory Compliance | Azure | Dashboard and reporting |
| AWS Security Hub | AWS | Centralised compliance findings |
