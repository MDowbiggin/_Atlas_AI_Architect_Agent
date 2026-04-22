# Security Tooling Standards

> **Classification**: Internal  
> These standards define deployment, configuration, and operational requirements for the security tooling platforms that form the "Rising Sun" programme — CrowdStrike Falcon, Tenable.io, Delinea Secret Server, Darktrace, and Palo Alto. All platforms are **Strategic** in the technology lifecycle.

---

## CrowdStrike Falcon (EDR / Endpoint Protection)

### Overview

CrowdStrike Falcon is the **strategic Endpoint Detection and Response (EDR)** and antimalware platform for all EMIS/Optum compute assets (on-premises, Azure, AWS, containerised).

### Deployment Standards

| Scope | Requirement |
|-------|-------------|
| **All production servers** (Windows, Linux) | Falcon sensor must be deployed and communicating to CrowdStrike cloud |
| **All non-production servers** | Falcon sensor deployed; reduced policy allowed for dev/sandbox |
| **AWS EC2** | Deployed via Systems Manager Distributor as part of account bootstrap (Control Tower + IaC) |
| **Azure VMs** | Deployed via VM Extension or Ansible playbook as part of build pipeline |
| **AKS / EKS Nodes** | Falcon DaemonSet deployed to all node pools (node-level protection) |
| **On-premises VMs** | Deployed via VMware Tools integration or Ansible; all HEPK-managed VMs enrolled |

### Sensor Standards

- **Sensor version**: Keep within N-1 of latest stable; auto-update policy enabled in non-production; manual approval for production upgrades
- **Reduced functionality mode (RFM)**: RFM sensors must be resolved within 5 business days; RFM alert to on-call team
- **Prevention policy**: NGAV (Next-Gen Antivirus) set to **Full Prevention** for production; monitor-mode only for NEW policies until validated, then switch to prevent
- **Local host firewall**: CrowdStrike host-based firewall policy applied to all Windows servers; replace Windows Firewall with Advanced Security where applicable
- **Device Control**: USB/external storage blocked for servers hosting patient data

### Falcon Console Standards

- **URL**: https://falcon.crowdstrike.com
- **Tenant**: [INTERNAL — populate: CrowdStrike tenant/CID]
- **Host Groups**: Aligned with CMDB groups — `<environment>-<application>-<tier>` (e.g., `prod-emisweb-app`)
- **Detection response**: Critical/Severe detections → automatic ServiceNow P1/P2 incident creation via API integration
- **Threat Hunting**: Overwatch enabled; quarterly review of Overwatch reports
- **Spotlight (Vulnerability Management)**: Integrated with Tenable for correlated vulnerability + exposure scoring

### Exclusions Policy

- Document all process/path exclusions in ServiceNow Knowledge Base; require Security team approval
- Review exclusions quarterly; remove stale exclusions
- No blanket directory exclusions for production systems — use process-level exclusions only

---

## Tenable.io (Vulnerability Management)

### Overview

Tenable.io is the **strategic vulnerability management platform** for EMIS/Optum. It provides authenticated scanning of servers, network devices, containers, and cloud resources to identify CVEs and configuration weaknesses.

### Deployment Standards

| Component | Standard |
|-----------|----------|
| **Nessus Agent** | Deployed to all servers where network scanning is not feasible (cloud VMs with no direct scanner access) |
| **Nessus Scanner** | Deployed in each network segment to perform credentialed network scans |
| **AWS Cloud Connector** | Enabled for all AWS accounts — asset discovery and Cloud Security assessment |
| **Azure Cloud Connector** | Enabled for all Azure subscriptions — asset discovery and security posture |
| **Container Security** | ECR / ACR image scanning integrated; scan images on push and on CVE publication |

### Scanning Standards

| Scan Type | Frequency | Scope |
|-----------|-----------|-------|
| Credentialed network scan | Weekly | All production servers |
| Agent-based scan | Continuous (every 24h) | All cloud VMs |
| Cloud assessment | Daily | All AWS accounts and Azure subscriptions |
| Web application scan | Per release (CI/CD integrated) | All internet-facing web applications |
| Container image scan | On push to registry; on new CVE | All ECR and ACR repositories |

### Vulnerability Remediation SLAs

| Severity | Remediation SLA | Escalation |
|----------|----------------|-----------|
| **Critical (CVSS 9.0–10.0)** | 7 days | Auto-create P1 ServiceNow incident; CISO notification |
| **High (CVSS 7.0–8.9)** | 30 days | Auto-create P2 ServiceNow incident |
| **Medium (CVSS 4.0–6.9)** | 90 days | Tracked in vulnerability backlog |
| **Low (CVSS 0.1–3.9)** | 180 days or next major patching cycle | Tracked; no auto-incident |
| **Accepted risk** | Document exception in ServiceNow; annual review | Security Manager sign-off required |

### Integration Points

| Integration | Purpose |
|------------|---------|
| ServiceNow CMDB | Asset synchronisation — align Tenable assets with CIs |
| CrowdStrike Falcon Spotlight | Correlated exposure scoring — vulnerability + endpoint detection |
| Security Hub (AWS) | Inspector V2 findings consolidated; Tenable findings forwarded via connector |
| Dynatrace | Application topology enrichment for risk prioritisation |

---

## Delinea Secret Server (Privileged Access Management — PAM)

### Overview

Delinea Secret Server is the **strategic Privileged Access Management (PAM)** platform. All privileged credentials (domain admin, service accounts, root credentials, network device passwords, cloud break-glass accounts) must be stored in Secret Server.

### Deployment Standards

- **On-premises**: Secret Server hosted on dedicated hardened Windows servers in the management network segment
- **Distributed Engine**: Deployed in each network zone (AWS, Azure, on-prem) to proxy SSH/RDP sessions and rotate secrets without traversing firewall rules
- **SSH Proxy (Pinnacle)**: All SSH access to production Linux servers must go via Secret Server SSH proxy — no direct SSH from admin workstations; sessions recorded

### Credential Standards

| Credential Type | Secret Server Required | Notes |
|----------------|----------------------|-------|
| Domain Administrator accounts | ✅ Mandatory | Password rotation every 90 days |
| Local Administrator (LAPS equivalent) | ✅ Mandatory | Randomised per server; automatic rotation post-use |
| Service accounts (Windows) | ✅ Mandatory | Linked to system; owners defined |
| Database accounts (DBA, sa, root) | ✅ Mandatory | Checkout with approval workflow for production |
| Network device credentials (routers, switches, firewalls) | ✅ Mandatory | Cisco / Palo Alto credentials managed |
| Cloud break-glass accounts (AWS root, Azure global admin) | ✅ Mandatory | Dual-approval checkout; alert on every use |
| API keys and tokens (non-PAM services) | Use Azure Key Vault / AWS Secrets Manager | Secret Server for human PAM; KV/SM for application secrets |

### Access Workflow

1. Engineer requests checkout of privileged credential in Secret Server
2. Approval workflow: automatic for standard accounts; dual-approval for production/break-glass
3. Credential checked out with time-limited access (1–8 hours typical)
4. Session optionally proxied and recorded via Distributed Engine
5. Credential automatically rotated after check-in (or forced rotation after session timeout)
6. Access audit log forwarded to SIEM

### SIEM Integration

- Secret Server audit logs → SIEM (Splunk/Sentinel) — forwarded via syslog or API
- Alert on: successful break-glass checkout, failed login attempts (> 3), credential accessed outside business hours, change in approval configuration

---

## Darktrace (Network Detection and Response — NDR)

### Overview

Darktrace is the **strategic Network Detection and Response (NDR)** platform, using AI/ML to detect anomalous network behaviour indicative of threat activity (lateral movement, exfiltration, C2 communication, insider threats).

### Deployment Standards

| Deployment Type | Location |
|----------------|----------|
| **Physical Appliance** | On-premises data centres (Reading/Watford/IOMart or successor DCs); connected to SPAN port or network TAP |
| **vSensor (Virtual Appliance)** | Deployed on VMware clusters for east-west traffic visibility |
| **Cloud Sensor** | Deployed in AWS VPCs and Azure VNets for traffic mirroring from VPC/VNet flow logs and native integrations |

### Standards

- All production network segments must have Darktrace visibility (validate during design — add sensor requirement)
- **Autonomous Response (Antigena)**: Enabled in confirm mode initially; evaluate to active mode after 90-day baselining period; ensure change management approval before activating autonomous blocking
- **Breach detections**: Darktrace findings forwarded to ServiceNow via API integration; High/Critical → P2 incident auto-created
- **Customer Portal**: https://customerportal.darktrace.com — all security team engineers registered with named accounts (no shared credentials)
- **Baselining period**: New vSensors/cloud sensors require 2–4 weeks of baselining before anomaly scoring is reliable; suppress alerts during baseline window
- **Exclusions**: Document known-good high-traffic agents (Dynatrace, Tenable scanners, backup agents) as device exclusions to reduce noise; Security Manager approval required

---

## Palo Alto Networks (Next-Generation Firewall)

### Overview

Palo Alto Networks is the **strategic NGFW platform** for on-premises and hybrid internet-edge firewall control. Cloud-native equivalents (Azure Firewall, AWS Network Firewall / Security Groups, NSX distributed firewall) are used within cloud platforms.

### Deployed Hardware

| Platform | Use Case |
|----------|---------|
| PA-5200 series | Data centre internet edge; high-throughput production |
| PA-3200 series | Branch / secondary site internet edge |
| Panorama (management platform) | Centralised policy management for all Palo Alto devices |

### Policy Standards

- **Zero Trust model**: Default‐deny all; explicit application-level allow rules only; no port-based rules (application identification enforced)
- **App-ID**: All rules must specify application (not just port); use App-ID to identify and control applications precisely
- **User-ID**: Integrate with Active Directory for user-to-IP mapping; create user-based policies for privileged access paths
- **URL Filtering**: URL filtering profile on all outbound internet rules; block known-bad categories; alert on suspicious
- **Threat Prevention**: IPS (Intrusion Prevention System) profile enabled on all inter-zone rules; block critical/high; alert medium
- **WildFire**: Enable WildFire for zero-day malware analysis on all file transfer rules; verdict retention 30 days
- **SSL Decryption**: Decrypt outbound HTTPS traffic for security inspection (exclude banking, healthcare portals per defined URL category); requires internal CA / MITM proxy policy agreed with Security team

### Panorama Standards

- **URL**: [INTERNAL — populate: Panorama management URL]
- **Change management**: All Palo Alto policy changes via Panorama; commit via ServiceNow-approved change request; no direct device pushes
- **Device Groups**: Organised by `<location>-<function>` (e.g., `dc1-edge`, `dc2-edge`)
- **Shared policies**: Common deny/allow rules in shared pre-rule stack; application-specific rules in device group post-rules
- **Log forwarding**: All traffic, threat, and URL logs forwarded to Panorama and SIEM

---

## Security Tooling Deployment Checklist

Use this checklist for any new server/environment provisioning:

- [ ] CrowdStrike Falcon sensor deployed and communicating (verify in Falcon console)
- [ ] Tenable Nessus agent installed and reporting to Tenable.io
- [ ] Darktrace visibility confirmed (sensor covers network segment)
- [ ] Palo Alto / NSX firewall rules reviewed and applied (no default-allow)
- [ ] Privileged accounts for the system registered in Delinea Secret Server
- [ ] SSH proxy via Delinea configured for all production Linux servers
- [ ] Security Hub / Defender for Cloud compliance scan run; findings triaged
- [ ] Audit logging enabled and forwarded to central SIEM / Log Analytics

---

## Tooling Lifecycle & Renewal Dates

| Tool | Vendor | Renewal / Review Date | Owner |
|------|--------|-----------------------|-------|
| CrowdStrike Falcon | CrowdStrike | [INTERNAL — populate] | Security Engineering |
| Tenable.io | Tenable | [INTERNAL — populate] | Security Engineering |
| Delinea Secret Server | Delinea | [INTERNAL — populate] | Security Engineering |
| Darktrace | Darktrace | [INTERNAL — populate] | Security Engineering |
| Palo Alto NGFW + Panorama | Palo Alto Networks | [INTERNAL — populate] | Network Team |
