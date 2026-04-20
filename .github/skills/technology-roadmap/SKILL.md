---
name: technology-roadmap
description: "Technology standards, approved platforms, and migration paths for EMIS/Optum infrastructure. Use when: selecting technologies, checking approved/deprecated platforms, designing with Azure, AWS, VMware, networking, IaC (Terraform/Ansible/Bicep), automation, ADO pipelines, ServiceNow, Dynatrace, or evaluating technology currency."
---

# Technology Roadmap & Standards

## When to Use

- Selecting technologies for a new or re-platformed solution
- Checking whether a technology is approved, deprecated, or under evaluation
- Designing infrastructure across Azure, AWS, on-prem (VMware), or hybrid environments
- Configuring automation, IaC, CI/CD pipelines, monitoring, or ITSM tooling
- Evaluating technology currency and identifying upgrade/migration paths
- Responding to demand reviews with technology recommendations

## Technology Lifecycle Stages

| Stage | Meaning | Action |
|-------|---------|--------|
| **Strategic** | Actively invested in; preferred for new designs | Use by default |
| **Tactical** | Approved for current use; not for new greenfield projects | Use where already deployed; plan migration |
| **Containment** | Deprecated; must not be used in new designs | Migrate to strategic alternative; document timeline |
| **Retired** | End of support; must be decommissioned | Immediate migration required; raise risk if still in use |

## Technology Standards Summary

| Domain | Strategic | Tactical | Containment |
|--------|-----------|----------|-------------|
| **Cloud (Primary)** | Microsoft Azure | — | — |
| **Cloud (Secondary)** | AWS | — | — |
| **Virtualisation** | VMware vSphere 8.x | vSphere 7.x | vSphere 6.x |
| **Containers** | AKS / EKS | Docker Compose | — |
| **IaC** | Terraform, Azure Bicep | ARM Templates, CloudFormation | Manual provisioning |
| **Config Management** | Ansible | — | Puppet, Chef |
| **CI/CD** | Azure DevOps Pipelines | — | Jenkins |
| **Monitoring (APM)** | Dynatrace | — | AppDynamics, Nagios |
| **Monitoring (Platform)** | Azure Monitor, CloudWatch | — | — |
| **ITSM** | ServiceNow | — | — |
| **Source Control** | Azure DevOps Git | — | SVN, TFS |
| **Secrets Management** | Azure Key Vault, AWS Secrets Manager | HashiCorp Vault | Embedded credentials |
| **DNS** | Azure DNS, AWS Route 53 | On-prem BIND/AD DNS | — |
| **Load Balancing** | Azure App Gateway, ALB/NLB | F5 BIG-IP (on-prem) | — |
| **Firewall** | Azure Firewall, Palo Alto | — | — |
| **Backup** | Azure Backup, Veeam | — | Legacy tape-based |
| **OS (Server)** | Windows Server 2022, RHEL 9, Ubuntu 22.04 LTS | Windows Server 2019, RHEL 8 | Windows Server 2016 and earlier |

## Procedure

### For Technology Selection

1. Check the standards table above for the technology domain
2. Load the relevant reference file for detailed guidance:
   - [Azure Standards](./references/azure-standards.md)
   - [AWS Standards](./references/aws-standards.md)
   - [On-Prem & VMware](./references/on-prem-vmware.md)
   - [Networking](./references/networking.md)
   - [Automation & IaC](./references/automation-iac.md)
   - [Tooling](./references/tooling-ado-vsc-servicenow-dynatrace.md)
3. If the requested technology is **Containment** or **Retired**, flag it and propose the Strategic alternative
4. If the technology is not listed, flag as requiring Architecture Review Board (ARB) approval for new technology introduction

### For Technology Currency Assessment

1. Compare the current environment against the standards table
2. Identify components in Containment or Retired status
3. Produce a remediation roadmap with priority (security risk > compliance risk > operational risk > cost)
4. Estimate migration effort and cost

## References

- [Azure Standards](./references/azure-standards.md) — Azure service selection, regions, SKU guidance
- [AWS Standards](./references/aws-standards.md) — AWS service selection, regions, instance types
- [On-Prem & VMware](./references/on-prem-vmware.md) — VMware vSphere, vSAN, NSX, on-prem compute/storage
- [Networking](./references/networking.md) — Network design, SD-WAN, DNS, load balancing, firewalls
- [Automation & IaC](./references/automation-iac.md) — Terraform, Ansible, Bicep, CloudFormation standards
- [Tooling](./references/tooling-ado-vsc-servicenow-dynatrace.md) — ADO, VS Code, ServiceNow, Dynatrace configuration
