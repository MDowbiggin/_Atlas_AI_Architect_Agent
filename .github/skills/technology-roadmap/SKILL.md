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
- Reviewing OS EOL/EOS dates (Windows Server, RHEL, Ubuntu) before committing to a platform
- Verifying container platform version currency (AKS/EKS N-1 policy)
- Assessing the VMware/Broadcom VCF renewal decision (October 2026 critical milestone)
- Introducing a new technology not currently in the standards table (triggers ARB approval process)
- Selecting security tooling (EDR, PAM, vulnerability scanning, network detection) — see [references/security-tooling.md](./references/security-tooling.md)
- Checking approved messaging, API gateway, or serverless patterns for AWS workloads

## Technology Principles

1. **Strategic Platform First** — AWS is the default for all new cloud workloads; Azure is the secondary platform for M365-integrated or Azure-native workloads; deviations must be documented with clear justification; never select a platform based on team preference alone
2. **Infrastructure as Code Always** — every production change must be codified in IaC (Terraform, Bicep, or Ansible); manual provisioning is prohibited; a change not in source control has not happened
3. **Approved Technology Mandate** — only technologies listed as Strategic or Tactical in the standards table may be used in production; any technology not in the table requires Architecture Review Board (ARB) approval before adoption; do not introduce new tools without governance
4. **Platform Currency** — all platforms must be maintained within N-1 of the current supported release; N-2 requires documented risk acceptance; N-3 or beyond is prohibited and constitutes a critical risk that must be escalated; apply this equally to OS, database engines, container platforms, and IaC tooling
5. **Avoid Vendor Lock-in Where Practical** — prefer open standards and cloud-agnostic tooling where features, cost, and complexity are equivalent; proprietary managed services are acceptable where they deliver clear operational or cost benefit; always assess exit/portability costs at design time
6. **Tagging and Naming Compliance** — all cloud and on-premises resources must be named and tagged per the standards in [naming-tagging-policy.md](../sources/references/naming-tagging-policy.md); untagged resources are subject to automated remediation and may be scheduled for deletion
7. **FinOps Integration** — technology selection must always include cost impact assessment; right-sizing, reserved capacity, and auto-scaling are standard practice; validate compute choices against AWS Graviton / Spot / Savings Plans and Azure Reserved VM Instances before finalising design
8. **Lifecycle Planning** — every technology adoption decision must include an exit plan; define what triggers migration away from a platform (EOL date, cost cliff, vendor behaviour); VMware/Broadcom (Oct 2026), Windows Server 2019 (Jan 2029), RHEL 8 (May 2029) are known near-term milestones

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
| **Cloud (Primary)** | AWS | — | — |
| **Cloud (Secondary)** | Microsoft Azure | — | — |
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
| **Identity (Cloud)** | Azure AD / Entra ID, AWS IAM Identity Center | — | Long-lived IAM users, local accounts |
| **PAM (Privileged Access)** | Delinea Secret Server | — | Embedded credentials, password files |
| **EDR / AV** | CrowdStrike Falcon | — | Windows Defender alone (on cloud VMs), legacy AV (Symantec, McAfee) |
| **Vulnerability Management** | Tenable.io / Nessus | — | Manual scanning, ad-hoc tools |
| **Network Detection & Response** | Darktrace | — | — |
| **IDP (Internal Developer Portal)** | Backstage (hub.emis-x.uk) | — | SharePoint-only documentation |
| **Messaging / Eventing** | AWS SQS, AWS SNS, Azure Service Bus | RabbitMQ (on-prem legacy) | ActiveMQ, MSMQ |
| **API Gateway** | AWS API Gateway, Azure API Management (APIM) | — | Custom reverse proxy without governance |
| **Serverless Compute** | AWS Lambda, Azure Functions | — | — |
| **WAN / Connectivity** | ExpressRoute (Azure), AWS Direct Connect | COLT, Redcentric (on-prem WAN) | ADSL/FTTC circuits for production |

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

### For New Technology Introduction (ARB Gate)

1. Confirm the technology is **not** already in the standards table (if present, use the listed strategic option)
2. Document the technology, vendor, version, and use case in an Architecture Decision Record (ADR) — see [decision-making skill](..\..decision-making\SKILL.md)
3. Complete the **Options Analysis**: minimum 3 options including a do-nothing/strategic-alternative option
4. Assess security posture against CIS, NIST, and HIPAA controls — see [security-compliance skill](..\..security-compliance\SKILL.md)
5. Include a **total cost of ownership (TCO)** estimate and identify any licence compliance requirements
6. Identify exit/migration path and data portability considerations
7. Submit to **ARB** with ADR, options analysis, cost estimate, and security review — see [ARB Guidance](..\decision-making\references\arb-guidance.md)
8. After ARB approval, update the standards table in this SKILL.md and notify the architecture team

## References

- [Azure Standards](./references/azure-standards.md) — Azure service selection, regions, SKU guidance, compute, storage, database, monitoring, APIM, Defender for Cloud
- [AWS Standards](./references/aws-standards.md) — AWS service selection, regions, EC2, ECS/EKS/Fargate, Lambda, SQS/SNS, API Gateway, WAF, security services, cost optimisation
- [AWS Landing Zone & Control Tower](./references/aws-landing-zone.md) — Multi-account strategy, Organizations, Control Tower, SCPs, account vending, IAM Identity Center, network-per-account design
- [On-Prem & VMware](./references/on-prem-vmware.md) — VMware vSphere, vSAN, NSX, VCF 9 / Broadcom renewal (Oct 2026), physical infrastructure, hybrid integration
- [Networking](./references/networking.md) — Network design, AWS VPC/TGW/Route 53, Azure hub-spoke, DNS, load balancing, firewalls, VPC endpoints
- [Automation & IaC](./references/automation-iac.md) — Terraform (Azure + AWS backends), Ansible, Bicep, CloudFormation, ADO pipeline standards, code review checklist
- [Tooling](./references/tooling-ado-vsc-servicenow-dynatrace.md) — ADO, VS Code extensions, ServiceNow ITSM/CMDB, Dynatrace observability and alerting standards
- [Security Tooling](./references/security-tooling.md) — CrowdStrike Falcon (EDR), Tenable.io (vulnerability), Delinea Secret Server (PAM), Darktrace (NDR), Palo Alto (firewall) deployment and configuration standards
