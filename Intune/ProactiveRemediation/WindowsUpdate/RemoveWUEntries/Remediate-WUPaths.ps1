<#  
.NOTES  
    Name: Remediate-WUPaths.ps1  
    Author: Joel Cottrell  
    Requires: PowerShell v2 
    Version History:  
    1.0 - 24/09/06 - Initial release of this script.  
.SYNOPSIS  
    A custom Intune proactive remediation detection script to removes any WindowsUpdate values
    in the registry.
.DESCRIPTION  
    This proactive remediation script removes any values set in both the normal WindowsUpdate
    policy key, and in both cache sets. This allows for Windows Autopatch (or to remove old entries
    set by an RMM tool).

    Inspiration in creating this was provide y steps found in this link:
    
    https://conditionalaccess.uk/my-windows-autopatch-experience/
    https://github.com/Lewis-Barry/Scripts/tree/main/WindowsUpdate

#> 

# Define the registry paths
$registryPathWindowsUpdate = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$registryPathCacheSet001 = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet001\WindowsUpdate"
$registryPathCacheSet002 = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet002\WindowsUpdate"

# Function to remove registry keys if they exist
function Remove-RegistryPath($path) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force
        Write-Output "Contents of $path have been deleted successfully."
    } else {
        Write-Output "$path does not exist."
    }
}

# Remove all subkeys and contents at the specified paths
Remove-RegistryPath $registryPathWindowsUpdate
Remove-RegistryPath $registryPathCacheSet001
Remove-RegistryPath $registryPathCacheSet002

# Restart the Windows Update service
Restart-Service -Name "wuauserv" -Force
