# Low-Level Design (LLD) Template

## Template

```markdown
# Low-Level Design — [Solution Name]

## Document Control

| Item | Detail |
|------|--------|
| Document ID | LLD-[XXXX] |
| Version | 1.0 |
| Author | [Architect/Engineer name] |
| Date | YYYY-MM-DD |
| Status | Draft / In Review / Approved |
| Classification | Confidential |
| Related HLD | HLD-[XXXX] |
| Reviewers | [Names and roles] |
| Approver | [Name and role] |

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 0.1 | YYYY-MM-DD | [Name] | Initial draft |
| 1.0 | YYYY-MM-DD | [Name] | Approved version |

---

## 1. Overview

[Brief description of the solution referencing the HLD. The LLD provides configuration-level detail for implementation.]

**Scope**: This LLD covers [specific components covered in this document].

## 2. Compute Configuration

### 2.1 Virtual Machines

| Attribute | Server 1 | Server 2 |
|-----------|----------|----------|
| Name | [naming convention] | [naming convention] |
| Role | [Web/App/DB/etc.] | [Role] |
| OS | Windows Server 2022 / RHEL 9 | [OS] |
| SKU | Standard_D4s_v5 | [SKU] |
| vCPU | 4 | [vCPU] |
| Memory | 16 GB | [Memory] |
| Region | UK South | [Region] |
| Availability Zone | 1 | 2 |
| Resource Group | rg-[app]-[env]-[region] | [RG] |
| Subscription | [Subscription name] | [Subscription] |
| OS Disk | 128 GB Premium SSD P10 | [Disk] |
| Data Disks | 256 GB Premium SSD P15 (E:) | [Disks] |
| NIC | Subnet: snet-[app]-app | [NIC] |
| Private IP | [IP address] | [IP] |
| NSG | nsg-[app]-[env]-app | [NSG] |
| Backup Policy | Daily, 30-day retention | [Policy] |
| Tags | CostCentre=XX, Env=Prod, Owner=XX, App=XX, Project=XX | [Tags] |
| Extensions | AMA, Dynatrace OneAgent, Defender | [Extensions] |

### 2.2 AKS Cluster (if applicable)

| Attribute | Value |
|-----------|-------|
| Cluster Name | aks-[app]-[env]-[region] |
| Kubernetes Version | [Version] |
| Network Plugin | Azure CNI |
| Network Policy | Calico |
| Private Cluster | Yes |
| System Node Pool | 3x Standard_D4s_v5 |
| User Node Pool | [Count]x [SKU] |
| Autoscaler | Min: [X], Max: [X] |
| ACR Integration | acr[name].azurecr.io |
| Ingress | Azure Application Gateway Ingress Controller |
| Identity | Workload Identity |
| Monitoring | Dynatrace OneAgent DaemonSet |

## 3. Storage Configuration

### 3.1 Storage Accounts

| Attribute | Value |
|-----------|-------|
| Name | st[app][env][region][xxx] |
| Type | StorageV2 |
| Replication | ZRS (production) / LRS (dev) |
| Access Tier | Hot |
| Network | Private endpoint only; deny public access |
| Encryption | Microsoft-managed keys / CMK (if Confidential/Restricted) |
| Soft Delete | 14 days |
| Containers | [List containers and purpose] |

### 3.2 Database

| Attribute | Value |
|-----------|-------|
| Service | Azure SQL Database / PostgreSQL Flexible Server |
| Server Name | sql-[app]-[env]-[region] |
| Database Name | [database name] |
| Tier | Business Critical / General Purpose |
| vCores | [Count] |
| Storage | [Size] GB |
| Backup Retention | 35 days (PITR) + [LTR policy] |
| Geo-Replication | [Yes/No — target region] |
| Authentication | Azure AD + SQL (read-only service account) |
| Firewall | Private endpoint only |
| TDE | Enabled (Microsoft-managed key) |
| Auditing | Enabled → Log Analytics workspace |

## 4. Network Configuration

### 4.1 VNet & Subnets

| Subnet Name | CIDR | NSG | Purpose | Delegations |
|-------------|------|-----|---------|-------------|
| snet-[app]-web | 10.X.X.X/24 | nsg-[app]-web | App Gateway | Microsoft.Web/serverFarms (if App Service) |
| snet-[app]-app | 10.X.X.X/24 | nsg-[app]-app | Application servers | None |
| snet-[app]-data | 10.X.X.X/24 | nsg-[app]-data | Database endpoints | None |
| snet-[app]-pe | 10.X.X.X/24 | nsg-[app]-pe | Private endpoints | None |

### 4.2 NSG Rules

#### nsg-[app]-app

| Priority | Name | Direction | Source | Destination | Port | Protocol | Action |
|----------|------|-----------|--------|-------------|------|----------|--------|
| 100 | Allow-AppGw-To-App | Inbound | snet-web | snet-app | 443 | TCP | Allow |
| 110 | Allow-App-To-DB | Outbound | snet-app | snet-data | 1433 | TCP | Allow |
| 200 | Allow-Mgmt | Inbound | snet-mgmt | snet-app | 22,3389 | TCP | Allow |
| 4096 | Deny-All-Inbound | Inbound | * | * | * | * | Deny |

### 4.3 Private Endpoints

| Resource | Private Endpoint Name | Subnet | Private DNS Zone |
|----------|----------------------|--------|-----------------|
| Azure SQL | pe-sql-[app]-[env] | snet-pe | privatelink.database.windows.net |
| Storage | pe-st-[app]-[env] | snet-pe | privatelink.blob.core.windows.net |
| Key Vault | pe-kv-[app]-[env] | snet-pe | privatelink.vaultcore.azure.net |

### 4.4 DNS Records

| Record | Type | Value | Zone |
|--------|------|-------|------|
| [app]-[env] | A | [Private IP] | [internal zone] |
| [app]-[env]-sql | CNAME | [Private endpoint FQDN] | [internal zone] |

## 5. Security Configuration

### 5.1 RBAC Assignments

| Principal | Role | Scope |
|-----------|------|-------|
| SG-[app]-Admins | Contributor | rg-[app]-prod-uksouth |
| SG-[app]-Readers | Reader | rg-[app]-prod-uksouth |
| MI-[app]-prod | Key Vault Secrets User | kv-[app]-prod |
| MI-[app]-prod | Storage Blob Data Reader | st[app]prod |

### 5.2 Key Vault Configuration

| Attribute | Value |
|-----------|-------|
| Name | kv-[app]-[env]-[region] |
| SKU | Standard |
| Network | Private endpoint only |
| Soft Delete | Enabled (90 days) |
| Purge Protection | Enabled |
| Access Model | RBAC (not access policies) |
| Secrets | [List secrets stored — not values!] |
| Certificates | [List certificates managed] |

### 5.3 Managed Identity

| Identity | Type | Used By | Permissions |
|----------|------|---------|-------------|
| MI-[app]-prod | System-assigned | [VM/App Service/AKS] | Key Vault read, Storage read, SQL connect |

## 6. Monitoring Configuration

### 6.1 Dynatrace

| Configuration | Value |
|--------------|-------|
| Host Group | [env]-[app]-[tier] |
| Management Zone | [app]-[env] |
| Synthetic Monitors | HTTP: [URLs monitored] |
| Custom Metrics | [Any custom metrics configured] |
| Alerting Profile | [Profile name] — routes to ServiceNow |

### 6.2 Azure Monitor

| Alert Rule | Metric | Condition | Severity | Action |
|-----------|--------|-----------|----------|--------|
| High CPU | CPU % | > 90% for 5 min | P2 | ServiceNow ticket |
| Disk Space | Disk % Free | < 10% | P2 | ServiceNow ticket |
| VM Unavailable | Heartbeat | Missing > 5 min | P1 | PagerDuty + ServiceNow |

### 6.3 Log Analytics

| Log Source | Workspace | Retention |
|-----------|-----------|-----------|
| VM diagnostics | la-[app]-[env] | 90 days |
| NSG Flow Logs | la-[app]-[env] | 90 days |
| Azure SQL Audit | la-[app]-[env] | 365 days |

## 7. Backup Configuration

| Resource | Vault/Policy | Schedule | Retention | Tested |
|----------|-------------|----------|-----------|--------|
| VM1 | rsv-[app]-[env] / Daily | 23:00 UTC | 30 days daily, 12 months monthly | ✅ / ❌ |
| SQL DB | Built-in PITR | Continuous | 35 days PITR + 12 months LTR | ✅ / ❌ |

## 8. IaC Reference

| Component | Repository | Path | Module |
|-----------|-----------|------|--------|
| Infrastructure | [ADO repo URL] | /environments/prod/ | compute, networking, storage |
| Configuration | [ADO repo URL] | /ansible/playbooks/ | [playbook names] |
| Pipeline | [ADO repo URL] | /pipelines/ | [pipeline name] |

## 9. Implementation Checklist

- [ ] Resource Group created with tags
- [ ] VNet/Subnets provisioned with NSGs
- [ ] Private endpoints created and DNS configured
- [ ] VMs provisioned with extensions
- [ ] Database provisioned with firewall and encryption
- [ ] Storage accounts provisioned with access controls
- [ ] Key Vault provisioned with secrets
- [ ] RBAC assignments applied
- [ ] Monitoring configured (Dynatrace + Azure Monitor)
- [ ] Backup configured and first backup verified
- [ ] IaC committed and pipeline tested
- [ ] CMDB CIs created with relationships
```
