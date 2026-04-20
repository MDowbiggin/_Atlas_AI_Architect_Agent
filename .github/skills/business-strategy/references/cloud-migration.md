# Cloud Migration Strategy

## Overview

Cloud migration at EMIS/Optum follows a structured approach aligned with the Azure Cloud Adoption Framework and the 6 Rs of migration. Azure is the primary target; AWS is secondary for specific use cases.

## The 6 Rs of Migration

| Strategy | Description | When to Use | Effort | Cloud Benefit |
|----------|-------------|-------------|--------|---------------|
| **Rehost** (Lift & Shift) | Move as-is to cloud VMs | Quick migration; legacy apps; minimal budget for changes | Low | Low |
| **Re-platform** | Minor optimisations during migration | Database to PaaS; managed services where compatible | Medium | Medium |
| **Refactor** | Re-architect for cloud-native | Strategic apps; long-term investment; agility needed | High | High |
| **Repurchase** | Replace with SaaS | Commodity applications; better SaaS alternative exists | Low-Medium | High |
| **Retain** | Keep on-premises | Regulatory constraints; near-term retirement; latency requirements | None | None |
| **Retire** | Decommission | No longer needed; redundant after consolidation | Low | Cost savings |

## Migration Phases

### Phase 1: Assess

**Goal**: Build a comprehensive inventory and categorise workloads.

**Activities**:
1. **Discovery** — Use Azure Migrate + Dynatrace to discover all servers, dependencies, and performance data
2. **Inventory** — Record in CMDB: server, OS, applications, data classification, dependencies
3. **Categorise** — Assign each workload a migration strategy (6 Rs) based on:
   - Business criticality and strategic importance
   - Technical compatibility with cloud services
   - Compliance requirements (PHI, data residency)
   - Dependency complexity
   - Cost-benefit analysis
4. **Prioritise** — Score and rank workloads into migration waves

**Wave Planning Criteria**:

| Priority | Characteristics |
|----------|----------------|
| Wave 1 | Low complexity, few dependencies, good cloud-fit, high strategic value |
| Wave 2 | Medium complexity, well-understood dependencies, clear migration path |
| Wave 3 | High complexity, many dependencies, requires re-platforming |
| Wave 4 | Complex legacy, significant refactoring needed, or retain decision |

### Phase 2: Plan

**Goal**: Detailed migration plans per wave.

**Activities**:
1. Landing zone readiness — Validate Azure/AWS landing zones (networking, identity, governance)
2. Migration architecture — HLD per workload/wave
3. Dependency mapping — Confirm migration order respects dependencies
4. Testing strategy — Define test plans for each workload
5. Rollback procedures — Document rollback for every migration
6. Communication plan — Stakeholder notifications, change windows
7. Resource planning — Migration tools, team capacity, vendor support

### Phase 3: Migrate

**Goal**: Execute migration waves.

**Activities**:
1. Pre-migration: Validate landing zone, test connectivity, pre-stage data
2. Migration: Execute using appropriate tooling (Azure Migrate, ASR, DMS, native tools)
3. Validation: Run test plan, verify functionality, performance, and connectivity
4. Cutover: DNS switch, update load balancers, redirect traffic
5. Hypercare: 2-week intensive monitoring post-cutover

**Migration Tooling**:

| Tool | Use Case |
|------|----------|
| Azure Migrate | Server assessment and migration (VMware, Hyper-V, physical) |
| Azure Site Recovery (ASR) | VM replication and failover |
| Azure Database Migration Service (DMS) | SQL Server, PostgreSQL, MySQL migration |
| Azure File Sync | File server migration (staged) |
| AWS Migration Hub | AWS workload migration coordination |
| AWS Server Migration Service | VM replication to AWS |
| AWS DMS | Database migration to AWS |
| CloudEndure | Cross-platform VM replication |

### Phase 4: Optimise

**Goal**: Post-migration optimisation and modernisation.

**Activities**:
1. Right-size VMs based on actual cloud utilisation (30-day review)
2. Implement Reserved Instances for stable workloads
3. Enable auto-scaling where applicable
4. Review and optimise storage tiers
5. Implement Azure Advisor / AWS Trusted Advisor recommendations
6. Plan modernisation (IaaS → PaaS/containers) for Wave 1 workloads
7. Update CMDB and documentation
8. Decommission source infrastructure

## Migration Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Data loss during migration | Low | Critical | Pre-migration backup; validated restore; parallel running |
| Extended downtime | Medium | High | Off-hours migration window; automated failback |
| Performance degradation | Medium | Medium | Right-sizing validation; performance baseline comparison |
| Dependency failure | Medium | High | Complete dependency mapping; staged migration order |
| Network connectivity issues | Low | High | Pre-migration connectivity testing; ExpressRoute validation |
| Compliance gap | Low | Critical | Pre-migration compliance review; post-migration audit |
| Cost overrun | Medium | Medium | Accurate pre-migration cost estimate; post-migration cost review |
