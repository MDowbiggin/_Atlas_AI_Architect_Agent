# Automation & Infrastructure-as-Code Standards

## Overview

All infrastructure at EMIS/Optum must be defined and managed as code. Manual provisioning is prohibited for production environments. This reference defines standards for IaC tooling, configuration management, and CI/CD pipelines.

## IaC Tooling Standards

### Terraform (Strategic — Primary)

**Use For**: Multi-cloud infrastructure provisioning (Azure and AWS), complex environments, modular reusable designs.

**Version Standards**:
- Terraform CLI: ≥ 1.6.x (use latest stable)
- AzureRM Provider: ≥ 3.x (track latest minor)
- AWS Provider: ≥ 5.x (track latest minor)

**Code Standards**:

```hcl
# Module structure
modules/
├── compute/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── README.md
├── networking/
├── storage/
└── security/

environments/
├── dev/
│   ├── main.tf        # Module calls with dev parameters
│   ├── variables.tf
│   ├── terraform.tfvars
│   └── backend.tf     # Remote state config
├── test/
├── staging/
└── prod/
```

**Mandatory Practices**:
- **Remote State**: Azure workloads → Azure Storage Account with state locking (blob lease); AWS workloads → S3 bucket + DynamoDB table (see examples below)
- **State Isolation**: Separate state file per environment (and per account for AWS multi-account)
- **Naming Convention**: `rg-<app>-<env>-<region>` for Azure resource groups; follow naming standards per platform
- **Tagging**: All resources must include mandatory tags (CostCentre, Environment, Owner, Application, Project, ManagedBy)
- **Secrets**: Never hardcode credentials; use Azure Key Vault data sources or AWS Secrets Manager / SSM Parameter Store
- **Plan Before Apply**: `terraform plan` output must be reviewed before `terraform apply`
- **Linting**: `terraform fmt` and `tflint` in CI pipeline
- **Security Scanning**: `tfsec` or `checkov` in CI pipeline; block deployment on high-severity findings
- **Module Versioning**: Pin module versions; use semantic versioning

**Azure Remote State Backend**:
```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-shared"
    storage_account_name = "stterraformstate001"
    container_name       = "tfstate"
    key                  = "${var.application}/${var.environment}.tfstate"
  }
}
```

**AWS Remote State Backend** (S3 + DynamoDB lock):
```hcl
terraform {
  backend "s3" {
    bucket         = "emis-terraform-state-shared"
    key            = "${var.application}/${var.environment}/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "emis-terraform-state-lock"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:eu-west-2:<shared-account-id>:key/<key-id>"
    # Cross-account: role in shared services account holds the state bucket
    role_arn       = "arn:aws:iam::<shared-account-id>:role/TerraformStateRole"
  }
}
```

> The S3 state bucket must have: versioning enabled, SSE-KMS encryption, Block Public Access, MFA Delete, and Object Lock (optional but recommended). The DynamoDB table must have `LockID` as the partition key (String).

### Azure Bicep (Strategic — Azure-Only)

**Use For**: Azure-only infrastructure, Azure-native teams, ARM-equivalent deployments with simpler syntax.

**Standards**:
- Bicep CLI: Latest stable
- Use `@description()` decorators for all parameters
- Modular design: one `.bicep` file per resource type
- Parameter files per environment: `main.prod.bicepparam`, `main.dev.bicepparam`
- Deploy via ADO Pipelines using `az deployment group create`

### ARM Templates (Tactical)

- Existing ARM templates continue to function but should not be used for new development
- Migrate to Bicep using `az bicep decompile` when modifying existing templates
- No new ARM template development

### AWS CloudFormation (Tactical — AWS-Only)

**Use For**: AWS-only infrastructure where Terraform is not yet adopted.

**Standards**:
- Use YAML format (not JSON)
- Nested stacks for modular design
- StackSets for multi-account deployment
- cfn-lint in CI pipeline

## Configuration Management

### Ansible (Strategic)

**Use For**: Post-provisioning configuration, application deployment, OS hardening, patching orchestration.

**Version**: Ansible Core ≥ 2.15; Collections model (not legacy roles from Galaxy)

**Standards**:

```yaml
# Directory structure
ansible/
├── inventory/
│   ├── production/
│   │   ├── hosts.yml
│   │   └── group_vars/
│   └── development/
├── playbooks/
│   ├── site.yml
│   ├── webservers.yml
│   └── databases.yml
├── roles/
│   ├── common/
│   ├── hardening/
│   └── monitoring/
└── ansible.cfg
```

**Mandatory Practices**:
- **Inventory**: Dynamic inventory from Azure/AWS/VMware (no static inventory for cloud)
- **Vault**: Use Ansible Vault for secrets; integrate with Azure Key Vault for runtime secrets
- **Idempotency**: All playbooks must be idempotent (safe to re-run)
- **Testing**: Use Molecule for role testing; lint with `ansible-lint`
- **Tags**: Use tags for selective execution; document available tags per playbook

## CI/CD Pipeline Standards (Azure DevOps)

### Pipeline Structure

```yaml
# azure-pipelines.yml (IaC deployment)
trigger:
  branches:
    include:
      - main
  paths:
    include:
      - 'infrastructure/**'

stages:
  - stage: Validate
    jobs:
      - job: Lint
        steps:
          - script: terraform fmt -check
          - script: tflint
          - script: tfsec .
  
  - stage: Plan
    jobs:
      - job: TerraformPlan
        steps:
          - script: terraform plan -out=tfplan
          # Publish plan as artifact for review
  
  - stage: Apply_Dev
    dependsOn: Plan
    condition: succeeded()
    jobs:
      - deployment: TerraformApply
        environment: 'dev'
        strategy:
          runOnce:
            deploy:
              steps:
                - script: terraform apply tfplan
  
  - stage: Apply_Prod
    dependsOn: Apply_Dev
    condition: succeeded()
    jobs:
      - deployment: TerraformApply
        environment: 'prod'  # Requires manual approval
        strategy:
          runOnce:
            deploy:
              steps:
                - script: terraform apply tfplan
```

**Standards**:
- **Branch Policy**: `main` branch protected; PRs required with minimum 1 reviewer
- **Environment Approvals**: Production deployments require manual approval gate
- **Service Connections**: Managed Identity or Service Principal with minimum RBAC permissions
- **Artefact Storage**: Terraform plans stored as pipeline artefacts for audit trail
- **Variable Groups**: Use ADO variable groups linked to Azure Key Vault for secrets
- **Pipeline Templates**: Use YAML templates for reusable pipeline fragments

## Code Review Checklist (IaC)

- [ ] Resource naming follows convention
- [ ] Mandatory tags applied to all resources
- [ ] No hardcoded secrets or credentials
- [ ] Remote state configured with locking
- [ ] Security scanning (tfsec/checkov) passes with no high-severity findings
- [ ] Terraform plan reviewed and approved
- [ ] Rollback procedure documented
- [ ] README updated with deployment instructions
