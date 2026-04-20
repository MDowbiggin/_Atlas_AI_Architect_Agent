# Azure Standards

## Overview

Microsoft Azure is the **strategic primary cloud platform** for EMIS/Optum. All new cloud workloads should use Azure unless there is a documented justification for AWS or on-prem.

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
