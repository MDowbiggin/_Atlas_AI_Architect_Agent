# PD Production Support Handover — Operational Guide

## Contents

1. [Script Parameters](#script-parameters)
2. [Input File Format](#input-file-format)
3. [Terragrunt Configuration Keys](#terragrunt-configuration-keys)
4. [AWS Resources Queried](#aws-resources-queried)
5. [Confluence Integration](#confluence-integration)
6. [Security Considerations](#security-considerations)
7. [Troubleshooting](#troubleshooting)
8. [Extending the Script](#extending-the-script)

---

## Script Parameters

| Parameter | Mandatory | Default | Description |
|-----------|-----------|---------|-------------|
| `-PdNumber` | ✅ | — | GP deployment identifier: `GP01`–`GP10` |
| `-ParentPageId` | ✅ | — | Confluence page ID of the parent page to create/update under |
| `-ConfluenceBaseUrl` | ❌ | `https://emishealthgroup.atlassian.net` | Confluence instance base URL |
| `-ConfluenceEmail` | ❌ | — | Confluence account email — required when `-PublishToConfluence` is used |
| `-ConfluenceToken` | ❌ | — | Confluence API token — required when `-PublishToConfluence` is used |
| `-AwsRegion` | ❌ | `eu-west-2` | AWS region to query |
| `-AwsProfile` | ❌ | — | Named AWS CLI profile; omit to use the default/environment credentials |
| `-OutputDirectory` | ❌ | `scripts/handover-output/` | Local directory to write HTML and JSON output files |
| `-PsbaAddressFile` | ❌ | `../misc/psba_addresses.txt` | Path to the PSBA address source file (relative to `scripts/`) |
| `-SpineEndpointFile` | ❌ | `../misc/dns_and_certificates_list.txt` | Path to the Spine endpoint source file (relative to `scripts/`) |
| `-PublishToConfluence` | ❌ | `$false` | Switch: if set, creates or updates the Confluence child page |
| `-DryRun` | ❌ | `$false` | Switch: suppresses the Confluence publish warning; useful to confirm local-only runs |

---

## Input File Format

### `psba_addresses.txt`

One public IP address (or FQDN) per line, ordered by GP number (line 1 = GP01, line 2 = GP02, etc.). Blank lines are ignored.

```text
203.0.113.10
203.0.113.11
203.0.113.12
```

### `dns_and_certificates_list.txt`

One Spine endpoint hostname per line, ordered by GP number (line 1 = GP01, line 2 = GP02, etc.). Whitespace is stripped. Blank lines are ignored.

```text
awswa-gp01.spine.emis.thirdparty.nhs.uk
awswa-gp02.spine.emis.thirdparty.nhs.uk
awswa-gp03.spine.emis.thirdparty.nhs.uk
```

> Both files must have at least as many non-blank entries as the highest GP number being generated. If the index is out of range, the script will throw a terminating error.

---

## Terragrunt Configuration Keys

The script reads the following keys from HCL configuration files. All keys use string or boolean literal syntax (no variable interpolation).

### `environment.terragrunt.hcl` (shared environment config)

| Key | Type | Used For |
|-----|------|----------|
| `vpc_id` | string | App VPC ID display in summary |
| `db_vpc_id` | string | DB VPC ID display in summary |
| `pd_builder_secret_arn` | string | Deployment configuration table |
| `managed_ad_key_arn` | string | Deployment configuration table |
| `spine_alb_certificate_arn` | string | Spine ALB certificate reference (GP01) |
| `spine_alb_pd_numbers` | list(string) | Host header list for GP01 shared resources |
| `spine_trust_store_bundle_file` | string | Spine trust store bundle filename |

### `<PdNumber>/pd.terragrunt.hcl` (per-PD config)

| Key | Type | Used For |
|-----|------|----------|
| `name_prefix` | string | AWS resource tag prefix for instance discovery |
| `directory_short_name` | string | Summary table display |
| `app_ami_id` | string | Expected AMI for APP instances |
| `db_ami_id` | string | Expected AMI for DBS/RS instances |
| `app_instance_type` | string | Expected instance type for APP tier |
| `db_instance_type` | string | Expected instance type for DB/RS tier |
| `schedule` | string | Shutdown/start schedule for the deployment |
| `deploy_spine_alb` | bool | Whether to include Spine ALB in GP01 shared resources section |

---

## AWS Resources Queried

| AWS Service | API Call | Purpose |
|-------------|----------|---------|
| STS | `GetCallerIdentity` | Confirm account ID for page content and ARN construction |
| EC2 | `DescribeInstances` | APP and DBS/RS instance inventory (tag-based filter: `<NamePrefix><PdNumber>APP*`, `DBS*`, `RS*`) |
| EC2 | `DescribeSubnets` | Subnet name, AZ, CIDR for all subnets used by instances and LBs |
| EC2 | `DescribeSecurityGroups` | Security group names and descriptions for all attached groups |
| EC2 | `DescribeVpcs` | VPC CIDR and name for display |
| ELBv2 | `DescribeLoadBalancers` | All load balancers matching expected names (`wales-<pd>-nlb`, `wales-<pd>-nlb-docs`, `wales-spine-nlb`) |
| ELBv2 | `DescribeTargetGroups` | Target groups per load balancer |
| ELBv2 | `DescribeTargetHealth` | Node health state per target group |
| SSM | `GetParametersByPath` | All parameters under `/prd-ew-wales/<PdNumber>` |
| SSM | `GetParameters` | Shared SSM outputs (`/tf/output/NAME_PREFIX`, `/tf/output/DB_NETMASK`) — GP01 only |
| IAM | `GetPolicy` | Shared IAM policy metadata — GP01 only |
| EC2 | `DescribeSecurityGroups` (shared) | Shared security groups by tag Name — GP01 only |
| ELBv2 | `DescribeLoadBalancers` (Spine ALB) | `wales-spine-alb` — GP01 with `deploy_spine_alb = true` only |

---

## Confluence Integration

### Page Lifecycle

1. The script resolves the Confluence space ID from the provided `ParentPageId`.
2. It searches for an existing child page with the title `<PdNumber> Production Support Handover` under the same parent.
3. **If found**: the page is updated (version incremented, body replaced).
4. **If not found**: a new child page is created under the parent.
5. After create or update, the script sets the page appearance to **full-width** using the `content-appearance-draft` and `content-appearance-published` Confluence content properties.

### Authentication

The script uses HTTP Basic authentication with a Confluence API token. The token is passed at runtime via `-ConfluenceToken`. It is **never** written to disk or included in any output file.

To generate a Confluence API token:
1. Log in to `https://id.atlassian.com/manage-profile/security/api-tokens`
2. Create a new token with a descriptive label (e.g. `PD Handover Script`)
3. Pass the token value to `-ConfluenceToken` at runtime — do not store it in scripts or repository files

### Finding the Parent Page ID

Navigate to the Confluence parent page and copy the numeric ID from the URL:
```
https://emishealthgroup.atlassian.net/wiki/spaces/HS/pages/9023062028/...
                                                              ^^^^^^^^^^
                                                              This is the ParentPageId
```

---

## Security Considerations

| Concern | Mitigation |
|---------|-----------|
| Confluence API token exposure | Token passed at runtime only; never written to disk or output files; use ADO secret variable groups or AWS Secrets Manager in CI/CD pipelines |
| PHI/PII in output | The script does not query or output any patient data; all data is infrastructure metadata; output files should be classified as **Confidential** (internal infrastructure detail) |
| AWS credential scope | Use a least-privilege read-only IAM role or policy; the script requires no write permissions to any AWS service |
| Output file residency | `handover-output/` files contain infrastructure topology detail; ensure the directory is excluded from public source control (`.gitignore`) and stored or transmitted only over encrypted channels |
| Confluence page classification | Generated pages contain internal infrastructure detail; ensure the Confluence space has appropriate access controls; do not publish to public or externally accessible spaces |
| Shell history | Avoid passing `-ConfluenceToken` directly on the command line in shared environments; use a prompt, environment variable, or secrets manager to supply the value |

---

## Troubleshooting

### `No running or stopped instances found for <PdNumber>`

**Cause**: The tag-based EC2 filter returned no results. Either:
- The `name_prefix` in `pd.terragrunt.hcl` is incorrect
- The instances are in a terminated or other non-running state
- The AWS profile/region does not match the target account

**Fix**: Verify the `name_prefix` value and check EC2 instance state in the AWS Console or with:
```powershell
aws ec2 describe-instances --filters "Name=tag:Name,Values=<prefix><PdNumber>APP*" --region eu-west-2
```

### `Source file does not contain an entry for index <N>`

**Cause**: The PSBA address file or Spine endpoint file has fewer entries than the GP number requires (e.g. GP07 requires at least 7 non-blank lines).

**Fix**: Ensure both data files have a complete entry for every GP number being generated.

### `AWS CLI error (exit 255): Unable to locate credentials`

**Cause**: No valid AWS credentials found for the execution context.

**Fix**: Configure an AWS profile (`aws configure --profile <name>`) or ensure the execution environment has instance profile / environment variable credentials set. Pass `-AwsProfile <name>` if using a named profile.

### `ConfluenceEmail and ConfluenceToken are required`

**Cause**: `-PublishToConfluence` was passed but credentials were not provided.

**Fix**: Always supply both `-ConfluenceEmail` and `-ConfluenceToken` when using `-PublishToConfluence`.

### `HTTP 404` on Confluence page update

**Cause**: The `ParentPageId` does not exist or the authenticated user does not have access to the space.

**Fix**: Verify the page ID in the Confluence URL and confirm the API token account has edit permissions on the target space.

### `Environment config not found` / `PD config not found`

**Cause**: The script resolves Terragrunt config paths relative to `$PSScriptRoot/../`. If the script is not located in the `scripts/` subdirectory of the repository root, path resolution will fail.

**Fix**: Run the script from the `scripts/` subdirectory of the repository, or adjust the `$repoRoot` derivation if the repo structure differs.

---

## Extending the Script

### Adding a New Section

1. Collect the required data using `Invoke-AwsJson` or by reading from the config/files
2. Build a row array in the pattern `@(,@('Field', 'Value'), ...)`
3. Call `ConvertTo-HtmlTable` or `ConvertTo-HtmlList` with appropriate headers
4. Add the result to `$bodyParts` at the desired position
5. Update `$payload.Metadata` if the raw data should also appear in the JSON output

### Adding a New GP Number

1. Add the PSBA address to `psba_addresses.txt` at the correct line position
2. Add the Spine endpoint to `dns_and_certificates_list.txt` at the correct line position
3. Create `terragrunt/prd/<NewPdNumber>/pd.terragrunt.hcl` in the repository
4. Update the `ValidateSet` on `-PdNumber` in the script `param()` block to include the new value

### Running in CI/CD (ADO Pipeline)

```yaml
- task: AWSShellScript@1
  inputs:
    awsCredentials: '<service-connection>'
    regionName: 'eu-west-2'
    scriptType: 'inline'
    inlineScript: |
      pwsh -Command "./scripts/Create-ConfluencePdHandover.ps1 \
        -PdNumber $(PD_NUMBER) \
        -ParentPageId $(CONFLUENCE_PARENT_PAGE_ID) \
        -ConfluenceEmail $(CONFLUENCE_EMAIL) \
        -ConfluenceToken $(CONFLUENCE_TOKEN) \
        -PublishToConfluence"
```

> Mark `CONFLUENCE_TOKEN` as a secret variable in the ADO variable group. Never echo it or write it to pipeline logs.
