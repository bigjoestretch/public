<#
.NOTES
    Filename: Remediate-Zscaler.ps1
    Version: 3.0
    Author: Joel Cottrell
    Modified by: Joel Cottrell
    Requires: PowerShell v5
    Version History:
    1.0 - 24/09/13 - Initial release of this script.
.SYNOPSIS
    This script package will attempt to remove the Zscaler application on the targeted devices.
    This script is used as detection script with Proactive Remediations in the Microsoft Intune admin center.
.DESCRIPTION
    Uninstall the Zscaler application.
       
#>

# Remediation script

$uninstaller = "$env:ProgramFiles\Zscaler\ZSAInstaller\uninstall.exe"
$password = '"Spy_Tri3$t!!!"'

if (Test-Path $uninstaller) {
    Write-Output "Uninstalling Zscaler..."
    Start-Process -FilePath $uninstaller -ArgumentList "--mode unattended" -NoNewWindow -Wait
    Write-Output "Uninstallation process initiated."
} else {
    Write-Output "Uninstaller not found at $uninstaller."
}
