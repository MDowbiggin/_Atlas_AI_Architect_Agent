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
