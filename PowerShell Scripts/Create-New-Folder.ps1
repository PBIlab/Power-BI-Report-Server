<#

.SYNOPSIS
    List PBIRS folders and create a new folder with folder description
.DESCRIPTION
    The script is used to list all the folders of your PBIRS and create a new folder on a specific path (if the path exists). 
    Future versions of the code can have parameters where you enter the variables instead of changing them in the code all the time.
.OUTPUTS
    Complete or error
.EXAMPLE
    To create a folder with a folder description.
.NOTES
    Author: Luca Gualtieri
    Creation Date: June 4, 2020
    Version: 1.0

#>

#Installs SSRS module (need to run as admin to do this)
Install-Module -Name ReportingServicesTools;

#Update SSRS module (in case you have the module already installed and you need to update it at the latest version)
#Update-Module -Name ReportingServicesTools;

#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

#Import SSRS module
#Import-Module -Name ReportingServicesTools;

#Create new web session to your Power BI Report portal
#Replace with your report server URL
#Run this with a user member of the Content Managers group

$ReportPortalUri = 'https://pbilabrs1/Reports_PBIRS'; 
$newfolder = 'New Folder'

$proxy = New-RSWebServiceProxy -ReportServerUri $ReportPortalUri

#Get folders from Power BI Report Server
$folders = Get-RsCatalogItems -Proxy $proxy -RsFolder '/' -Recurse | Where {$_.TypeName -eq 'Folder'};

foreach ($folder in $folders)
{

  Write-Host "Folder: $($folder.Name)";
  #Create folder if it does not exist
  if ($folder.Name -eq 'PASS Business Analytics Virtual Group')
  {
    Write-Host "Folder Check: $($folder.Name)";
    $folderPath = '/' + $($folder.Name);
    Write-Host "Folder Path: $($folderPath)";
    New-RsFolder -Proxy $proxy -RsFolder $folderPath -FolderName $newfolder -Description 'Test New Description' 
  }
}