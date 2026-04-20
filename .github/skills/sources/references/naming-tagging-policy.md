# Cloud Resource Naming & Tagging Policy

> **Source**: Confluence — Cloud Resource Naming & Tagging Policy
> **Classification**: Internal

## Overview

This document describes the agreed strategy for the naming and tagging of resources deployed in a Cloud Environment. Tagging of cloud resources provides several benefits:

- Security Controls
- Resource Grouping
- Asset Tracking & Identification
- Cost Analysis

---

## Naming Standards

### General Format

All resource names should follow this standard (except IaC stacks which should just be named for the purpose they perform). A compound value is used for the Name to allow sufficient information to be visible without querying all tag values. **All resource names and tagging must be lowercase** to aid future interoperability.

**Standard format:**

```
<environment>-<service>-<component>-<resource_type>-<usage>-<identifier>
```

**Alternative format** (for resources needing a distinct identifier, e.g. Lambdas):

```
<environment>-<service>-<component>-<resource_type>-<identifier>
```

**Examples:**

| Description | AWS | Azure |
|-------------|-----|-------|
| ALB for appointments Prometheus service in dev within a public subnet | `dev-appt-prom-alb-ext` | `dev-appt-prom-lbe-ext` |

### Naming Element Definitions

| Element | Approved Values (AWS) | Approved Values (Azure) | Max Length | Required | Description |
|---------|----------------------|------------------------|------------|----------|-------------|
| **environment** | `prd` (production), `stg` (staging), `dev` (development), `sbx` (sandbox), `cny` (canary) | `prd`, `stg`, `dev`, `sbx`, `cny` | 3 | Yes | Which environment the resource is consumed by. `prd` indicates any environment hosting live data including shared/management services. **Exception**: Where environment is not applicable (e.g. IAM Group), omit this element. |
| **service** | Free form, e.g. `appt`, `ehe`, `ehc`, `clops`, `ppl`, `eng`, `egrp`, `phmo` | Free form, e.g. `appt`, `ehe`, `ehc`, `clops`, `ppl`, `eng`, `phmo` | 4 (total) | Yes | Free form string describing the service, e.g. `appt` = appointments, `ehe` = emishealthenterprise, `ehc` = emishealth clinical, `clops` = cloud operations, `ppl` = patient access, `eng` = hosted engineering, `egrp` = GroupIT |
| **component** | Free form, e.g. `api`, `web`, `db`, `prom`, `dmz`, `net`, `plat`, `stor`, `bck`, `dba`, `ads`, `midd`, `rep`, `rs`, `sec` | Free form, e.g. `api`, `web`, `db`, `prom`, `dmz`, `net`, `plat`, `stor`, `bck`, `dba`, `ads`, `midd`, `rep`, `rs` | 5 | Yes | Component area, e.g. `db` = database, `dmz` = DMZ infrastructure, `net` = networking, `plat` = hosted platform, `stor` = hosted storage, `bck` = hosted backup, `dba` = hosted database, `ads` = active directory, `midd` = middleware, `rep` = reporting, `rs` = readable secondary, `sec` = security |
| **resource_type** | See AWS resource type abbreviations below | See Azure resource type abbreviations below | 6 | Yes | Cloud service hosting the resource |
| **usage** | `int` (internal), `ext` (external) | `int`, `ext` | 3 | Optional | Whether resource is public-facing or internal |
| **identifier** | Free form, e.g. `lamget`, `lamput`, `euwest2` | Free form, e.g. `func`, `uks`, `ukw` | 30 | Optional | Distinct identifier for resources like Lambdas. Use underscore (`_`) for word separation (note: some resources like S3 buckets do not allow underscores) |

### Platform-Specific Exemptions

#### Azure

Azure resource name rules may override the base standards. Reference: [Azure Resource Name Rules](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules). If a resource does not accept the standard format, fall back to Microsoft's base naming layout.

| Resource | Exemption | Example |
|----------|-----------|---------|
| **Storage Accounts** | Lowercase letters and numbers only (no hyphens) | `devapptpromst` |
| **VMs — Resource instance name** | Standard format | `prd-egrp-ads-vm-int-uks001` |
| **VMs — Windows server name** | `AZ-environment(3)-component(3)-identifier(2)` — **limited to 15 characters** | `az-prd-ads-001` |

#### AWS

| Resource | Format | Example |
|----------|--------|---------|
| **EC2 — Resource instance name (Non-Brisbane/Sydney)** | Standard format | `prd-gp01-db-ec2-int-euwest2a-01` |
| **EC2 — Resource instance name (Brisbane/Sydney only)** | `AuthorityResidence(2)-Region(4)-environment(4)-component(3)-identifier(2)` | `eneuw2gp18dbs01` |
| **Windows server name** | `AuthorityResidence(2)-Region(4)-environment(4)-component(3)-identifier(2)` — **limited to 15 characters** | `eneuw2gp01dbs01` |

---

## AWS Resource Type Abbreviations

| Abbreviation | Resource |
|-------------|----------|
| `ace` | VPC Network ACL Entry |
| `acl` | VPC Network ACL |
| `alb` | Application Load Balancer |
| `ami` | Amazon Machine Image |
| `agw` | API Gateway |
| `asg` | Auto Scaling Group |
| `arb` | Arbiter |
| `cb` | CodeBuild project |
| `cp` | CodePipeline |
| `cpg` | Cluster Parameter Group |
| `cd` | CodeDeploy |
| `cf` | CloudFront |
| `cfs` | CloudFormation Stack |
| `ctf` | AWS Certificate |
| `c9` | Cloud9 IDE |
| `cwa` | CloudWatch Alarm |
| `cwr` | CloudWatch Rule |
| `dbc` | DB Cluster |
| `dbi` | DB Instance |
| `de` | DMS Endpoint |
| `dri` | DMS Replication Instance |
| `drt` | DMS Replication Task |
| `dsg` | DMS Replication Subnet Group |
| `dyt` | DynamoDB Table |
| `ebs` | EBS Volume |
| `ec2` | EC2 Instance |
| `ecr` | Elastic Container Registry |
| `ecrr` | Elastic Container Repository |
| `ecsc` | ECS Cluster |
| `ecss` | ECS Service |
| `ecst` | ECS Task |
| `ess` | Elastic Search Service |
| `grp` | IAM Group |
| `iam` | IAM Resource |
| `ipg` | Instance Parameter Group |
| `igw` | VPC Internet Gateway |
| `key` | EC2 Key Pair |
| `kk` | KMS Key |
| `kst` | Kinesis Stream |
| `kfh` | Kinesis Firehose |
| `lbtg` | ELB Target Group |
| `lc` | Launch Configuration |
| `lg` | CloudWatch Log Group |
| `lmd` | Lambda Function |
| `lmdg` | Lambda Function Deployment Group |
| `mgo` | MongoDB |
| `net` | VPC Subnet |
| `ng` | NAT Gateway |
| `ps` | Parameter Store Secret |
| `pol` | IAM Policy |
| `rcs` | Read Connection String |
| `rdc` | RDS Cluster |
| `rdi` | RDS Instance |
| `rdpx` | RDS Proxy |
| `rol` | IAM Role |
| `rt` | VPC Route Table |
| `s3` | S3 Bucket |
| `sg` | VPC Security Group |
| `sds` | Service Discovery Service |
| `sm` | Secrets Manager Secret |
| `sns` | SNS Topic |
| `sqs` | SQS Queue |
| `sub` | Subnet |
| `sug` | Subnet Group |
| `td` | Task Definition |
| `tg` | ELB/ALB Target Group |
| `tgwa` | Transit Gateway Attachment |
| `vpce` | VPC Endpoint |
| `vgw` | VPN Gateway |
| `vpc` | VPC |
| `wcs` | Write Connection String |
| `wh` | Webhook |

## Azure Resource Type Abbreviations

| Abbreviation | Resource |
|-------------|----------|
| `adf` | Azure Data Factory |
| `ads` | Active Directory Service |
| `afw` | Firewall |
| `afwp` | Firewall Policy |
| `agw` | Application Gateway |
| `aks` | AKS Cluster |
| `apim` | API Management |
| `app` | Web App |
| `arck` | Azure Arc enabled Kubernetes Cluster |
| `arcs` | Azure Arc enabled Server |
| `as` | Azure Analysis Services |
| `asa` | Azure Stream Analytics |
| `ase` | App Service Environment |
| `asg` | Application Security Group |
| `avail` | Availability Set |
| `bas` | Bastion |
| `cdne` | CDN Endpoint |
| `cdnp` | CDN Profile |
| `ci` | Container Instance |
| `cld` | Cloud Service |
| `cn` | VPN Connection |
| `cog` | Azure Cognitive Services |
| `con` | Connections |
| `cosmos` | Azure Cosmos DB |
| `cr` | Container Registry |
| `dbw` | Azure Databricks Workspace |
| `dec` | Azure Data Explorer Cluster |
| `dedb` | Azure Data Explorer Cluster Database |
| `des` | Disk Encryption Set |
| `disk` | Managed Disk (Data) |
| `dla` | Data Lake Analytics Account |
| `dls` | Data Lake Store Account |
| `dnsz` | DNS |
| `erc` | ExpressRoute Circuit |
| `evgd` | Event Grid Domain |
| `evgt` | Event Grid Topic |
| `evh` | Event Hub |
| `evhns` | Event Hubs Namespace |
| `fd` | Front Door |
| `fdfp` | Front Door Firewall Policy |
| `func` | Function App |
| `gal` | Gallery |
| `hadoop` | HDInsight Hadoop Cluster |
| `hbase` | HDInsight HBase Cluster |
| `id` | Managed Identity |
| `iot` | IoT Hub |
| `ippre` | Public IP Address Prefix |
| `kafka` | HDInsight Kafka Cluster |
| `lbe` | Load Balancer (External) |
| `lbi` | Load Balancer (Internal) |
| `lgw` | Local Network Gateway |
| `mg` | Management Group |
| `mls` | HDInsight ML Services Cluster |
| `mlw` | Azure Machine Learning Workspace |
| `mysql` | MySQL Database |
| `nic` | Network Interface (NIC) |
| `nsg` | Network Security Group |
| `nsgsr` | NSG Security Rules |
| `ntf` | Notification Hubs |
| `ntfns` | Notification Hubs Namespace |
| `nw` | Network Watcher |
| `osdisk` | Managed Disk (OS) |
| `pbi` | Power BI Embedded |
| `pcert` | Provisioning Services Certificate |
| `pdnsz` | DNS Zone |
| `peer` | Virtual Network Peering |
| `pip` | Public IP Address |
| `pl` | Private Link |
| `plan` | App Service Plan |
| `policy` | Policy Definition |
| `provs` | Provisioning Services |
| `psql` | PostgreSQL Database |
| `redis` | Azure Cache for Redis |
| `rf` | Route Filter |
| `rg` | Resource Group |
| `rt` | Route Table |
| `rule` | Load Balancer Rule |
| `se` | Service Endpoint |
| `sf` | Service Fabric Cluster |
| `snap` | Snapshot |
| `snet` | Virtual Network Subnet |
| `spark` | HDInsight Spark Cluster |
| `sql` | Azure SQL Database Server |
| `sqldb` | Azure SQL Database |
| `sqlmi` | SQL Managed Instance |
| `sqlsdb` | SQL Server Stretch Database |
| `srch` | Azure Cognitive Search |
| `ssimp` | Azure StorSimple |
| `st` | Storage Account / VPN Site |
| `stapp` | Static Web App |
| `storm` | HDInsight Storm Cluster |
| `stvm` | VM Storage Account |
| `synw` | Azure Synapse Analytics Workspace |
| `syn` | Azure Synapse Analytics |
| `syndp` | Azure Synapse Analytics SQL Dedicated Pool |
| `synspk` | Azure Synapse Analytics Spark Pool |
| `traf` | Traffic Manager Profile |
| `udr` | User Defined Route |
| `vgw` | Virtual Network Gateway |
| `vm` | Virtual Machine |
| `vmss` | Virtual Machine Scale Set |
| `vnet` | Virtual Network |
| `vpng` | VPN Gateway |
| `vwan` | Virtual WAN |
| `waf` | Web Application Firewall Policy |
| `wafrg` | WAF Policy Rule Group |

---

## Tagging Standards

Additional key-value pair tags must be applied to **all supported cloud resources**. This metadata enables cost analysis, security controls, and resource grouping. The following common tags are **mandatory** for all resources that support tags.

### Mandatory Tags

| Tag Key | Values | Required | Format | Description |
|---------|--------|----------|--------|-------------|
| `ask_id` | Value from Index | Yes | lowercase | ASKID for the application (previously AIDE). Reference: Cloud Usage Charter |
| `az_location` | `euw2-az1`, `euw2-az2`, `euw2-az3` | Yes | lowercase | Availability Zone location |
| `backup_class` | `bronze`, `silver`, `gold`, `platinum`, `diamond` | Yes | lowercase | Determines AWS Backup RPO requirements. Reference: AWS Backup Policy |
| `business_unit` | e.g. `primary-care`, `secondary-care`, `patient` | Yes | lowercase | Business unit the service underpins |
| `cost_centre` | Value from Index | — | — | Cost centre for the service |
| `dr` | `mission-critical`, `critical`, `essential`, `high`, `medium`, `low-not required` | Yes | lowercase | HA/DR classification |
| `drive_letter` | `c`, `d`, `e`, `f`, `l`, `q`, `t` | Yes (EC2 DB instances only) | lowercase | Drive letter mapping for SQL installations: C=OS, D=Data, E=Monitoring/Scheduler, F=EMAS, L=Logs, Q=SQL Binaries, T=TempDB |
| `environment` | Value from Index | Yes | lowercase | Environment type |
| `lifecycle` | `build`, `maintenance`, `production`, `deprecated` | When required | lowercase | Used during changes to live EC2 instances to reduce monitoring noise |
| `owner` | Value from Index | Yes | lowercase | Team primarily responsible for the service |
| `product` | Value from Index | Yes | lowercase | Product name |
| `programme_name` | Value from Index | Yes | lowercase | ServiceNow reference for delivery |
| `project_code` | Value from Index | Yes | lowercase | ServiceNow project code |
| `project_name` | Value from Index | Yes | lowercase | ServiceNow project name |
| `server_function` | e.g. `eweb-pub`, `emis-priv`, `emas`, `sql-db`, `sql-rs`, `m-ad`, `wsus-rep`, `sds-app`, `bastion-gen` | Yes (EC2 instances only) | lowercase | Server function — used for AWS Resource Group configuration and SSM patching |
| `server_type` | `app`, `db`, `mgmt`, `sec`, `nbu` | Yes (EC2 instances only) | lowercase | Server type — used for AWS Resource Group configuration and SSM patching |
| `service` | Value from Index | Yes | lowercase | Service name |
| `service_location` | `england`, `wales`, `gibraltar`, `iom`, `jersey` | Yes | lowercase | Region or territory of service |
| `sub_service` | Value from Index | Yes | lowercase | Sub-service breakdown, e.g. product: `emis-web` > service: `ccmh` > sub_service: `clinical-services` |
| `sub_sub_service` | Value from Index | Yes | lowercase | Further sub-service breakdown, e.g. service: `shared-services` > sub_service: `health-connect` > sub_sub_service: `pfs` |
| `value_stream` | Value from Index | Yes | lowercase | Value stream for the application/service |
| `finops_exception` | `required-for-production-testing` | When required | lowercase | Used when non-production resources must persist and not be subject to cost optimisation (e.g. SDS with significant manual post-deployment customisation) |

### Group IT Tags (Additional)

| Tag Key | Values | Required | Format | Description |
|---------|--------|----------|--------|-------------|
| `role` | Free form | Group IT only | lowercase | Role within the application stack (e.g. Appointment Application, Monitoring) |
| `tech_owner` | Pod name, e.g. `cloud_ops`, `cloud_networks`, `crimp`, `development`, `emis-security`, `gplive`, `hosted-engineering`, `hosted-networks`, `landing-zone`, `patient-access`, `grpit` | Group IT only | lowercase | Team technically responsible for the service |
| `svc_owner` | e.g. `support`, `ehis` | Group IT only | lowercase | Team responsible for the service |
| `retention` | `n/a`, `0_days`, `30_days`, `31_days`, `90_days`, `180_days`, `365_days`, `730_days`, `1825_days`, `indefinite` | Group IT only | string | Data retention period — determines backup/vault policies |

---

## Tag Limits

| Limit | AWS | Azure |
|-------|-----|-------|
| Tags per resource | 50 | 50 |
| Max key length | 127 | 512 |
| Max value length | 255 | 256 |
| Case sensitive | Yes | No |
| Valid characters (key) | Letters, numbers, spaces, `+ - = . _ : / @` | Letters, numbers, spaces, `+ - = . _ : / @` |

---

## Hosted Engineering Windows Server Naming Examples

| Service / Authority & Function | Stage | Azure Example | AWS Example |
|-------------------------------|-------|--------------|-------------|
| GPLive England — SQL Database EC2 | PROD | `en-az-gp18dbs01` | `eneuw2gp01dbs01` |
| GPLive England — SQL Database EC2 | DEV | n/a | `eneuw2devdbs01` |
| GPLive England — SQL Database EC2 | STAGING | n/a | `eneuw2stgdbs01` |
| CCMH England — SQL Database EC2 | PROD | `en-az-cm18dbs01` | `eneuw2cm01dbs01` |
| GPLive England — Readable Secondary EC2 | PROD | `en-az-gp18rs-01` | `eneuw2gp01rs-01` |
| GPLive England — EMISWeb Application EC2 | PROD | `en-az-gp18app01` | `eneuw2gp01app01` |
| GPLive England — SQL AG name | PROD | n/a | `eneuw2gp01-ag1` |
| GPLive England — SQL AG Listener | PROD | n/a | `eneuw2gp01-ag1` |

### Service Account Naming

| Service Account | Example |
|----------------|---------|
| EMISWeb | `emisweb-gp01` |
| EMISScheduler | `scheduler-gp01` |
| EMAS | `emas-gp01` |
| SQLService | `sqlservice-gp01` |
| SQLAgent | `sqlagent-gp01` |
| SQLBrowser | `sqlbrowser-gp01` |
| ResourcePublisher | `resourcepublisher-aws-en` |
| EMISConnect | `emisconnect-subservice` |
| OpenAPI | `openapi-en` |
| IdentityService | `identityservice-en` |
| SDS | `isds-service` |

---

## Security Tooling Tags

### CrowdStrike — Grouping Tags

CrowdStrike grouping tags are used for security agent management across Brisbane & Sydney workstreams.

### Nessus — Grouping Tags

Nessus grouping tags support the deployment and ongoing management of EC2 instances with Nessus agents across Brisbane & Sydney workstreams. All new groups **must be** created before Nessus agent deployment.
