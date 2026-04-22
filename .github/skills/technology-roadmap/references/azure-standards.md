# Azure Standards

## Overview

Microsoft Azure is the **strategic secondary cloud platform** for EMIS/Optum. Use Azure when workloads are tightly integrated with Microsoft services (M365, Entra ID), when specific Azure PaaS services offer a materially better fit, or when existing Azure commitments make it more cost-effective. For all other workloads, AWS is the primary platform.

## Approved Regions

| Region | Use Case | Data Sovereignty |
|--------|----------|-----------------|
| **UK South** (London) | Primary production, DR target for UK West | UK data residency ✅ |
| **UK West** (Cardiff) | DR for UK South, secondary workloads | UK data residency ✅ |
| **North Europe** (Ireland) | Overflow, specific service availability | EU data residency ⚠️ Requires approval |
| **West Europe** (Netherlands) | Overflow, specific service availability | EU data residency ⚠️ Requires approval |

> **Rule**: All workloads handling UK patient data or PHI must reside in UK South or UK West. Any use of non-UK regions requires Data Protection and Compliance team approval.

## Compute Standards

### Virtual Machines

| Workload Type | Recommended SKU Series | Notes |
|--------------|----------------------|-------|
| General purpose | Standard_D v5 / v6 | Balanced CPU-to-memory; most common |
| Memory-optimised | Standard_E v5 / v6 | Databases, in-memory caching |
| Compute-optimised | Standard_F v5 | Batch processing, high-CPU workloads |
| GPU | Standard_NC / ND | ML/AI workloads only; requires approval |
| Burstable (Dev/Test) | Standard_B | Non-production only; cost-effective |

**Standards**:
- Use Availability Zones for production (minimum 2 zones)
- Use Managed Disks (Premium SSD P30+ for production; Standard SSD for dev/test)
- Enable Azure Backup with 30-day retention minimum
- Enable boot diagnostics and guest-level monitoring
- Apply mandatory resource tags: `CostCentre`, `Environment`, `Owner`, `Application`, `Project`

### Azure Kubernetes Service (AKS)

- **Version**: Keep within N-1 of latest stable release
- **Networking**: Azure CNI (not kubenet) with VNet integration
- **Cluster**: Private cluster (private API server endpoint)
- **Node Pools**: System pool (minimum 3 nodes, Standard_D4s_v5) + User pools sized per workload
- **Registry**: Azure Container Registry (ACR) with vulnerability scanning enabled
- **Identity**: Workload Identity (not pod-managed identity — deprecated)
- **Scaling**: Cluster Autoscaler + Horizontal Pod Autoscaler

### Azure App Service

- **Plan**: Premium v3 or Isolated v2 (for VNet integration)
- **Networking**: VNet integration for outbound; private endpoints for inbound
- **Scaling**: Auto-scale rules based on CPU/memory/request count
- **Slots**: Use deployment slots for zero-downtime deployments

## Storage Standards

| Service | Use Case | Tier |
|---------|----------|------|
| Azure Blob Storage | Object/file storage, backups, data lake | Hot (active), Cool (infrequent), Archive (compliance) |
| Azure Files | Shared file storage (SMB/NFS) | Premium for production; Standard for dev/test |
| Azure NetApp Files | High-performance NFS/SMB (SAP, databases) | Ultra/Premium as required |
| Azure Managed Disks | VM disks | Premium SSD (prod), Standard SSD (dev/test) |

**Standards**:
- Enable soft delete (14-day retention) for all blob storage
- Enable versioning for critical data
- Use geo-redundant storage (GRS) for production; locally-redundant (LRS) for dev/test
- Private endpoints for all storage accounts (no public access)

## Database Standards

| Service | Use Case | Notes |
|---------|----------|-------|
| Azure SQL Database | Relational (SQL Server workloads) | Business Critical tier for production |
| Azure Database for PostgreSQL - Flexible Server | Relational (open source) | General Purpose or Memory Optimised |
| Azure Cosmos DB | NoSQL, globally distributed | Use when multi-region or multi-model required |
| Azure Cache for Redis | Caching, session state | Premium tier with VNet injection for production |

**Standards**:
- Transparent Data Encryption (TDE) enabled by default
- Azure AD authentication preferred over SQL authentication
- Long-term backup retention (LTR) per data classification
- Private endpoints mandatory; no public endpoint access

## Networking Standards

- See the [Networking reference](./networking.md) for detailed standards
- All VNets must follow the Hub-and-Spoke topology
- Azure Firewall for centralised egress control
- Azure Bastion for administrative access (no public RDP/SSH)
- ExpressRoute for on-premises connectivity (VPN as backup)

## Identity & Access

- **Azure AD / Entra ID** as primary identity provider
- **Conditional Access** policies enforced (MFA, compliant device, location-based)
- **Privileged Identity Management (PIM)** for just-in-time admin access
- **RBAC** with least privilege; use built-in roles where possible
- **Managed Identities** for application-to-service authentication (no service account passwords)

## Governance & Policy

- **Azure Policy** for compliance enforcement (CIS Level 2, custom policies for EMIS/Optum standards)
- **Azure Blueprints / Landing Zones** for standardised environment provisioning
- **Management Groups** for hierarchical policy inheritance
- **Resource Locks** on production resources (CanNotDelete minimum)
- **Azure Cost Management** with budget alerts and advisor recommendations

---

## Monitoring & Observability

### Azure Monitor & Log Analytics

| Component | Standard |
|-----------|----------|
| **Log Analytics Workspace** | One workspace per environment (prod, non-prod); centralised workspace for security logs |
| **Diagnostic Settings** | All resources must emit diagnostic logs to Log Analytics; use Azure Policy to enforce |
| **Metrics** | Platform metrics auto-collected by Azure Monitor; custom metrics via Application Insights SDK |
| **Retention** | Hot tier: 30 days (Log Analytics); Cold/archive tier: 12 months minimum (for regulatory compliance) |
| **Alerts** | Metric and log-based alert rules; action groups route to PagerDuty (P1/P2) and email (P3/info) |
| **Workbooks** | Use Azure Monitor Workbooks for operational dashboards; share across the EMIS Architecture management group |

**Standards**:
- Every Azure resource must have diagnostic settings configured (enforce via Azure Policy)
- Dynatrace OneAgent deployed on all VMs and AKS node pools for application-level observability (Azure Monitor for platform, Dynatrace for APM)
- Application Insights connected to all Azure App Service and Azure Functions workloads
- Azure Network Watcher enabled in all subscriptions; NSG Flow Logs version 2 to storage and Log Analytics with Traffic Analytics

### Microsoft Defender for Cloud

Microsoft Defender for Cloud is the **mandatory cloud security posture management (CSPM)** platform for all Azure subscriptions.

| Plan | Scope | Notes |
|------|-------|-------|
| **Defender CSPM** | All subscriptions | Cloud Security Posture Management; Secure Score monitoring |
| **Defender for Servers Plan 2** | All production servers (VMs, ARC-enrolled on-prem) | Includes Microsoft Defender Antivirus, JIT VM Access, file integrity monitoring |
| **Defender for Containers** | All AKS clusters | Kubernetes threat detection, image scanning, admission control |
| **Defender for SQL** | All Azure SQL and PostgreSQL instances | SQL injection detection, anomalous query alerts |
| **Defender for Storage** | All storage accounts with sensitive data | Malware scanning, anomalous access detection |
| **Defender for Key Vault** | All Key Vaults | Unusual access, exfiltration attempts |
| **Defender for App Service** | All App Service plans | Threat detection for web application attacks |

**Standards**:
- Defender for Cloud Secure Score minimum threshold: **75%** (alert below; track as a KPI)
- Enable all Defender plans in production subscriptions; Defender CSPM minimum in all subscriptions
- Security alerts from Defender for Cloud flow to Microsoft Sentinel (or Log Analytics Security workspace) for SIEM correlation
- CIS Azure v2.0 compliance benchmark enabled in all subscriptions; resolve High findings within 30 days

### Azure Application Insights

- Connect to Azure App Service, Azure Functions, and AKS workloads
- Enable **distributed tracing** for microservices (correlation IDs across service boundaries)
- **Smart Detection**: Enable for anomaly detection on response times, failure rates
- **Availability tests**: Minimum one URL ping test per external endpoint; target: 99.9% availability
- Sampling: Configure adaptive sampling for high-throughput workloads to control data volume and cost

---

## API Management (Azure APIM)

Azure API Management is the **strategic API gateway** for Azure-hosted APIs exposed internally or externally.

### Use Cases

| Scenario | APIM Tier |
|----------|-----------|
| Production APIs (external or internal) | Standard v2 or Premium |
| Development / test APIs | Developer (non-SLA) |
| High-scale, multi-region | Premium with multiple units |

### Standards

- **Networking**: APIM in internal mode (private VNet injection); external gateway via Azure Front Door / Application Gateway + WAF
- **Authentication**: OAuth 2.0 / OIDC with Entra ID; validate JWT tokens in inbound policy
- **Rate Limiting**: Apply `rate-limit-by-key` and `quota` policies to all product subscriptions; prevent abuse
- **Versioning**: API versioning via URL path (`/v1/`, `/v2/`) or header; never break existing API versions without deprecation notice
- **Backend security**: Mutual TLS or managed identity for APIM-to-backend connections
- **Caching**: Enable response caching where appropriate to reduce backend load
- **Monitoring**: Enable Application Insights integration for all APIs; log requests, responses, and errors
- **Developer Portal**: Enable and maintain the developer portal for internal API consumers
- **Named Values**: Store secrets in Key Vault and reference as Named Values (never hardcode keys in policies)

### Policy Standards

```xml
<!-- Mandatory inbound policies for all APIs -->
<inbound>
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401">
        <openid-config url="https://login.microsoftonline.com/{tenantId}/.well-known/openid-configuration" />
        <audiences><audience>{audience}</audience></audiences>
    </validate-jwt>
    <rate-limit-by-key calls="1000" renewal-period="60" counter-key="@(context.Subscription?.Key ?? 'anonymous')" />
    <set-header name="X-Request-ID" exists-action="skip">
        <value>@(context.RequestId)</value>
    </set-header>
</inbound>
```

---

## Azure Front Door

Use Azure Front Door for global HTTP/HTTPS load balancing, WAF protection, and CDN for internet-facing workloads.

### Standards

- **SKU**: Standard or Premium (Premium for Private Link origin, Managed WAF rules, Bot protection)
- **WAF**: Enable WAF with Microsoft-managed rule sets (OWASP 3.2 + additional bot protection rules); mode set to **Prevention** (not Detection) in production
- **HTTPS only**: Redirect HTTP to HTTPS; enforce minimum TLS 1.2
- **Origin**: Use Private Link to connect to Azure origins (App Service, Load Balancer, Storage) — no public endpoints required
- **Routing**: Use route patterns to separate static content (CDN caching) from API traffic (no-cache)
- **Health Probes**: Configure health probes per origin group; use HTTPS probes; set appropriate probe intervals
- **Custom Domains**: All custom domains must have certificates managed via Azure-managed certificates or Key Vault integration
- **Logging**: Enable diagnostic logs to Log Analytics; access logs for WAF analysis
