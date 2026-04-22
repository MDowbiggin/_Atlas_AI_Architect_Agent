# On-Premises & VMware Standards

## Overview

On-premises infrastructure remains a **tactical** platform at EMIS/Optum, primarily for legacy workloads, latency-sensitive applications, and data sovereignty requirements. The strategic direction is to migrate to Azure where possible, but on-prem will persist for specific use cases.

> **Critical 2026 Decision Point**: The VMware/Broadcom licence renewal falls in **October 2026**. The Broadcom acquisition of VMware has fundamentally changed the commercial model (subscription-based, VCF bundles, elimination of perpetual licences). An architecture and commercial assessment must be completed by **Q1 2026** to inform the renewal or migration decision. See the [Broadcom/VCF Renewal Assessment](#broadcom--vmware-cloud-foundation-vcf-9-renewal-assessment) section below.

## VMware vSphere Standards

### Supported Versions

| Component | Strategic | Tactical | Containment |
|-----------|-----------|----------|-------------|
| vSphere / ESXi | 8.0 U2+ | 7.0 U3+ | 6.x (migrate immediately) |
| vCenter | 8.0 U2+ | 7.0 U3+ | 6.x (migrate immediately) |
| vSAN | 8.0 | 7.0 U3 | — |
| NSX | NSX 4.x | NSX-T 3.2+ | NSX-V (end of life) |

### Compute Standards

- **Cluster Sizing**: Minimum N+1 host redundancy per cluster
- **HA**: VMware HA enabled with admission control (reserve capacity for 1 host failure)
- **DRS**: Distributed Resource Scheduler enabled (fully automated for production)
- **Resource Pools**: Use for workload isolation and resource guarantees; do not nest excessively
- **VM Hardware Version**: Keep within N-2 of latest supported version
- **CPU/Memory**: Right-size VMs; monitor via Dynatrace/vROps for optimisation opportunities

### Storage Standards (vSAN)

- **Policy-Based Storage**: Use VM Storage Policies to define RAID level, stripe width, and fault tolerance
- **Fault Tolerance**: FTT=1 (RAID-1) minimum for production; FTT=2 for mission-critical
- **Deduplication & Compression**: Enable on all-flash clusters
- **Capacity Planning**: Maintain ≥ 25% free capacity (slack space) for vSAN health
- **Data-at-Rest Encryption**: Enable for clusters hosting sensitive data

### Networking Standards (NSX)

- **Micro-Segmentation**: Use NSX distributed firewall for east-west traffic control
- **Logical Switching**: NSX overlay for network isolation between tenants/environments
- **Load Balancing**: NSX Advanced Load Balancer or F5 BIG-IP (on-prem)
- **Edge Services**: NSX Edge for north-south traffic, NAT, and VPN termination

## Physical Infrastructure

### Server Standards

| Component | Standard |
|-----------|----------|
| Server Platform | Dell PowerEdge R750/760 or HPE ProLiant DL380 Gen10+ |
| Firmware | Keep within vendor-supported versions; quarterly patch cycle |
| BIOS/UEFI | Secure Boot enabled; TPM 2.0 for attestation |
| BMC/iDRAC/iLO | Dedicated management network; latest firmware; default credentials changed |

### Storage (SAN/NAS)

| Component | Standard |
|-----------|----------|
| Primary SAN | NetApp AFF/FAS or Dell PowerStore |
| Protocols | NFS v4.1, iSCSI, FC (Fibre Channel) as appropriate |
| RAID | RAID-DP (NetApp) or RAID-6 minimum for production |
| Snapshots | Hourly for production databases; daily for general file shares |
| Replication | SnapMirror / RecoverPoint for DR replication |
| Encryption | NetApp NVE / self-encrypting drives for sensitive data |

### Network (Physical)

| Component | Standard |
|-----------|----------|
| Core Switches | Cisco Nexus 9000 or Arista 7000 series |
| Access Switches | Cisco Catalyst 9000 series |
| Firewalls | Palo Alto PA-5200/PA-3200 series |
| Load Balancers | F5 BIG-IP (on-prem) |
| WAN / SD-WAN | [INTERNAL — populate from Confluence for specific vendor/model] |

## Hybrid Integration

### Connectivity to Azure

| Method | Use Case | Bandwidth |
|--------|----------|-----------|
| ExpressRoute | Production workloads (primary) | 1 Gbps / 10 Gbps |
| Site-to-Site VPN | Backup connectivity, dev/test | Up to 1.25 Gbps |
| Azure Arc | Unified management of on-prem VMs | N/A (agent-based) |

### Identity Integration

- Azure AD Connect for directory synchronisation
- Pass-through authentication or federation (ADFS) per current configuration
- Conditional Access policies apply to hybrid-joined devices

### Management Integration

- **Azure Arc**: Enrol on-prem servers for unified Azure Policy, Update Management, and Defender for Cloud
- **Dynatrace OneAgent**: Deploy on all on-prem VMs for consistent APM across hybrid estate
- **ServiceNow CMDB**: All on-prem CIs must be registered and maintained in ServiceNow

## Migration Guidance (On-Prem to Cloud)

### Assessment

1. Inventory current VMs, dependencies, and performance baselines using Dynatrace and Azure Migrate
2. Categorise workloads: migrate, modernise, retain, or retire
3. Identify blockers: licensing, latency requirements, compliance constraints
4. Produce a migration wave plan

### Execution

- **Lift-and-Shift**: Azure Migrate / ASR for VM replication
- **Database Migration**: Azure DMS for SQL Server, PostgreSQL migrations
- **File Services**: Azure File Sync for phased file server migration
- **Application**: Staged migration with parallel running and DNS cutover

### Post-Migration

- Decommission source VMs after validation period (minimum 30 days)
- Update CMDB and documentation
- Validate monitoring and alerting in Azure
- Perform cost review against initial estimates

---

## Broadcom / VMware Cloud Foundation (VCF 9) Renewal Assessment

### Background

In November 2023, Broadcom completed its acquisition of VMware. Since then, Broadcom has:
- Eliminated perpetual licences; moved to **subscription-only** commercial model
- Discontinued standalone product sales (vSphere, vSAN, NSX sold separately); now sold only as **VMware Cloud Foundation (VCF)** bundles
- Increased pricing materially for most enterprise customers
- Reduced partner channel and created commercial uncertainty

**EMIS/Optum's current VMware agreement expires October 2026**. This is a critical architectural and commercial decision point.

### VMware Cloud Foundation (VCF 9) Overview

VCF 9 is the current Broadcom offering. It bundles:

| Component | Included in VCF |
|-----------|----------------|
| vSphere (ESXi + vCenter) | ✅ |
| vSAN (hyper-converged storage) | ✅ |
| NSX (network virtualisation + micro-segmentation) | ✅ |
| Aria Suite (operations, automation, log insight) | ✅ (VCF+ / subscription tier) |
| HCX (workload mobility) | ✅ (VCF+ / subscription tier) |

**Licensing model**: Per-core subscription; minimum 16 cores per CPU socket; annual subscription.

### Assessment Options

| Option | Description | When to Consider |
|--------|-------------|-----------------|
| **Option A — Renew VCF 9** | Continue with VMware/Broadcom under subscription model | Significant on-prem workload commitment; 5+ year dependency; VCF features used (vSAN, NSX) |
| **Option B — Migrate to Azure** | Accelerate cloud migration; decommission on-prem estate | Workloads are cloud-ready; Azure VMware Solution (AVS) or re-platform to native PaaS |
| **Option C — Azure VMware Solution (AVS)** | Run VMware on dedicated Azure hardware; Microsoft-managed vSphere/vSAN/NSX; no licence renegotiation with Broadcom | Lift-and-shift without re-platforming; retain VMware operational model; managed renewal with Microsoft |
| **Option D — Alternative Hypervisor** | Migrate from VMware to Hyper-V, Proxmox, or bare-metal | Specific workload types; high Broadcom cost sensitivity; significant re-engineering effort |

### Decision Criteria

When assessing the renewal, evaluate against:

1. **Cost**: Compare VCF 9 subscription cost vs. Option B (cloud)/Option C (AVS)/Option D (hypervvisor change). Include migration cost (one-off) vs. increased licence cost (ongoing).
2. **Workload suitability**: Are remaining on-prem workloads cloud-ready, or do they have specific on-prem requirements (latency, clinical systems, data sovereignty edge cases)?
3. **Operational model**: Does the team have skills for the chosen option? AVS retains VMware skills; migration requires cloud-native upskilling.
4. **Vendor risk**: Broadcom's commercial behaviour post-acquisition increases concentration risk; diversification has strategic value.
5. **Strategic alignment**: Does continued on-prem investment support or conflict with the cloud-first strategy?

### Assessment Timeline

| Milestone | Target Date | Owner |
|-----------|-------------|-------|
| Complete on-prem workload inventory and cloud-readiness assessment | Q1 2026 | Infrastructure Architecture |
| Commercial options analysis (VCF 9 vs. AVS vs. migrate) | Q1 2026 | Architecture + Commercial |
| Submit ADR to ARB for option selection | Q2 2026 | Infrastructure Architecture |
| ARB approval and programme initiation | Q2 2026 | ARB |
| Contract renewal or migration programme launch | Q3 2026 | Programme / Procurement |
| Renewal deadline | **October 2026** | CTO / Procurement |

### Key Contacts

- **HPe / VMware Account Team**: [INTERNAL — populate: account executive contact]
- **Microsoft AVS Specialist**: [INTERNAL — populate: Microsoft account team contact for AVS]
- **Broadcom Renewal Negotiation**: [INTERNAL — populate: procurement lead]
- **Architecture Lead**: Infrastructure Solutions Architecture team
