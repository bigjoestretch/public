<#  
.NOTES  
    Name: Detect-Netskope.ps1  
    Author: Joel Cottrell  
    Requires: PowerShell v2 
    Version History:  
    2.0 - 24/09/13 - Initial release of this script.  
.SYNOPSIS  
    A custom Intune compliance detection script to detect if the Netskope client is running or not.
.DESCRIPTION  
    The custom compliance detection script (used in an Intune Compliance configuration)
    checks whether the Netskope application/service is running and outputs a true or 
    false JSON value.

    Inspiration in creating this was provide by steps found in this link:
    
    https://www.nielskok.tech/intune/zscaler-custom-compliance-in-intune/
    https://jannikreinhard.com/2023/02/26/how-to-use-custom-compliance-script-example-script/

#> 

# Function to check if the Netskope Client is running
function Is-NetskopeRunning {
    # Get all running processes
    $processes = Get-Process

    # Check if any process name contains 'netskope'
    foreach ($process in $processes) {
        if ($process.Description -like "*netskope*") {
            return $true
        }
    }
    return $false
}

# Check if Netskope Private Access is running and print the result
#if (Is-NetskopeRunning) {
#    Write-Output "Netskope Private Access is running."
#} else {
#    Write-Output "Netskope Private Access is not running."
#}

# Detection script outputs the JSON value for the Netskope result
$checknetskope = Is-NetskopeRunning
$NetskopeStatus = @{"NetskopeStatus" = $checknetskope}

return $NetskopeStatus | ConvertTo-Json -Compress

# This section below should be saved As a JSON file and added/imported to an Intune Custom Compliance policy):
#{
#    "Rules":[ 
#        { 
#           "SettingName":"$NetskopeStatus",
#           "Operator":"NotEquals",
#           "DataType":"String",
#           "Operand":"false",
#           "MoreInfoUrl":"https://docs.netskope.com/en/netskope-client-troubleshooting-guide/",
#           "RemediationStrings":[ 
#              { 
#                 "Language":"en_US",
#                 "Title":"The Netskope client is not running.",
#                 "Description": "Your device must have the Netskope client running and enabled. Try restarting your device, and then follow the steps here: https://docs.netskope.com/en/netskope-client-troubleshooting-guide/. If you do this and get this message again, contact Corporate IT at itsupport@intelycare.com."
#              }
#           ]
#        }
#     ]
#}
