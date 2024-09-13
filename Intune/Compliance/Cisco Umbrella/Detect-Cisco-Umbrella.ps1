<#  
.NOTES  
    Name: Detect-Cisco-Umbrella.ps1  
    Author: Joel Cottrell  
    Requires: PowerShell v2 
    Version History:  
    1.0 - 24/09/13 - Initial release of this script.  
.SYNOPSIS  
    A custom Intune compliance detection script to detect if the Cisco Umbrella client is running or not.
.DESCRIPTION  
    The custom compliance detection script (used in an intune Compliance configuration)
    checks whether the Cisco Umbrella client/service is running and outputs a true or 
    false JSON value.

    Inspiration in creating this was provide y steps found in this link:
    
    https://www.nielskok.tech/intune/zscaler-custom-compliance-in-intune/
    https://jannikreinhard.com/2023/02/26/how-to-use-custom-compliance-script-example-script/

#> 

# Function to check if the Cisco Umbrella Client is running
function Is-CiscoUmbrellaRunning {
    # Get all running processes
    $processes = Get-Process

    # Check if any process name contains 'Cisco Umbrella'
    foreach ($process in $processes) {
        if ($process.Description -like "*Cisco Umbrella*") {
            return $true
        }
    }
    return $false
}

# Check if Cisco Umbrella is running and print the result
#if (Is-CiscoUmbrellaRunning) {
#    Write-Output "Cisco Umbrella is running."
#} else {
#    Write-Output "Cisco Umbrella is not running."
#}

# Detection script outputs the JSON value for the Cisco Umbrella result
$checkciscoumbrella = Is-CiscoUmbrellaRunning
$CiscoUmbrellaStatus = @{"CiscoUmbellaStatus" = $checkciscoumbrella}

return $CiscoUmbrellaStatus | ConvertTo-Json -Compress

# This section below should be saved As a JSON file and added/imported to an Intune Custom Compliance policy):
#{
#    "Rules":[ 
#        { 
#           "SettingName":"CiscoUmbrellaStatus",
#           "Operator":"NotEquals",
#           "DataType":"String",
#           "Operand":"false",
#           "MoreInfoUrl":"https://docs.umbrella.com/deployment-umbrella/docs/appx-c-troubleshooting",
#           "RemediationStrings":[ 
#              { 
#                 "Language":"en_US",
#                 "Title":"Cisco Umbrella must be running.",
#                 "Description": "Please make sure that the Cisco Umbrella client is running on your machine."
#              }
#           ]
#        }
#     ]
#}
