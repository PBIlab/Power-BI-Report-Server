<#

.SYNOPSIS
    Update folder permissions
.DESCRIPTION
    The script is used to update folder permission on a PBIRS.
    Future versions of the code can have parameters where you enter the variables instead of changing them in the code all the time.
.OUTPUTS
    Complete or error
.EXAMPLE
    To update folder security change the folder names to search for, the group to modify and the role to add to the group. Can also
    change biSite server address.
    Update-PowerBiSecurity
.NOTES
    Author: Luca Gualtieri
    Creation Date: June 4, 2020
    Version: 1.0

#>

$folders = 'Demo', 'Monitoring'
$groupToMod = 'PBILABRS1\pbirs_user4'
$roleToAdd = @{Name="Browse Reports";Description="View Reports ONLY."}
$newRole = New-Object PSObject –Property $roleToAdd

$biSite = "pbilabrs1"

try{
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

	$creds = Get-Credential
	$restapiurl = "https://$biSite/Reports_PBIRS/api/v2.0/folders"
	$result = Invoke-RestMethod -uri $restapiurl -Credential $creds -Method GET -ContentType "application/json"

	$change = $false

	# Iterate through each folder
	foreach($folder in $result.value){
 		if($folders -contains $folder.name){
			# Get the policy for the folder
			$restapiurl = "https://$biSite/Reports_PBIRS/api/v2.0/folders($($folder.Id))/Policies"
			$policy = Invoke-RestMethod -uri $restapiurl -Credential $creds -Method GET -ContentType "application/json"

			# Iterate through each group in the policy 
			foreach($group in $policy.policies) {
				if($group.GroupUserName -eq $groupToMod) {
					# Add new Role to the Group Policy
					$group.roles += $newRole
					$change = $true
				}
			}
			if($change){
				# Clean up parts that are not needed for the put request
				$policy.PSObject.Properties.Remove('Id')
				$policy.PSObject.Properties.Remove('@odata.context')

				# Convert the data back to JSON format
				$json = convertto-json $policy -Depth 100
				$response = Invoke-RestMethod -uri $restapiurl -Credential $creds -Method PUT -Body $json -ContentType "application/json" -verbose
				$change = $false
			}
		}
	}
	write-output "Changes Made"
} catch {
        ($_)
}