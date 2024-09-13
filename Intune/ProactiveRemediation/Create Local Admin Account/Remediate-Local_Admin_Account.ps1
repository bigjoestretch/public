<#
.NOTES
    Filename: Remediate-Local_Admin_Account.ps1
    Version: 1.0
    Author: Joel Cottrell
    Version History:
    1.0 - 23/05/23 - Initial release of this script.
.SYNOPSIS
    This script package will attempt to detect a local administrator account on the targeted devices.
    This script is used as a remediation script with Proactive Remediations in the Microsoft Intune admin center.
.DESCRIPTION
    Manage the local administrator account in Windows, which currently consists of:
    - XXXX-XXXXX
.LINK
    https://cloudinfra.net/create-a-local-admin-using-intune-and-powershell/
        
#>

# Remediation script
# Replace the XXXX-XXXXX with the name of the actual local admin account"
$userName = "XXXX-XXXXX"
$userexist = (Get-LocalUser).Name -Contains $userName
if($userexist -eq $false) {
  try{ 
     New-LocalUser -Name $username -FullName $username -Description "Company's Local Admin user account" -NoPassword | Set-LocalUser -PasswordNeverExpires 1
     Exit 0
   }   
  Catch {
     Write-error $_
     Exit 1
   }
} 
