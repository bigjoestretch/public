<#  
.NOTES  
    Name: Detect-WUPaths.ps1  
    Author: Joel Cottrell  
    Requires: PowerShell v2 
    Version History:  
    1.0 - 24/09/06 - Initial release of this script.  
.SYNOPSIS  
    A custom Intune proactive remediation detection script to detect if any WindowsUpdate values
    in the registry.
.DESCRIPTION  
    This proactive remediation script checks the windows registry to detect any values set in both
    the normal WindowsUpdate policy key, and in both cache sets.

    Inspiration in creating this was provide y steps found in this link:
    
    https://conditionalaccess.uk/my-windows-autopatch-experience/
    https://github.com/Lewis-Barry/Scripts/tree/main/WindowsUpdate

#> 

$paths = @(
    "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet001\WindowsUpdate",
    "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet002\WindowsUpdate",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
)

$anyPathExists = $false

foreach ($path in $paths) {
    if (Test-Path $path) {
        $anyPathExists = $true
        break
    }
}

if ($anyPathExists) {
    Write-Host "Registry keys do exist"
    EXIT 1
} else {
    Write-Host "Registry keys do not Exist"
    EXIT 0
}
