# Networking Standards

## Overview

Network design is foundational to every infrastructure solution at EMIS/Optum. All designs must follow these standards for consistency, security, and operational manageability across hybrid environments.

## IP Address Management (IPAM)

### Address Space Allocation

| Environment | Azure VNet CIDR | AWS VPC CIDR | On-Prem Subnet |
|-------------|----------------|--------------|----------------|
| Production | [INTERNAL — populate per environment] | [INTERNAL — populate per environment] | [INTERNAL — populate per environment] |
| Development | [INTERNAL — populate per environment] | [INTERNAL — populate per environment] | [INTERNAL — populate per environment] |
| Test/Staging | [INTERNAL — populate per environment] | [INTERNAL — populate per environment] | [INTERNAL — populate per environment] |
| Management | [INTERNAL — populate per environment] | [INTERNAL — populate per environment] | [INTERNAL — populate per environment] |

> **Rule**: All CIDR ranges must be coordinated across Azure, AWS, and on-prem to prevent overlap. Requests for new address space go through the Network Architecture team.

### Subnet Design

| Subnet Type | Purpose | Example CIDR Size |
|-------------|---------|------------------|
| Gateway | VPN/ExpressRoute endpoints | /27 |
| Firewall | Azure Firewall / NVA | /26 |
| Bastion | Azure Bastion | /26 |
| Web/DMZ | Internet-facing load balancers | /24 |
| Application | Application servers | /24 |
| Database | Database servers | /24 |
| Private Endpoints | PaaS private endpoints | /24 |
| Management | Jump servers, monitoring agents | /24 |

## Network Security

### Network Security Groups (NSGs) / Security Groups

- **Default**: Deny all inbound; allow only explicitly required traffic
- **Granularity**: Apply at subnet level (Azure NSG) and instance level (AWS SG) where needed
- **Naming Convention**: `nsg-<environment>-<workload>-<tier>` (e.g., `nsg-prod-webapp-app`)
- **Flow Logs**: Enable NSG Flow Logs / VPC Flow Logs for all production subnets
- **Review Cadence**: Quarterly review of all NSG/SG rules; remove unused rules

### Firewall Rules

- **Centralised**: All egress traffic routes through Azure Firewall (hub) or Palo Alto (on-prem)
- **Application Rules**: FQDN-based filtering for outbound internet access (no blanket allow)
- **Network Rules**: IP/port-based for internal traffic between spokes
- **Threat Intelligence**: Enable Azure Firewall threat intelligence in Alert & Deny mode
- **Logging**: All firewall logs forwarded to Log Analytics / Sentinel

### DDoS Protection

- Azure DDoS Protection Standard enabled for all internet-facing workloads
- AWS Shield Standard (default) + Shield Advanced for critical workloads

## DNS Standards

### Azure DNS

- **Public DNS**: Azure DNS for external domains
- **Private DNS**: Azure Private DNS Zones for internal name resolution
- **Private Endpoints**: Auto-registration of private endpoint DNS records
- **Conditional Forwarding**: Azure DNS Private Resolver for on-prem to Azure resolution

### On-Premises DNS

- Active Directory Integrated DNS for internal zones
- Conditional forwarding to Azure Private DNS Resolver for `.privatelink.*` zones
- DNS split-brain for hybrid name resolution

### Naming Convention

```
<service>-<environment>-<region>-<instance>.<domain>
Example: app-prod-uksouth-01.emis.internal
```

## Load Balancing

| Scenario | Service | Notes |
|----------|---------|-------|
| HTTP/HTTPS (external) | Azure Front Door / Application Gateway | WAF enabled; SSL termination |
| HTTP/HTTPS (internal) | Azure Application Gateway (internal) | Private IP frontend |
| TCP/UDP (external) | Azure Load Balancer (Standard, public) | Zone-redundant |
| TCP/UDP (internal) | Azure Load Balancer (Standard, internal) | Cross-zone by default |
| Global traffic distribution | Azure Front Door / AWS CloudFront | Geo-routing, failover |
| On-premises | F5 BIG-IP | Existing investment; migrate to Azure where possible |

### Standards

- Always use Standard SKU (not Basic) for Azure Load Balancer
- Health probes: HTTP(S) preferred over TCP; custom health endpoint where possible
- Session affinity: Avoid where possible (design stateless); use cookie-based if required
- SSL/TLS: Terminate at the load balancer; re-encrypt to backend (end-to-end TLS for sensitive workloads)

## Connectivity

### ExpressRoute

- **Primary Circuit**: [INTERNAL — populate: provider, bandwidth, peering location]
- **Secondary Circuit**: [INTERNAL — populate: disaster recovery circuit details]
- **Private Peering**: For Azure VNet access; BGP routing with on-prem
- **Microsoft Peering**: For Microsoft 365 and Dynamics (if applicable)
- **Global Reach**: Enable for cross-circuit communication if needed
- **Monitoring**: ExpressRoute Monitor via Azure Monitor; utilisation alerts at 70%

### VPN (Backup)

- **Type**: Route-based VPN (IKEv2)
- **SKU**: VpnGw2 or higher for production bandwidth
- **Redundancy**: Active-active with BGP
- **Encryption**: AES-256-GCM, SHA-384, DH Group 24

### AWS Direct Connect

- **Port**: [INTERNAL — populate: speed, location]
- **VIF**: Private VIF for VPC access; Transit VIF for Transit Gateway
- **Monitoring**: CloudWatch metrics; utilisation alerts at 70%

## Network Monitoring

- **Azure Network Watcher**: Enabled in all subscriptions; topology views, packet capture, connection monitor
- **NSG Flow Logs**: Version 2; sent to Log Analytics with Traffic Analytics enabled
- **Dynatrace**: Network monitoring module for latency, packet loss, and throughput
- **Synthetic Monitoring**: Dynatrace HTTP/TCP monitors for critical network paths
- **Alerting**: P1 on link down; P2 on utilisation > 80%; P3 on latency degradation > baseline + 20%
