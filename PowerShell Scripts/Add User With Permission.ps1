<#

.SYNOPSIS
    Create a PowerShell function to Add PBIRS/SSRS Item Security and call the function to add an user to a specific folder with a specified role
.DESCRIPTION
    The script is used to add an user to a specific folder with specific role
.OUTPUTS
    Complete or error
.EXAMPLE
    To add an user to the root (/) folder with Browser role 
.NOTES
    Author: Luca Gualtieri
    Creation Date: June 4, 2020
    Version: 1.0

#>

function Add-SSRSItemSecurity
(
    [Parameter(Position=0,Mandatory=$true)]
    [Alias("url")]
    [string]$webServiceUrl,
 
    [Parameter(Position=1,Mandatory=$true)]
    [Alias("path")]
    [string]$itemPath,
     
    [Parameter(Position=2,Mandatory=$true)]
    [Alias("u")]
    [string]$groupUserName,
     
    [Parameter(Position=3,Mandatory=$true)]
    [Alias("r")]
    [string]$role,
     
    [Parameter(Position=2)]
    [bool]$inherit=$true
)
 
{
     
    #Fix item path if not starting with /
    if(!$itemPath.StartsWith("/")) { $itemPath = "/" + $itemPath}
     
    #Create Proxy
    Write-Host "[Add-SSRSItemSecurity()] Creating Proxy, connecting to : $webServiceUrl"
    $ssrsProxy = New-WebServiceProxy -Uri $webServiceUrl -UseDefaultCredential
     
    $type = $ssrsProxy.GetType().Namespace;
    $policyType = "{0}.Policy" -f $type;
    $roleType = "{0}.Role" -f $type;
     
    Write-Host "[Add-SSRSItemSecurity()] Retrieving all existing policies."
    $policies = $ssrsProxy.GetPolicies($itemPath, [ref]$inherit);
     
    $a = 1;
    foreach($policy in $policies)
    {
 
        foreach($r in $policy.Roles)
        {
            $msg = "[Add-SSRSItemSecurity()]  Existing Policy # {0} Group Name: {1}, Role: {2}" -f $a, $policy.GroupUserName, $r.Name
            Write-Host $msg
        }
        $a+=1;
    }
 
    $msg = "[Add-SSRSItemSecurity()] Total Existing Policies: " + $policies.Length;
    Write-Host $msg
     
    $Policy = $policies | 
    Where-Object { $_.GroupUserName -eq $groupUserName } | 
    Select-Object -First 1
     
    if (-not $Policy) {
        $Policy = New-Object ($policyType)
        $Policy.GroupUserName = $GroupUserName
        $Policy.Roles = @()
        $Policies += $Policy
        $msg = "[Add-SSRSItemSecurity()] Adding new policy: '{0}'" -f $GroupUserName
        Write-Host $msg
    }
 
    $r = $Policy.Roles |
        Where-Object { $_.Name -eq $role } |
        Select-Object -First 1
    if (-not $r) {
        $r = New-Object ($roleType)
        $r.Name = $role
        $Policy.Roles += $r
        $msg = "[Add-SSRSItemSecurity()] Adding new role: '{0}'" -f $role
        Write-Host $msg
    }
     
    #Set the policies
    $ssrsProxy.SetPolicies($itemPath,$policies);
 
}

### Replace the -url with your PBIRS details, replace the -u (User) with your user details and specifify a -r (Role) for your user
Add-SSRSItemSecurity -url "http://pbilabrs1/Reports_PBIRS/ReportService2010.asmx?WSDL" -itemPath "/" -u "PBILABRS1\pbirs_user2" -r "Browser"