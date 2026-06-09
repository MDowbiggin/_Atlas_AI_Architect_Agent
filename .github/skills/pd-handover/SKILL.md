---
name: pd-handover
description: "GP production support handover generation for Wales EMIS deployments. Use when: generating or refreshing PD production support handover documents, publishing deployment metadata to Confluence, collecting live AWS inventory for a GP deployment, reviewing NLB/ALB configurations, verifying SSM parameter store allocations, or preparing BAU handover packs for GP01–GP10."
---

# PD Production Support Handover

## When to Use

- Generating or refreshing a production support handover document for a Wales GP deployment (GP01–GP10)
- Publishing deployment metadata to a Confluence parent page before or after a deployment change
- Collecting live AWS inventory (EC2 instances, load balancers, SSM parameters, subnets, security groups) for a specific GP deployment
- Verifying NLB/ALB configuration, target group membership, or private IP allocations for Wales nodes
- Preparing a BAU handover pack for PIMS or CloudOps following infrastructure changes
- Auditing which AWS resources (instances, load balancers, parameters) are active for a given PD number
- Cross-checking live infrastructure state against Terragrunt configuration (e.g. instance types, AMI IDs)
- Confirming PSBA public IP addresses and Spine endpoint registration details for a GP deployment

## Overview

The `Create-ConfluencePdHandover.ps1` script automates the generation of structured production support handover content for Wales GP deployments (GP01–GP10). It combines:

- **Live AWS metadata** — EC2 instances, ELBv2 load balancers, SSM Parameter Store values, IAM identity, subnets, security groups, VPCs
- **Terragrunt HCL configuration** — instance types, AMI IDs, schedule settings, feature flags, shared resource ARNs
- **Workspace data files** — PSBA public IP addresses and Spine endpoint registration details (indexed by GP order)

Output is a structured HTML page (ready for Confluence) and a raw JSON metadata file. The script can publish directly to Confluence via the v2 REST API, creating or updating a child page under a specified parent.

See [references/pd-handover-guide.md](references/pd-handover-guide.md) for full prerequisites, parameter reference, troubleshooting, and security notes.

## Script Location

```
.github/skills/sources/references/Create-ConfluencePdHandover.ps1
```

> The script lives in the `sources/references` folder as a utility reference. Copy or invoke from the appropriate working context (scripts folder of the target repo).

## Prerequisites

| Requirement | Details |
|-------------|---------|
| **PowerShell** | Version 7.0 or later |
| **AWS CLI** | Configured with a profile or IAM role with read access to the target account (see [IAM permissions](#iam-permissions)) |
| **AWS Region** | `eu-west-2` (default) |
| **Terragrunt config** | `terragrunt/prd/environment.terragrunt.hcl` and `terragrunt/prd/<PdNumber>/pd.terragrunt.hcl` must exist in the repository root |
| **Workspace data files** | `../misc/psba_addresses.txt` and `../misc/dns_and_certificates_list.txt` (relative to `scripts/`) — one entry per line, indexed by GP order (GP01 = line 1) |
| **Confluence API token** | Required only for `-PublishToConfluence`; sourced at runtime via parameter — never store in code or version control |

## Quick Usage

**Dry run — local output only (no Confluence publish):**

```powershell
./scripts/Create-ConfluencePdHandover.ps1 `
  -PdNumber GP01 `
  -ParentPageId 9023062028 `
  -DryRun
```

**Publish to Confluence (create or update child page):**

```powershell
./scripts/Create-ConfluencePdHandover.ps1 `
  -PdNumber GP01 `
  -ParentPageId 9023062028 `
  -ConfluenceEmail you@emishealthgroup.com `
  -ConfluenceToken <API_TOKEN> `
  -PublishToConfluence
```

> **Security note**: Do not pass `-ConfluenceToken` in shell history or CI variables in plain text. Use a secrets manager (AWS Secrets Manager, Azure Key Vault, or ADO variable groups marked as secret) to inject the token at runtime.

## Output Files

Generated to `scripts/handover-output/` (or the path specified by `-OutputDirectory`):

| File | Description |
|------|-------------|
| `<pd>-production-handover.html` | Confluence Storage Format HTML — ready to publish or review |
| `<pd>-production-handover.json` | Raw AWS metadata — useful for audit, diffing, or downstream tooling |

## Handover Document Sections

Each generated page covers the following sections:

| Section | Content |
|---------|---------|
| Executive Summary | PD number, SDS deployment name, AWS account, region, name prefix, VPC IDs, schedule, generation timestamp |
| Connectivity & External Integration | PSBA public IP, Spine endpoint, SDS deployment name, NLB DNS names |
| NLB Private IP Allocations | Per-AZ static private IPs from SSM Parameter Store (where present) |
| Network Topology | All subnets (ID, name, AZ, CIDR, VPC) |
| Application Tier | APP EC2 instances (instance ID, private IP, type, AMI, subnet, AZ, security groups) |
| Database & RS Tier | DBS/RS EC2 instances including configured primary and secondary IPs from SSM |
| Load Balancers & Target Groups | NLB/ALB name, DNS, type, VPC, AZ-to-subnet mapping, target groups with node membership |
| Parameter Store Allocations | All `/prd-ew-wales/<PdNumber>` SSM parameters |
| Shared Resources (GP01 only) | Shared security groups, IAM policy, SSM outputs, Spine ALB, trust store, NLB |
| Deployment Configuration | Expected instance types, AMI IDs, KMS keys, secrets ARNs, source file references |
| Support Notes | SDS naming pattern, SSM path, PSBA/Spine source file notes |

## IAM Permissions

The AWS identity used must have at minimum:

```json
{
  "Effect": "Allow",
  "Action": [
    "sts:GetCallerIdentity",
    "ec2:DescribeInstances",
    "ec2:DescribeSubnets",
    "ec2:DescribeSecurityGroups",
    "ec2:DescribeVpcs",
    "elasticloadbalancing:DescribeLoadBalancers",
    "elasticloadbalancing:DescribeTargetGroups",
    "elasticloadbalancing:DescribeTargetHealth",
    "ssm:GetParametersByPath",
    "ssm:GetParameters",
    "iam:GetPolicy"
  ],
  "Resource": "*"
}
```

> All calls are **read-only**. The script does not create, modify, or delete any AWS resources.

## GP01 Shared Resource Ownership

GP01 is the shared-resource owner stack in the Wales PRD environment. When run with `-PdNumber GP01`, the script additionally captures:

- Shared security groups (SMB/admin-mgmt, SS-NLBs, core DB WinRM/admin-mgmt)
- Shared IAM policy (`EMISSecretsInstanceRolePolicy-wales`)
- Shared SSM outputs (`/tf/output/NAME_PREFIX`, `/tf/output/DB_NETMASK`)
- Spine ALB (`wales-spine-alb`) — if `deploy_spine_alb = true` in `environment.terragrunt.hcl`
- Spine trust store S3 bucket, Spine ALB certificate ARN
- Host header list for all PD numbers registered against the Spine ALB

## Integration with PIMS / CloudOps Handover

This script is the authoritative tool for pre-handover and post-deployment inventory confirmation for Wales GP deployments. It should be run:

1. **Before handover** — to produce the handover pack for PIMS/CloudOps
2. **After any deployment change** — to refresh the Confluence page with current state
3. **During BAU troubleshooting** — to quickly confirm current AWS resource state without manual console navigation

Handover pages should be published under the agreed Confluence parent page in the Hosting Services space and set to full-width layout (handled automatically by the script).
