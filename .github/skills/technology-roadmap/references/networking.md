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
- **VPC Flow Logs**: Enabled for all VPCs; Version 5 (includes TCP flags); sent to CloudWatch Logs; archived to Log Archive account S3
- **Dynatrace**: Network monitoring module for latency, packet loss, and throughput
- **Synthetic Monitoring**: Dynatrace HTTP/TCP monitors for critical network paths
- **CloudWatch Network Monitor**: Cross-account monitoring of latency and packet loss across AWS network paths
- **Alerting**: P1 on link down; P2 on utilisation > 80%; P3 on latency degradation > baseline + 20%

---

## AWS Networking Standards

### VPC Design

Each AWS workload account follows a standardised 4-tier VPC architecture:

| Subnet Tier | Scope | Internet Route | Use |
|------------|-------|---------------|-----|
| **Public** | Per AZ (`/27`) | Via Internet Gateway | Application Load Balancers only; no EC2 instances |
| **Application (Private)** | Per AZ (`/24`) | Via NAT Gateway | EC2, ECS/Fargate, Lambda (VPC-attached), EKS nodes |
| **Database (Isolated)** | Per AZ (`/25`) | None | RDS, ElastiCache, OpenSearch; no internet route at all |
| **Management (Private)** | Per AZ (`/27`) | Via NAT Gateway | VPC Interface Endpoints, SSM endpoints, monitoring agents |

**VPC Standards**:
- One VPC per environment per account; size to `/20` or `/18` to allow subnet expansion
- Enable VPC DNS hostnames and DNS resolution
- Enable VPC Flow Logs Version 5 to CloudWatch and S3
- Tag VPCs and subnets with environment, application, and cost centre tags
- Subnets in ≥ 3 Availability Zones (`eu-west-2a`, `eu-west-2b`, `eu-west-2c`) for production

### Security Groups

- **Default Security Group**: Remove all rules from the default SG; never assign to resources
- **Naming**: `sg-<application>-<tier>-<environment>` (e.g., `sg-emisweb-app-prod`)
- **Inbound**: Deny-all default; explicit rules only — reference other security groups by ID, not CIDR
- **Outbound**: Restrict egress where possible; define explicit egress rules for known destinations
- **No 0.0.0.0/0 on port 22 or 3389** — enforced by SCP and Config rule

**Security Group layering pattern**:
```
ALB Security Group  →  allows 443 from 0.0.0.0/0 (or WAF-managed prefix list)
App Security Group  →  allows traffic from ALB SG ID only
DB Security Group   →  allows traffic from App SG ID only
```

### NACLs

NACLs provide stateless subnet-level defence-in-depth (additional to Security Groups):
- Default NACL: allow all (NACLs are stateless — Security Groups are primary control)
- Custom NACLs for database subnets: explicit deny of traffic from public subnets
- Remember stateless nature: both inbound and outbound rules needed for each connection

### VPC Endpoints

Mandatory for all production workloads — services accessed from private subnets must traverse VPC endpoints, not the internet.

| Endpoint Type | Services | Notes |
|--------------|---------|-------|
| **Gateway Endpoint** | S3, DynamoDB | Free; route table entry; no ENI |
| **Interface Endpoint (PrivateLink)** | SSM, Secrets Manager, ECR, CloudWatch, STS, ECS, KMS, SNS, SQS, Lambda, and others | Small hourly + data charge; ENI in subnet; private DNS enabled |

**Minimum mandatory Interface Endpoints for a workload account**:
- `com.amazonaws.eu-west-2.ssm`
- `com.amazonaws.eu-west-2.ssmmessages`
- `com.amazonaws.eu-west-2.ec2messages`
- `com.amazonaws.eu-west-2.secretsmanager`
- `com.amazonaws.eu-west-2.ecr.api` + `ecr.dkr`
- `com.amazonaws.eu-west-2.logs` (CloudWatch Logs)
- `com.amazonaws.eu-west-2.monitoring` (CloudWatch)
- `com.amazonaws.eu-west-2.kms`
- `com.amazonaws.eu-west-2.sts`
- `com.amazonaws.eu-west-2.s3` (Interface endpoint, in addition to Gateway)

### AWS Transit Gateway

Used in the **Network Account** to hub all workload VPCs and on-premises connectivity:

```
Network Account
├── Transit Gateway (eu-west-2)
│   ├── TGW Route Table: Production  —  prod VPCs only
│   ├── TGW Route Table: Non-Prod    —  dev/test/staging VPCs only
│   ├── TGW Route Table: Shared      —  shared services; visible to all
│   └── TGW Route Table: On-Prem     —  Direct Connect; routes to all
├── Direct Connect Gateway  (BGP ASN 64512)
├── Transit Gateway attachment to each workload VPC
└── RAM share of Transit Gateway to all member accounts
```

**Route isolation**: Production and non-production TGW route tables are separate — production workloads cannot communicate directly with dev/test environments.

**Propagation rules**:
- Workload accounts propagate their VPC CIDRs to the relevant route table only
- No default route propagated to workload VPCs (explicit routes only)
- Static routes to on-premises via Direct Connect

### Route 53

#### Public Hosted Zones

- Managed by the Network team; changes via IaC (Terraform)
- External DNS for EMIS internet-facing services: `emishealthenterprise.com` and subdomains
- DNSSEC enabled on public zones
- Health checks + failover routing for multi-region / DR endpoints

#### Private Hosted Zones

- One PHZ per workload/environment: `<app>.<env>.emis.internal`
- Associated with workload VPC; shared via RAM to all VPCs that need resolution
- Centralised resolver in Network Account resolves PHZs from on-premises

#### Route 53 Resolver

- **Inbound Resolver Endpoint**: In Network Account; allows on-premises DNS servers to forward `.emis.internal` queries to AWS
- **Outbound Resolver Rules**: Forward on-premises domains (e.g., `emis.local`, `emis.corp`) to on-prem DNS servers
- Share resolver rules via RAM to all workload accounts

### AWS Load Balancing Standards

| Scenario | Service | Notes |
|----------|---------|-------|
| HTTP/HTTPS (external) | **Application Load Balancer (ALB)** | WAF WebACL attached; SSL termination; SNI for multiple certs; HTTPS only; access logs to S3 |
| HTTP/HTTPS (internal microservices) | **ALB (internal)** | Private IP; security group restricts to caller SG only |
| TCP/UDP (NLB) — high performance | **Network Load Balancer (NLB)** | Static IP / Elastic IP; preserve source IP; TLS termination at NLB for HTTPS pass-through |
| Container services (ECS/K8s) | **ALB + AWS Load Balancer Controller** | Ingress annotations in Kubernetes manifest; one ALB per service or shared (ingress group) |
| Global traffic routing | **CloudFront + Route 53** | Latency-based, failover, geoproximity routing |
| API management | **API Gateway** | See [aws-standards.md](./aws-standards.md) serverless section |

**ALB Standards**:
- Minimum 2 AZ, 3 AZ for production
- HTTPS only (HTTP listener redirects to HTTPS 301)
- TLS policy: `ELBSecurityPolicy-TLS13-1-2-2021-06` (TLS 1.3 preferred, 1.2 allowed)
- Access logs stored in S3 (Log Archive account for production); 90-day retention
- Deletion protection enabled on production ALBs
- WAF WebACL attached to all internet-facing ALBs

### AWS Direct Connect

| Parameter | Standard |
|-----------|---------|
| Connectivity type | Hosted Connection (via partner) or Dedicated Connection (10 Gbps for production) |
| Redundancy | Two connections from different Direct Connect locations (eu-west-2 DX locations: Slough + London) |
| Virtual Interface type | **Transit VIF** to Direct Connect Gateway → Transit Gateway (single connection to all VPCs) |
| BGP | BGP AS path prepending for preferred path; BFD enabled for fast failover |
| Backup path | AWS Site-to-Site VPN over internet (IPSec IKEv2, AES-256, SHA-384) |
| Monitoring | CloudWatch metrics: `ConnectionBpsEgress`, `ConnectionBpsIngress`, `ConnectionState`; alarm on link down (P1) and utilisation > 70% (P2) |
| Virtual interface MTU | 9001 (jumbo frames) for transit VIF |

### NAT Gateway

- One NAT Gateway **per AZ** for production (not one per VPC — split per AZ for resilience and to avoid cross-AZ data transfer charges)
- Route table per AZ: App subnet → NAT GW in same AZ
- NAT Gateway logs are captured via VPC Flow Logs; no separate logging required
- No NAT Gateway in isolated (database) subnets — these have no internet route at all
- For dev/test: single NAT Gateway in one AZ is acceptable (cost saving)
