<#  
.NOTES  
    Name: Detect-Zscaler.ps1  
    Author: Joel Cottrell  
    Requires: PowerShell v2 
    Version History:  
    1.0 - 24/09/13 - Initial release of this script.  
.SYNOPSIS  
    A custom Intune compliance detection script to detect if Zscaler is running or not.
.DESCRIPTION  
    The custom compliance detection script (used in an intune Compliance configuration)
    checks whether the Zscaler client/service is running and outputs a true or 
    false JSON value.

    Inspiration in creating this was provide y steps found in this link:
    
    https://www.nielskok.tech/intune/zscaler-custom-compliance-in-intune/
    https://jannikreinhard.com/2023/02/26/how-to-use-custom-compliance-script-example-script/

#> 

# Connect to the Zscaler Cloud Security Website
$url = Invoke-WebRequest http://ip.zscaler.com/

# Check the Zscaler Cloud Security Website to see if the client is connecting via a Zscaler proxy or not
$checkzscaler = ($URL.ParsedHtml.getElementsByTagName('div') | Where-Object{ $_.className -eq 'headline' }).innertext

# Detection script outputs the JSON value for the Cisco Umbrella result
$ZScalerStatus = @{"ZScalerStatus" = $checkzscaler}
return $ZScalerStatus | ConvertTo-Json -Compress

# This section below should be saved As a JSON file and added/imported to an Intune Custom Compliance policy):
#{
#    "Rules":[ 
#        { 
#           "SettingName":"ZScalerStatus",
#           "Operator":"NotEquals",
#           "DataType":"String",
#           "Operand":"The request received from you didn't come from a Zscaler IP therefore you are not going through the Zscaler proxy service.",
#           "MoreInfoUrl":"https://help.zscaler.com/client-connector/using-zscaler-client-connector",
#           "RemediationStrings":[ 
#              { 
#                 "Language":"en_US",
#                 "Title":"ZScaler Internet Access must be running.",
#                 "Description": "Please make sure that the ZScaler Internet Access is running."
#              }
#           ]
#        }
#     ]
#}