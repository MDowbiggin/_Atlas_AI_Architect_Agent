# Software & Licence Costs

## Overview

Standard EMIS/Optum software and licence cost reference for use in Bills of Material (BoM), TCO analyses, and commercial bids. All pricing is **OpEx | Licence** (annual recurring cost) unless noted.

> **Pricing Date**: June 2026
> **Currency**: GBP
> **Important**: VMware pricing marked as POA must be confirmed via Softcat quote. Obtain current quotes for all POA items before including in a commercial proposal or BoM. New UHG-discounted pricing lines supersede Softcat-SCE pricing where both are listed — confirm with Commercial/Procurement which line applies to each engagement.

---

## Operating Systems

### Microsoft Windows Server

| Licence | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| Windows Server STD — 16-core | Softcat - SCE | £470.00 | |
| Windows Server STD — 2-core | Softcat - SCE | £41.40 | |
| Windows Server DC (Datacentre) — 16-core | Softcat - SCE | £1,668.96 | |
| Windows Server DC (Datacentre) — 2-core | Softcat - SCE | £208.80 | |

> **Licensing note**: Standard covers up to 2 VMs per licensed host. Datacentre covers unlimited VMs. Both require a minimum of 8 two-core packs (16 cores) per physical server. Azure Hybrid Benefit (AHUB) may allow use of on-prem licences with SA on Azure — validate eligibility before purchasing cloud instances.

### Linux

| Licence | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| CentOS 8 | CentOS Org | £0 | Open source. Note: CentOS 8 EOL December 2021; migrate to CentOS Stream, Rocky Linux, or Ubuntu |
| Ubuntu Server 19.10 | Ubuntu | £0 | Open source. Note: 19.10 is EOL; use 22.04 LTS or 24.04 LTS for new deployments |
| Red Hat Enterprise Linux (RHEL) | Softcat | £270.00 | Per server, per year |

---

## Database

### Microsoft SQL Server

| Licence | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| SQL Server Standard — 2-core (×2 min) — **TPG/EMIS Pricing** | SCE | £1,025.00 | Minimum purchase: 4 cores (2× two-core packs) |
| SQL Server Standard — 2-core (×2 min) — **UHG Pricing** | UHG % discount | £445.29 | Preferred pricing; confirm applicability with Commercial |
| SQL Server Enterprise — 2-core (×2 min) — **TPG/EMIS Pricing** | SCE | £2,936.04 | Minimum purchase: 4 cores (2× two-core packs) |
| SQL Server Enterprise — 2-core (×2 min) — **UHG Pricing** | UHG % discount | £1,707.60 | Preferred pricing; confirm applicability with Commercial |
| SQL Server External Connector (per host) | Softcat - SCE | £1,871.94 | Covers unlimited external users accessing SQL from a single server |

> **Licensing note**: Core-based licensing is required for server/cloud workloads. External Connector is an alternative to CALs for solutions accessed by a large or unknown number of external users (e.g., patient-facing applications).

---

## Virtualisation (VMware)

> ⚠️ All VMware pricing is subject to the Broadcom acquisition terms. The UHG/EMIS VMware VCF deal runs until **2032**. Standard unit pricing for vCenter, vRealize, vSphere, and vSAN is **POA** — obtain a current Softcat quote for each engagement. Do not include estimated VMware costs in a BoM without a confirmed quote.

| Product | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| vCenter Server 6 STD | Softcat | POA | Per instance |
| vRealize Operations 7 STD | Softcat | POA | Per CPU |
| vSphere 6 Enterprise Plus | Softcat | POA | Per CPU; up to 32 physical cores |
| vSphere 6 Enterprise | Softcat | POA | Per CPU; up to 32 physical cores |
| vSAN 6.2 Advanced | Softcat | POA | Per CPU |
| VMware Site Recovery Manager 8 STD | Softcat | POA | Per VM |
| **VMware VCF (Physical core) — EMIS/Optum Pricing** | UHG → Broadcom deal (until 2032) | **£893.04 per physical core per vSAN host** | Current agreed rate under the UHG/Broadcom deal |

---

## Security & Endpoint Protection

| Product | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| SEP Client (Symantec Endpoint Protection) | Symantec — Perpetual | £1.50 per client | Perpetual licence; check if superseded by CrowdStrike |
| CrowdStrike | — | See Dynatrace/security tooling budget | Approved EDR platform — confirm current contract rate |

---

## Monitoring & Management

| Product | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| SCOM Agent | Softcat - SCE | £0 | Perpetual; included under SCE agreement |
| Nimsoft (Broadcom/CA) | Broadcom / CA | POA | Confirm current contract rate |
| Zabbix | Zabbix LLC | £0 | Open source |
| Kaseya Agent | Kaseya | £25 per agent | Per managed endpoint |
| HPe SIM / InfoSight / iLO Advanced | Softcat | £15 per instance | |
| HPe OneView | Softcat | £325 per instance | Often included in DCC — confirm before budgeting |

---

## Remote Access & PAM

| Product | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| Bitvise SSH Server | Cleverbridge | £100 per client | Per server licence |

---

## Active Directory & Compliance

| Product | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| AD Quest (DC VMs only) | Softcat | £5 per AD user / account | Scoped to Domain Controller VMs |
| Netwrix (DC VMs only) | Softcat | £0 (covered under EA) | Scoped to Domain Controller VMs; covered under Enterprise Agreement |

---

## Database Performance Monitoring

| Product | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| SentryOne | Softcat | £230 per instance | SQL Server performance monitoring |

---

## Storage

| Product | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| HPe 3Par Array (AFA) — without replication | Softcat | £2,136 per TB | All-Flash Array |
| HPe 3Par Array (AFA) — with replication | Softcat | £4,272 per TB | |
| Veritas NetBackup — Front-end (FETB) | Softcat | £1,500 per TB | Front-end terabyte licensing |
| Veritas NetBackup — CPU socket base per TB (GPLive) | Softcat | POA | Confirm current rate with JW |

---

## In-Memory / Caching

| Product | Supplier | Annual Cost (£) | Notes |
|---------|----------|----------------|-------|
| REDIS Enterprise — Premium Support (Production) | REDIS Labs / Softcat | £7,991 per shard | Production tier |
| REDIS Enterprise — Premium Support (Development) | REDIS Labs / Softcat | £6,393 per shard | Development tier |

---

## Quick Reference Summary

| Category | Key SKU | Annual Cost |
|----------|---------|-------------|
| Windows Server STD | 16-core | £470.00 |
| Windows Server DC | 16-core | £1,668.96 |
| SQL Server STD | 4-core min (TPG/EMIS: £1,025.00 / UHG: £445.29) | See notes |
| SQL Server ENT | 4-core min (UHG pricing) | £1,707.60 |
| RHEL | Per server | £270.00 |
| VMware VCF | Per physical core / vSAN host | £893.04 |
| HPe 3Par (AFA) | Per TB (no replication) | £2,136.00 |
| NetBackup (FETB) | Per TB | £1,500.00 |
| REDIS Enterprise | Per shard (Production) | £7,991.00 |
| Kaseya Agent | Per endpoint | £25.00 |

---

## Usage Guidance for BoMs

When building a BoM that includes software licensing:

1. **Identify all OS and database licences** required per VM — record core counts and edition requirements
2. **Check UHG pricing availability** — for SQL Server, always use UHG discounted rates where confirmed applicable; record which pricing line was used and the date confirmed
3. **VMware costs** — never estimate; always obtain a Softcat quote referencing the UHG/Broadcom deal. Use £893.04/physical core/vSAN host for VCF only where confirmed applicable
4. **Open-source OS** — note EOL status; Ubuntu 22.04 LTS and 24.04 LTS are the approved replacements for EOL versions listed here
5. **SCOM Agent** — zero cost under SCE; confirm SCE agreement is still active and in scope
6. **Netwrix** — zero cost under EA; confirm EA scope covers the engagement before excluding from BoM
7. **All POA items** — obtain written quotes before submitting a formal BoM or commercial proposal; flag POA items clearly in any draft BoM
