#Requires -Version 7.0
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('GP01','GP02','GP03','GP04','GP05','GP06','GP07','GP08','GP09','GP10')]
    [string]$PdNumber,

    [Parameter(Mandatory)]
    [string]$ParentPageId,

    [string]$ConfluenceBaseUrl = 'https://emishealthgroup.atlassian.net',
    [string]$ConfluenceEmail = '',
    [string]$ConfluenceToken = '',
    [string]$AwsRegion = 'eu-west-2',
    [string]$AwsProfile = '',
    [string]$OutputDirectory = (Join-Path $PSScriptRoot 'handover-output'),
    [string]$PsbaAddressFile = (Join-Path $PSScriptRoot '..\..\misc\psba_addresses.txt'),
    [string]$SpineEndpointFile = (Join-Path $PSScriptRoot '..\..\misc\dns_and_certificates_list.txt'),
    [switch]$PublishToConfluence,
    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-HtmlText {
    param([AllowNull()][object]$Value)

    if ($null -eq $Value) { return '' }
    return [System.Security.SecurityElement]::Escape([string]$Value)
}

function Invoke-AwsJson {
    param([string[]]$CliArgs)

    $allArgs = @()
    if ($AwsProfile) {
        $allArgs += @('--profile', $AwsProfile)
    }
    $allArgs += $CliArgs
    $allArgs += @('--region', $AwsRegion, '--output', 'json')

    $raw = aws @allArgs 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "AWS CLI error (exit $LASTEXITCODE): $raw"
    }
    if ([string]::IsNullOrWhiteSpace(($raw | Out-String))) {
        return $null
    }
    return $raw | ConvertFrom-Json -Depth 20
}

function Get-HclLiteralValue {
    param(
        [string]$Content,
        [string]$Name
    )

    $pattern = '(?m)^\s*{0}\s*=\s*"([^"]*)"' -f [regex]::Escape($Name)
    $match = [regex]::Match($Content, $pattern)
    if ($match.Success) {
        return $match.Groups[1].Value
    }
    return ''
}

function Get-HclBooleanValue {
    param(
        [string]$Content,
        [string]$Name
    )

    $pattern = '(?m)^\s*{0}\s*=\s*(true|false)' -f [regex]::Escape($Name)
    $match = [regex]::Match($Content, $pattern)
    if (-not $match.Success) {
        return $false
    }
    return [System.Convert]::ToBoolean($match.Groups[1].Value)
}

function Get-HclStringListValue {
    param(
        [string]$Content,
        [string]$Name
    )

    $pattern = '(?s)\b{0}\b\s*=\s*\[(.*?)\]' -f [regex]::Escape($Name)
    $match = [regex]::Match($Content, $pattern)
    if (-not $match.Success) {
        return @()
    }

    return @([regex]::Matches($match.Groups[1].Value, '"([^"]+)"') | ForEach-Object { $_.Groups[1].Value })
}

function Get-OrderedSourceValue {
    param(
        [string]$Path,
        [int]$Index,
        [switch]$StripWhitespace
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Required source file not found: $Path"
    }

    $lines = Get-Content -LiteralPath $Path | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    if ($Index -ge $lines.Count) {
        throw "Source file $Path does not contain an entry for index $Index"
    }

    $value = $lines[$Index].Trim()
    if ($StripWhitespace) {
        $value = $value -replace '\s+', ''
    }
    return $value
}

function ConvertTo-HtmlList {
    param([object[]]$Items)

    if (-not $Items -or $Items.Count -eq 0) {
        return '<p>None</p>'
    }

    $buffer = New-Object System.Collections.Generic.List[string]
    $buffer.Add('<ul>')
    foreach ($item in $Items) {
        $buffer.Add("<li>$(ConvertTo-HtmlText $item)</li>")
    }
    $buffer.Add('</ul>')
    return ($buffer -join "`n")
}

function ConvertTo-HtmlTable {
    param(
        [string[]]$Headers,
        [object[]]$Rows
    )

    $buffer = New-Object System.Collections.Generic.List[string]
    $buffer.Add('<table data-table-width="1800" data-layout="center">')
    $buffer.Add('<tbody>')
    $buffer.Add('<tr>')
    foreach ($header in $Headers) {
        $buffer.Add("<th><p>$(ConvertTo-HtmlText $header)</p></th>")
    }
    $buffer.Add('</tr>')

    foreach ($row in $Rows) {
        $buffer.Add('<tr>')
        foreach ($cell in $row) {
            $text = if ($cell -is [string] -and $cell -match '^<') { $cell } else { "<p>$(ConvertTo-HtmlText $cell)</p>" }
            $buffer.Add("<td>$text</td>")
        }
        $buffer.Add('</tr>')
    }

    $buffer.Add('</tbody>')
    $buffer.Add('</table>')
    return ($buffer -join "`n")
}

function Get-ConfluenceHeaders {
    if ([string]::IsNullOrWhiteSpace($ConfluenceEmail) -or [string]::IsNullOrWhiteSpace($ConfluenceToken)) {
        throw 'ConfluenceEmail and ConfluenceToken are required when -PublishToConfluence is used.'
    }

    $authB64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("${ConfluenceEmail}:${ConfluenceToken}"))
    return @{
        Authorization = "Basic $authB64"
        Accept = 'application/json'
    }
}

function Get-ConfluencePage {
    param([string]$PageId)

    $headers = Get-ConfluenceHeaders
    $uri = "${ConfluenceBaseUrl}/wiki/api/v2/pages/${PageId}?body-format=storage"
    return Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
}

function Find-ConfluenceChildPage {
    param(
        [string]$SpaceId,
        [string]$Title,
        [string]$ExpectedParentId
    )

    $headers = Get-ConfluenceHeaders
    $encodedTitle = [System.Uri]::EscapeDataString($Title)
    $uri = "${ConfluenceBaseUrl}/wiki/api/v2/pages?space-id=${SpaceId}&title=${encodedTitle}"
    $result = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
    return @($result.results | Where-Object { $_.parentId -eq $ExpectedParentId } | Select-Object -First 1)
}

function New-ConfluencePage {
    param(
        [string]$SpaceId,
        [string]$Title,
        [string]$ParentId,
        [string]$Body
    )

    $headers = Get-ConfluenceHeaders
    $uri = "${ConfluenceBaseUrl}/wiki/api/v2/pages"
    $payload = @{
        spaceId = $SpaceId
        status = 'current'
        title = $Title
        parentId = $ParentId
        body = @{
            representation = 'storage'
            value = $Body
        }
    } | ConvertTo-Json -Depth 10

    return Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $payload -ContentType 'application/json'
}

function Update-ConfluencePage {
    param(
        [string]$PageId,
        [string]$Title,
        [int]$Version,
        [string]$SpaceId,
        [string]$ParentId,
        [string]$Body
    )

    $headers = Get-ConfluenceHeaders
    $uri = "${ConfluenceBaseUrl}/wiki/api/v2/pages/${PageId}"
    $payload = @{
        id = $PageId
        status = 'current'
        title = $Title
        spaceId = $SpaceId
        parentId = $ParentId
        body = @{
            representation = 'storage'
            value = $Body
        }
        version = @{
            number = $Version
            message = "Refresh $Title from AWS inventory"
        }
    } | ConvertTo-Json -Depth 10

    return Invoke-RestMethod -Uri $uri -Headers $headers -Method Put -Body $payload -ContentType 'application/json'
}

function Get-HttpStatusCodeFromError {
    param([System.Management.Automation.ErrorRecord]$ErrorRecord)

    if ($null -eq $ErrorRecord -or $null -eq $ErrorRecord.Exception -or $null -eq $ErrorRecord.Exception.Response) {
        return $null
    }

    try {
        return [int]$ErrorRecord.Exception.Response.StatusCode.value__
    } catch {
        return $null
    }
}

function Set-ConfluencePageProperty {
    param(
        [Parameter(Mandatory)][string]$PageId,
        [Parameter(Mandatory)][string]$PropertyKey,
        [Parameter(Mandatory)][object]$PropertyValue
    )

    $headers = Get-ConfluenceHeaders
    $getUri = "${ConfluenceBaseUrl}/wiki/rest/api/content/${PageId}/property/${PropertyKey}"

    try {
        $existing = Invoke-RestMethod -Uri $getUri -Headers $headers -Method Get
        $payload = @{
            key = $PropertyKey
            value = $PropertyValue
            version = @{ number = ([int]$existing.version.number + 1) }
        } | ConvertTo-Json -Depth 8

        Invoke-RestMethod -Uri $getUri -Headers $headers -Method Put -Body $payload -ContentType 'application/json' | Out-Null
    } catch {
        $statusCode = Get-HttpStatusCodeFromError -ErrorRecord $_
        if ($statusCode -ne 404) {
            throw
        }

        $postUri = "${ConfluenceBaseUrl}/wiki/rest/api/content/${PageId}/property"
        $payload = @{
            key = $PropertyKey
            value = $PropertyValue
        } | ConvertTo-Json -Depth 8

        Invoke-RestMethod -Uri $postUri -Headers $headers -Method Post -Body $payload -ContentType 'application/json' | Out-Null
    }
}

function Set-ConfluencePageWide {
    param([Parameter(Mandatory)][string]$PageId)

    Set-ConfluencePageProperty -PageId $PageId -PropertyKey 'content-appearance-draft' -PropertyValue 'full-width'
    Set-ConfluencePageProperty -PageId $PageId -PropertyKey 'content-appearance-published' -PropertyValue 'full-width'
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$envConfigPath = Join-Path $repoRoot 'terragrunt\prd\environment.terragrunt.hcl'
$pdConfigPath = Join-Path $repoRoot ("terragrunt\prd\$PdNumber\pd.terragrunt.hcl")

if (-not (Test-Path -LiteralPath $envConfigPath)) {
    throw "Environment config not found: $envConfigPath"
}
if (-not (Test-Path -LiteralPath $pdConfigPath)) {
    throw "PD config not found: $pdConfigPath"
}

$envConfig = Get-Content -LiteralPath $envConfigPath -Raw
$pdConfig = Get-Content -LiteralPath $pdConfigPath -Raw

$pdIndex = [int]($PdNumber -replace '\D') - 1
$namePrefix = Get-HclLiteralValue -Content $pdConfig -Name 'name_prefix'
$directoryShortName = Get-HclLiteralValue -Content $pdConfig -Name 'directory_short_name'
$appAmiId = Get-HclLiteralValue -Content $pdConfig -Name 'app_ami_id'
$dbAmiId = Get-HclLiteralValue -Content $pdConfig -Name 'db_ami_id'
$appInstanceTypeExpected = Get-HclLiteralValue -Content $pdConfig -Name 'app_instance_type'
$dbInstanceTypeExpected = Get-HclLiteralValue -Content $pdConfig -Name 'db_instance_type'
$schedule = Get-HclLiteralValue -Content $pdConfig -Name 'schedule'
$deploySpineAlb = Get-HclBooleanValue -Content $pdConfig -Name 'deploy_spine_alb'
$spineAlbPdNumbers = Get-HclStringListValue -Content $envConfig -Name 'spine_alb_pd_numbers'
$appVpcIdConfigured = Get-HclLiteralValue -Content $envConfig -Name 'vpc_id'
$dbVpcIdConfigured = Get-HclLiteralValue -Content $envConfig -Name 'db_vpc_id'
$pdBuilderSecretArn = Get-HclLiteralValue -Content $envConfig -Name 'pd_builder_secret_arn'
$managedAdKeyArn = Get-HclLiteralValue -Content $envConfig -Name 'managed_ad_key_arn'
$spineAlbCertificateArn = Get-HclLiteralValue -Content $envConfig -Name 'spine_alb_certificate_arn'

$psbaAddress = Get-OrderedSourceValue -Path $PsbaAddressFile -Index $pdIndex
$spineEndpointRaw = Get-OrderedSourceValue -Path $SpineEndpointFile -Index $pdIndex
$spineEndpoint = $spineEndpointRaw -replace '\s+', ''
$sdsDeploymentName = "AWS_WA_$PdNumber"
$isSharedOwner = $PdNumber -eq 'GP01'

$identity = Invoke-AwsJson @('sts', 'get-caller-identity')

$tagPrefix = "$namePrefix$PdNumber"
$appInstances = @(
    Invoke-AwsJson @(
        'ec2', 'describe-instances',
        '--filters',
        "Name=tag:Name,Values=${tagPrefix}APP*",
        'Name=instance-state-name,Values=running,stopped',
        '--query',
        'Reservations[].Instances[].{Name:Tags[?Key==`Name`]|[0].Value,InstanceId:InstanceId,PrivateIp:PrivateIpAddress,State:State.Name,InstanceType:InstanceType,SubnetId:SubnetId,VpcId:VpcId,PrivateDns:PrivateDnsName,ImageId:ImageId,SecurityGroups:SecurityGroups[*].GroupId}'
    ) | Sort-Object Name
)

$dbInstances = @(
    Invoke-AwsJson @(
        'ec2', 'describe-instances',
        '--filters',
        "Name=tag:Name,Values=${tagPrefix}DBS*,${tagPrefix}RS*",
        'Name=instance-state-name,Values=running,stopped',
        '--query',
        'Reservations[].Instances[].{Name:Tags[?Key==`Name`]|[0].Value,InstanceId:InstanceId,PrivateIp:PrivateIpAddress,State:State.Name,InstanceType:InstanceType,SubnetId:SubnetId,VpcId:VpcId,PrivateDns:PrivateDnsName,ImageId:ImageId,SecurityGroups:SecurityGroups[*].GroupId}'
    ) | Sort-Object Name
)

$allInstances = @($appInstances + $dbInstances)
if ($allInstances.Count -eq 0) {
    throw "No running or stopped instances found for $PdNumber"
}

$expectedLoadBalancers = @("wales-$($PdNumber.ToLower())-nlb", "wales-$($PdNumber.ToLower())-nlb-docs", 'wales-spine-nlb')
$loadBalancers = @(
    Invoke-AwsJson @(
        'elbv2', 'describe-load-balancers',
        '--query',
        'LoadBalancers[].{Name:LoadBalancerName,DNSName:DNSName,Scheme:Scheme,Type:Type,VpcId:VpcId,State:State.Code,LoadBalancerArn:LoadBalancerArn,CanonicalHostedZoneId:CanonicalHostedZoneId,AvailabilityZones:AvailabilityZones[*].{Zone:ZoneName,SubnetId:SubnetId}}'
    ) |
    Where-Object { $expectedLoadBalancers -contains $_.Name } |
    Sort-Object Name
)

$parameterPath = "/prd-ew-wales/$PdNumber"
$parameters = @(
    Invoke-AwsJson @(
        'ssm', 'get-parameters-by-path',
        '--path', $parameterPath,
        '--with-decryption',
        '--query', 'Parameters[].{Name:Name,Value:Value}'
    ) | Sort-Object Name
)

$subnetIds = [System.Collections.Generic.HashSet[string]]::new()
$securityGroupIds = [System.Collections.Generic.HashSet[string]]::new()
$vpcIds = [System.Collections.Generic.HashSet[string]]::new()

foreach ($instance in $allInstances) {
    [void]$subnetIds.Add($instance.SubnetId)
    [void]$vpcIds.Add($instance.VpcId)
    foreach ($sgId in @($instance.SecurityGroups)) {
        [void]$securityGroupIds.Add($sgId)
    }
}

foreach ($lb in $loadBalancers) {
    [void]$vpcIds.Add($lb.VpcId)
    foreach ($az in @($lb.AvailabilityZones)) {
        [void]$subnetIds.Add($az.SubnetId)
    }
}

$subnetIdArray = @($subnetIds)
$securityGroupIdArray = @($securityGroupIds)
$vpcIdArray = @($vpcIds)

$subnetMap = @{}
if ($subnetIdArray.Count -gt 0) {
    $subnetArgs = @('ec2', 'describe-subnets', '--subnet-ids') + $subnetIdArray + @('--query', 'Subnets[].{SubnetId:SubnetId,AvailabilityZone:AvailabilityZone,CidrBlock:CidrBlock,Name:Tags[?Key==`Name`]|[0].Value,VpcId:VpcId}')
    $subnets = Invoke-AwsJson $subnetArgs
    foreach ($subnet in @($subnets)) {
        $subnetMap[$subnet.SubnetId] = $subnet
    }
}

$securityGroupMap = @{}
if ($securityGroupIdArray.Count -gt 0) {
    $sgArgs = @('ec2', 'describe-security-groups', '--group-ids') + $securityGroupIdArray + @('--query', 'SecurityGroups[].{GroupId:GroupId,GroupName:GroupName,Description:Description}')
    $securityGroups = Invoke-AwsJson $sgArgs
    foreach ($sg in @($securityGroups)) {
        $securityGroupMap[$sg.GroupId] = $sg
    }
}

$vpcMap = @{}
if ($vpcIdArray.Count -gt 0) {
    $vpcArgs = @('ec2', 'describe-vpcs', '--vpc-ids') + $vpcIdArray + @('--query', 'Vpcs[].{VpcId:VpcId,CidrBlock:CidrBlock,Name:Tags[?Key==`Name`]|[0].Value}')
    $vpcs = Invoke-AwsJson $vpcArgs
    foreach ($vpc in @($vpcs)) {
        $vpcMap[$vpc.VpcId] = $vpc
    }
}

$instanceNameById = @{}
foreach ($instance in $allInstances) {
    $instanceNameById[$instance.InstanceId] = $instance.Name
}

$loadBalancerDetails = foreach ($lb in $loadBalancers) {
    $targetGroups = @(
        Invoke-AwsJson @(
            'elbv2', 'describe-target-groups',
            '--load-balancer-arn', $lb.LoadBalancerArn,
            '--query', 'TargetGroups[].{Name:TargetGroupName,Arn:TargetGroupArn,Port:Port,Protocol:Protocol,TargetType:TargetType,HealthCheckProtocol:HealthCheckProtocol,HealthCheckPort:HealthCheckPort}'
        ) | Sort-Object Name
    )

    $targetGroupDetails = foreach ($targetGroup in $targetGroups) {
        $targets = @(
            Invoke-AwsJson @(
                'elbv2', 'describe-target-health',
                '--target-group-arn', $targetGroup.Arn,
                '--query', 'TargetHealthDescriptions[].{Id:Target.Id,Port:Target.Port,State:TargetHealth.State}'
            )
        )

        [pscustomobject]@{
            Name = $targetGroup.Name
            Port = $targetGroup.Port
            Protocol = $targetGroup.Protocol
            HealthCheckProtocol = $targetGroup.HealthCheckProtocol
            HealthCheckPort = $targetGroup.HealthCheckPort
            Nodes = @(
                foreach ($target in $targets) {
                    $friendlyName = if ($instanceNameById.ContainsKey($target.Id)) { $instanceNameById[$target.Id] } else { $target.Id }
                    [pscustomobject]@{
                        Name = $friendlyName
                        TargetId = $target.Id
                        Port = $target.Port
                        State = $target.State
                    }
                }
            )
        }
    }

    [pscustomobject]@{
        Name = $lb.Name
        DNSName = $lb.DNSName
        Scheme = $lb.Scheme
        Type = $lb.Type
        VpcId = $lb.VpcId
        State = $lb.State
        CanonicalHostedZoneId = $lb.CanonicalHostedZoneId
        AvailabilityZones = $lb.AvailabilityZones
        TargetGroups = $targetGroupDetails
    }
}

$parameterMap = @{}
foreach ($parameter in $parameters) {
    $parameterMap[$parameter.Name] = $parameter.Value
}

$sharedResourceRows = @()
$sharedHostHeaderItems = @()
if ($isSharedOwner) {
    $sharedSecurityGroups = @(
        Invoke-AwsJson @(
            'ec2', 'describe-security-groups',
            '--filters',
            "Name=tag:Name,Values=prd-ew-net-sg-nations-wa-app-smb-admgmt,prd-ew-net-sg-nations-ss-nlbs,prd-ew-net-sg-nations-core-db-winrm-admgmt",
            '--query',
            'SecurityGroups[].{GroupId:GroupId,GroupName:GroupName,Description:Description,VpcId:VpcId}'
        )
    )

    foreach ($group in @($sharedSecurityGroups | Sort-Object GroupName, VpcId)) {
        $sharedResourceRows += ,@('Shared Security Group', "$($group.GroupName) ($($group.GroupId))", "$($group.Description) | VPC: $($group.VpcId)")
    }

    $sharedIamPolicyArn = "arn:aws:iam::$($identity.Account):policy/EMISSecretsInstanceRolePolicy-wales"
    try {
        $sharedPolicy = Invoke-AwsJson @(
            'iam', 'get-policy',
            '--policy-arn', $sharedIamPolicyArn,
            '--query', 'Policy.{Arn:Arn,DefaultVersionId:DefaultVersionId,Description:Description,AttachmentCount:AttachmentCount}'
        )
        if ($sharedPolicy) {
            $sharedResourceRows += ,@('Shared IAM Policy', $sharedPolicy.Arn, "Version: $($sharedPolicy.DefaultVersionId) | Attachments: $($sharedPolicy.AttachmentCount)")
        }
    } catch {
        $sharedResourceRows += ,@('Shared IAM Policy', $sharedIamPolicyArn, 'Unable to query live policy metadata')
    }

    try {
        $sharedSsm = @(
            Invoke-AwsJson @(
                'ssm', 'get-parameters',
                '--names', '/tf/output/NAME_PREFIX', '/tf/output/DB_NETMASK',
                '--with-decryption',
                '--query', 'Parameters[].{Name:Name,Value:Value}'
            )
        )
        foreach ($item in $sharedSsm) {
            $sharedResourceRows += ,@('Shared SSM Output', $item.Name, $item.Value)
        }
    } catch {
        $sharedResourceRows += ,@('Shared SSM Output', '/tf/output/NAME_PREFIX, /tf/output/DB_NETMASK', 'Unable to query live values')
    }

    if ($deploySpineAlb) {
        try {
            $spineAlb = Invoke-AwsJson @(
                'elbv2', 'describe-load-balancers',
                '--names', 'wales-spine-alb',
                '--query', 'LoadBalancers[0].{Name:LoadBalancerName,DNSName:DNSName,Type:Type,VpcId:VpcId,AvailabilityZones:AvailabilityZones[*].SubnetId}'
            )
            if ($spineAlb) {
                $sharedResourceRows += ,@('Shared Spine ALB', $spineAlb.Name, "DNS: $($spineAlb.DNSName) | Type: $($spineAlb.Type) | VPC: $($spineAlb.VpcId)")
                $sharedResourceRows += ,@('Shared Spine ALB Subnets', ($spineAlb.AvailabilityZones -join ', '), 'Managed by GP01 owner stack')
            }
        } catch {
            $sharedResourceRows += ,@('Shared Spine ALB', 'wales-spine-alb', 'Unable to query live ALB metadata')
        }

        $trustStoreBucketName = ("prd-ew-plat-s3-wales-spine-truststore-$($identity.Account)").ToLowerInvariant()
        $sharedResourceRows += ,@('Shared Spine Trust Store', $trustStoreBucketName, "Bundle: $((Get-HclLiteralValue -Content $envConfig -Name 'spine_trust_store_bundle_file'))")
        $sharedResourceRows += ,@('Shared Spine Certificate', $spineAlbCertificateArn, 'Primary ACM certificate for the Spine ALB listener')
        $sharedResourceRows += ,@('Shared Spine NLB', 'wales-spine-nlb', (($loadBalancerDetails | Where-Object Name -eq 'wales-spine-nlb' | Select-Object -First 1).DNSName))
    }

    $sharedHostHeaderItems = @($spineAlbPdNumbers | ForEach-Object { "awswa$($_.ToLower()).spine.emis.thirdparty.nhs.uk" })
}

$nlbIpRows = @(
    @('Main NLB 2a', $parameterMap["$parameterPath/nlb_main_ip_2a"]),
    @('Main NLB 2b', $parameterMap["$parameterPath/nlb_main_ip_2b"]),
    @('Spine NLB 2a', $parameterMap["$parameterPath/nlb_spine_ip_2a"]),
    @('Spine NLB 2b', $parameterMap["$parameterPath/nlb_spine_ip_2b"])
) | Where-Object { $_[1] }

$summaryRows = @(
    @('Deployment', $PdNumber),
    @('SDS Deployment', $sdsDeploymentName),
    @('Environment', 'prd'),
    @('AWS Account', $identity.Account),
    @('Region', $AwsRegion),
    @('Name Prefix', $namePrefix),
    @('App VPC', "$appVpcIdConfigured ($($vpcMap[$appVpcIdConfigured].CidrBlock))"),
    @('DB VPC', "$dbVpcIdConfigured ($($vpcMap[$dbVpcIdConfigured].CidrBlock))"),
    @('Directory Short Name', $directoryShortName),
    @('Schedule', $schedule),
    @('Generated UTC', (Get-Date).ToUniversalTime().ToString('yyyy-MM-dd HH:mm:ss'))
)

$connectivityRows = @(
    @('PSBA Public IP', $psbaAddress),
    @('Spine Endpoint Registration', $spineEndpoint),
    @('SDS Deployment Name', $sdsDeploymentName),
    @('Primary NLB DNS', ($loadBalancerDetails | Where-Object Name -eq "wales-$($PdNumber.ToLower())-nlb" | Select-Object -First 1).DNSName),
    @('Spine NLB DNS', ($loadBalancerDetails | Where-Object Name -eq 'wales-spine-nlb' | Select-Object -First 1).DNSName)
)

$networkRows = @()
foreach ($subnetId in ($subnetIdArray | Sort-Object)) {
    $subnet = $subnetMap[$subnetId]
    if (-not $subnet) { continue }
    $networkRows += ,@(
        $subnet.SubnetId,
        $subnet.Name,
        $subnet.AvailabilityZone,
        $subnet.CidrBlock,
        $subnet.VpcId,
        $vpcMap[$subnet.VpcId].Name
    )
}

$appRows = @(foreach ($instance in $appInstances) {
    $sgText = '<p>' + ((@($instance.SecurityGroups | ForEach-Object {
        if ($securityGroupMap.ContainsKey($_)) {
            "$(ConvertTo-HtmlText $securityGroupMap[$_].GroupName) ($(ConvertTo-HtmlText $_))"
        } else {
            ConvertTo-HtmlText $_
        }
    }) -join '<br/>')) + '</p>'

    ,@(
        $instance.Name,
        $instance.InstanceId,
        $instance.PrivateIp,
        $instance.InstanceType,
        $instance.ImageId,
        $instance.SubnetId,
        $subnetMap[$instance.SubnetId].AvailabilityZone,
        $sgText
    )
})

$dbRows = @(foreach ($instance in $dbInstances) {
    $sgText = '<p>' + ((@($instance.SecurityGroups | ForEach-Object {
        if ($securityGroupMap.ContainsKey($_)) {
            "$(ConvertTo-HtmlText $securityGroupMap[$_].GroupName) ($(ConvertTo-HtmlText $_))"
        } else {
            ConvertTo-HtmlText $_
        }
    }) -join '<br/>')) + '</p>'

    $primaryPath = switch -Regex ($instance.Name) {
        'DBS01$' { "$parameterPath/dbs01_primary_ip"; break }
        'DBS02$' { "$parameterPath/dbs02_primary_ip"; break }
        'RS-01$' { "$parameterPath/rs01_primary_ip"; break }
        default { '' }
    }
    $secondaryPath = switch -Regex ($instance.Name) {
        'DBS01$' { "$parameterPath/dbs01_secondary_ips"; break }
        'DBS02$' { "$parameterPath/dbs02_secondary_ips"; break }
        'RS-01$' { "$parameterPath/rs01_secondary_ips"; break }
        default { '' }
    }

    ,@(
        $instance.Name,
        $instance.InstanceId,
        $instance.PrivateIp,
        $parameterMap[$primaryPath],
        $parameterMap[$secondaryPath],
        $instance.InstanceType,
        $instance.ImageId,
        $instance.SubnetId,
        $subnetMap[$instance.SubnetId].AvailabilityZone,
        $sgText
    )
})

$lbRows = @(foreach ($lb in $loadBalancerDetails) {
    $azText = '<p>' + ((@($lb.AvailabilityZones | ForEach-Object {
        $zoneName = if ($_.PSObject.Properties.Name -contains 'Zone') { $_.Zone } elseif ($_.PSObject.Properties.Name -contains 'ZoneName') { $_.ZoneName } else { '' }
        $subnetId = if ($_.PSObject.Properties.Name -contains 'SubnetId') { $_.SubnetId } else { '' }
        $ipLookup = switch ($lb.Name) {
            "wales-$($PdNumber.ToLower())-nlb" {
                if ($zoneName -eq 'eu-west-2a') { $parameterMap["$parameterPath/nlb_main_ip_2a"] } else { $parameterMap["$parameterPath/nlb_main_ip_2b"] }
            }
            'wales-spine-nlb' {
                if ($zoneName -eq 'eu-west-2a') { $parameterMap["$parameterPath/nlb_spine_ip_2a"] } else { $parameterMap["$parameterPath/nlb_spine_ip_2b"] }
            }
            default { '' }
        }
        "$(ConvertTo-HtmlText $zoneName): $(ConvertTo-HtmlText $subnetId)$([string]::IsNullOrWhiteSpace($ipLookup) ? '' : " ($(ConvertTo-HtmlText $ipLookup))")"
    }) -join '<br/>')) + '</p>'

    $tgText = '<p>' + ((@($lb.TargetGroups | ForEach-Object {
        $nodeText = @($_.Nodes | ForEach-Object { "$(ConvertTo-HtmlText $_.Name)" }) -join ', '
        "$(ConvertTo-HtmlText $_.Name) ($(ConvertTo-HtmlText $_.Protocol)/$(ConvertTo-HtmlText $_.Port)) - $nodeText"
    }) -join '<br/>')) + '</p>'

    ,@(
        $lb.Name,
        $lb.DNSName,
        $lb.Type,
        $lb.VpcId,
        $azText,
        $tgText
    )
})

$parameterRows = @(foreach ($parameter in $parameters) {
    ,@($parameter.Name, $parameter.Value)
})

$configRows = @(
    @('Expected App Instance Type', $appInstanceTypeExpected),
    @('Expected DB Instance Type', $dbInstanceTypeExpected),
    @('Configured App AMI', $appAmiId),
    @('Configured DB AMI', $dbAmiId),
    @('Managed AD KMS Key', $managedAdKeyArn),
    @('PD Builder Secret', $pdBuilderSecretArn),
    @('Spine ALB Certificate', $spineAlbCertificateArn),
    @('PSBA Source File', $PsbaAddressFile),
    @('Spine Source File', $SpineEndpointFile)
)

$title = "$PdNumber Production Support Handover"
$bodyParts = New-Object System.Collections.Generic.List[string]
$bodyParts.Add("<h1>$(ConvertTo-HtmlText $title)</h1>")
$bodyParts.Add('<ac:structured-macro ac:name="info"><ac:rich-text-body><p>This page is generated from live AWS metadata, production Terragrunt configuration, and the workspace handover source files. Re-run the script before handover or after any deployment change.</p></ac:rich-text-body></ac:structured-macro>')
$bodyParts.Add('<h2>Executive Summary</h2>')
$bodyParts.Add((ConvertTo-HtmlTable -Headers @('Field', 'Value') -Rows $summaryRows))
$bodyParts.Add('<h2>Connectivity and External Integration</h2>')
$bodyParts.Add((ConvertTo-HtmlTable -Headers @('Item', 'Value') -Rows $connectivityRows))
if ($nlbIpRows.Count -gt 0) {
    $bodyParts.Add('<h3>NLB Private IP Allocations</h3>')
    $bodyParts.Add((ConvertTo-HtmlTable -Headers @('Endpoint', 'Private IP') -Rows $nlbIpRows))
}
$bodyParts.Add('<h2>Network Topology</h2>')
$bodyParts.Add((ConvertTo-HtmlTable -Headers @('Subnet ID', 'Name', 'AZ', 'CIDR', 'VPC ID', 'VPC Name') -Rows $networkRows))
$bodyParts.Add('<h2>Application Tier</h2>')
$bodyParts.Add((ConvertTo-HtmlTable -Headers @('Server', 'Instance ID', 'Private IP', 'Type', 'AMI', 'Subnet', 'AZ', 'Security Groups') -Rows $appRows))
$bodyParts.Add('<h2>Database and RS Tier</h2>')
$bodyParts.Add((ConvertTo-HtmlTable -Headers @('Server', 'Instance ID', 'Primary ENI IP', 'Configured Primary IP', 'Configured Secondary IPs', 'Type', 'AMI', 'Subnet', 'AZ', 'Security Groups') -Rows $dbRows))
$bodyParts.Add('<h2>Load Balancers and Target Groups</h2>')
$bodyParts.Add((ConvertTo-HtmlTable -Headers @('Name', 'DNS', 'Type', 'VPC', 'AZ Mapping', 'Target Groups') -Rows $lbRows))
$bodyParts.Add('<h2>Parameter Store Allocations</h2>')
$bodyParts.Add((ConvertTo-HtmlTable -Headers @('Parameter', 'Value') -Rows $parameterRows))
if ($isSharedOwner -and $sharedResourceRows.Count -gt 0) {
    $bodyParts.Add('<h2>Shared Resources Owned by GP01</h2>')
    $bodyParts.Add((ConvertTo-HtmlTable -Headers @('Resource Type', 'Resource', 'Details') -Rows $sharedResourceRows))
    if ($sharedHostHeaderItems.Count -gt 0) {
        $bodyParts.Add('<h3>Spine Host Headers Managed by GP01</h3>')
        $bodyParts.Add((ConvertTo-HtmlList -Items $sharedHostHeaderItems))
    }
}
$bodyParts.Add('<h2>Deployment Configuration</h2>')
$bodyParts.Add((ConvertTo-HtmlTable -Headers @('Setting', 'Value') -Rows $configRows))
$supportNotes = New-Object System.Collections.Generic.List[string]
if ($isSharedOwner) {
    $supportNotes.Add('GP01 is the PRD shared-resource owner stack in this repository and owns Spine ALB configuration.')
}
$supportNotes.Add("SDS deployment naming pattern: $sdsDeploymentName")
$supportNotes.Add("SSM parameter path: $parameterPath")
$supportNotes.Add('PSBA address source is maintained externally and mapped by GP order.')
$supportNotes.Add('Spine endpoint registration is sourced from the workspace DNS/certificate list file.')
$bodyParts.Add('<h2>Support Notes</h2>')
$bodyParts.Add((ConvertTo-HtmlList -Items $supportNotes))

$body = $bodyParts -join "`n"

$null = New-Item -ItemType Directory -Path $OutputDirectory -Force
$slug = $PdNumber.ToLower()
$htmlPath = Join-Path $OutputDirectory "$slug-production-handover.html"
$jsonPath = Join-Path $OutputDirectory "$slug-production-handover.json"

$payload = [pscustomobject]@{
    Title = $title
    PdNumber = $PdNumber
    SdsDeploymentName = $sdsDeploymentName
    PsbaAddress = $psbaAddress
    SpineEndpoint = $spineEndpoint
    Metadata = [pscustomobject]@{
        AwsIdentity = $identity
        AppInstances = $appInstances
        DbInstances = $dbInstances
        LoadBalancers = $loadBalancerDetails
        Parameters = $parameters
        Subnets = @($subnetMap.Values | Sort-Object SubnetId)
        Vpcs = @($vpcMap.Values | Sort-Object VpcId)
    }
}

Set-Content -LiteralPath $htmlPath -Value $body -Encoding UTF8
$payload | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $jsonPath -Encoding UTF8

Write-Host "Saved HTML handover output to $htmlPath" -ForegroundColor Green
Write-Host "Saved raw metadata to $jsonPath" -ForegroundColor Green

if ($PublishToConfluence) {
    $parentPage = Get-ConfluencePage -PageId $ParentPageId
    $spaceId = $parentPage.spaceId
    $existingChild = Find-ConfluenceChildPage -SpaceId $spaceId -Title $title -ExpectedParentId $ParentPageId
    $publishedPageId = ''

    if ($existingChild) {
        $updated = Update-ConfluencePage -PageId $existingChild.id -Title $title -Version ([int]$existingChild.version.number + 1) -SpaceId $spaceId -ParentId $ParentPageId -Body $body
        $publishedPageId = [string]$updated.id
        Write-Host "Updated existing Confluence page $($updated.id): $($updated.title)" -ForegroundColor Green
    } else {
        $created = New-ConfluencePage -SpaceId $spaceId -Title $title -ParentId $ParentPageId -Body $body
        $publishedPageId = [string]$created.id
        Write-Host "Created Confluence page $($created.id): $($created.title)" -ForegroundColor Green
    }

    if (-not [string]::IsNullOrWhiteSpace($publishedPageId)) {
        Set-ConfluencePageWide -PageId $publishedPageId
        Write-Host "Set Confluence page appearance to full-width for page $publishedPageId" -ForegroundColor Green
    }
} elseif (-not $DryRun) {
    Write-Warning 'Confluence publishing was not requested. Use -PublishToConfluence with credentials to create or update the child page.'
}