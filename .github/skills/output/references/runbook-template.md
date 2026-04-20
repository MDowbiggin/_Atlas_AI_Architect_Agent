# Runbook Template

## Template

```markdown
# Runbook — [Service/Application Name]

## Document Control

| Item | Detail |
|------|--------|
| Document ID | RB-[XXXX] |
| Version | 1.0 |
| Author | [Name] |
| Date | YYYY-MM-DD |
| Classification | Internal |
| Related HLD/LLD | HLD-[XXXX] / LLD-[XXXX] |
| ServiceNow KB Article | KB[XXXXXX] |
| CMDB Application CI | [CI number] |

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | YYYY-MM-DD | [Name] | Initial version |

---

## 1. Service Overview

| Item | Detail |
|------|--------|
| Service Name | [Application/Service name] |
| Business Owner | [Name/Team] |
| Technical Owner | [Architecture/Engineering contact] |
| Support Team | PIMS — [specific team] |
| Service Tier | Tier 1 / 2 / 3 |
| SLA | [Availability target] |
| Support Hours | 24/7 / Business Hours + On-Call |

### Architecture Summary

[Brief description (3-5 sentences) of what the service does and how it's architected. Include a simple diagram if helpful.]

### Component Inventory

| Component | Type | Location | CI Number |
|-----------|------|----------|-----------|
| [Web Server 1] | Azure VM | UK South, AZ1 | CI[XXXXXXX] |
| [Web Server 2] | Azure VM | UK South, AZ2 | CI[XXXXXXX] |
| [Database] | Azure SQL | UK South | CI[XXXXXXX] |
| [Load Balancer] | App Gateway | UK South | CI[XXXXXXX] |

## 2. Access & Connectivity

| Item | Detail |
|------|--------|
| Subscription | [Azure subscription name] |
| Resource Group | rg-[app]-[env]-[region] |
| Admin Access | Azure Bastion → [server name] |
| Required Permissions | SG-[app]-Admins (request via ServiceNow) |
| Key Vault | kv-[app]-[env] (secrets, certs) |
| Monitoring Dashboard | [Dynatrace dashboard URL] |
| Log Analytics | la-[app]-[env] |

## 3. Health Checks

### Service Health Verification

| Check | Method | Expected Result | Frequency |
|-------|--------|----------------|-----------|
| Application URL | HTTPS GET [URL] | 200 OK, response < 2s | Dynatrace synthetic (5 min) |
| Database connectivity | Connect to [server]:1433 | Connection successful | Dynatrace (1 min) |
| Disk space | Azure Monitor metric | > 20% free | Azure alert (continuous) |
| CPU utilisation | Dynatrace host health | < 80% average | Dynatrace (continuous) |
| Certificate expiry | Key Vault | > 30 days remaining | Weekly check |
| Backup status | Azure Backup | Last backup < 24h ago | Daily check |

### Quick Health Check Script

```powershell
# Quick health check — run from Azure Cloud Shell or Bastion session
# Replace placeholders with actual values

# Check VM status
az vm list -g "rg-[app]-prod-uksouth" --query "[].{Name:name, Status:powerState}" -o table

# Check SQL connectivity
Test-NetConnection -ComputerName "[sql-server].database.windows.net" -Port 1433

# Check storage account
az storage account show -n "[storage-account]" -g "rg-[app]-prod-uksouth" --query "statusOfPrimary" -o tsv
```

## 4. Standard Operating Procedures

### 4.1 Service Start

1. [Step-by-step procedure to start the service]
2. [Include any ordering/dependency requirements]
3. [Verify service is healthy using §3 checks]

### 4.2 Service Stop (Planned)

**⚠️ Requires approved change request (ServiceNow CHG)**

1. [Notify stakeholders per change plan]
2. [Step-by-step procedure to gracefully stop the service]
3. [Verify all connections drained]
4. [Confirm stopped state]

### 4.3 Service Restart

**⚠️ Requires approved change request for production**

1. [Stop procedure — reference §4.2]
2. [Wait for [X] seconds for clean shutdown]
3. [Start procedure — reference §4.1]
4. [Verify health — reference §3]
5. [Confirm normal operation]

### 4.4 Patching

**Schedule**: Monthly, [week/day] — per Azure Update Manager policy

1. Verify change request approved
2. Pre-patch snapshot (automatic via Azure Backup)
3. Apply patches via Azure Update Manager
4. Verify reboot completed successfully
5. Run health checks (§3)
6. Verify application functionality
7. If health check fails → initiate rollback (§6)

### 4.5 Certificate Renewal

1. Check current certificate expiry in Key Vault
2. Generate new CSR or use Key Vault auto-renewal
3. Upload new certificate to Key Vault
4. Restart application to pick up new certificate (or configure auto-rotation)
5. Verify HTTPS connectivity with new certificate
6. Update CMDB with new certificate expiry date

### 4.6 Scaling

| Direction | Trigger | Procedure |
|-----------|---------|-----------|
| Scale Out | CPU > 80% sustained 15min | [Auto-scaling if configured / Manual: add instance via IaC] |
| Scale In | CPU < 30% sustained 1hr | [Auto-scaling if configured / Manual: remove instance, ensure LB drains] |
| Scale Up | Memory utilisation > 85% | Change request → resize VM via IaC → restart |

## 5. Troubleshooting Guide

### Common Issues

| Symptom | Likely Cause | Resolution |
|---------|-------------|------------|
| Application timeout | Database connection pool exhausted | Restart application pool; check DB connections |
| HTTP 503 | All backend instances unhealthy | Check VM health; review health probe logs |
| High CPU | Runaway process or unexpected load | Identify process (Dynatrace); scale out if legitimate |
| Disk full | Log rotation failure or data growth | Clear old logs; extend disk (IaC) |
| SSL error | Certificate expired or misconfigured | Check Key Vault; renew certificate (§4.5) |

### Diagnostic Commands

```powershell
# Check Windows service status
Get-Service -Name "[ServiceName]"

# Check recent error events
Get-EventLog -LogName Application -EntryType Error -Newest 20

# Check disk space
Get-WmiObject Win32_LogicalDisk | Select DeviceID, @{N='FreeGB';E={[math]::Round($_.FreeSpace/1GB,2)}}, @{N='TotalGB';E={[math]::Round($_.Size/1GB,2)}}

# Check network connectivity
Test-NetConnection -ComputerName "[target]" -Port [port]
```

```bash
# Linux equivalent commands
systemctl status [service-name]
journalctl -u [service-name] --since "1 hour ago" -p err
df -h
nc -zv [target] [port]
```

### Escalation

| Level | Contact | When |
|-------|---------|------|
| L1 | PIMS on-call | Initial triage; standard procedures |
| L2 | [Team Lead] | Procedures exhausted; non-standard issue |
| L3 | [Architecture / Engineering] | Design-level issue; requires code or architecture change |
| Vendor | [Microsoft / AWS Support] | Platform-level issue confirmed |

## 6. Disaster Recovery

### Failover Procedure

**⚠️ DR failover is a P1 action — engage on-call leadership**

1. **Confirm**: Validate that primary region is unavailable (not transient)
2. **Communicate**: Notify stakeholders via incident bridge
3. **Initiate**: [Steps to failover — specific to DR design]
4. **Validate**: Run health checks against DR instance
5. **Update DNS**: [If manual DNS change required]
6. **Monitor**: Intensive monitoring for first 4 hours

### Failback Procedure

1. **Confirm**: Primary region recovered and stable
2. **Sync**: Ensure data is synchronised from DR to primary
3. **Test**: Validate primary region health
4. **Switch**: Redirect traffic back to primary
5. **Monitor**: Intensive monitoring for first 4 hours
6. **Post-incident**: Schedule PIR within 5 business days

### Rollback Procedure (Post-Change)

1. **Identify**: Change has caused issue
2. **Decision**: Rollback approved by change owner
3. **Execute**: [Specific rollback steps — restore from snapshot, revert IaC, DNS switch]
4. **Validate**: Confirm service restored to pre-change state
5. **Communicate**: Notify stakeholders of rollback
6. **Post-mortem**: Document why rollback was needed; update change process

## 7. Contacts

| Role | Name | Contact |
|------|------|---------|
| Application Owner | [Name] | [Email / Teams] |
| Solutions Architect | [Name] | [Email / Teams] |
| PIMS Team Lead | [Name] | [Email / Teams] |
| On-Call (PIMS) | — | [PagerDuty / on-call number] |
| Microsoft Support | — | [Support portal / case process] |
```

## Runbook Best Practices

1. **Step-by-step** — Write for someone performing the task at 3am; be explicit
2. **Testable** — Include verification steps after every action
3. **Maintained** — Review and update quarterly or after every change
4. **Accessible** — Store in ServiceNow KB for PIMS; link from CMDB CI
5. **Include rollback** — Every procedure should have a "what if it goes wrong" path
