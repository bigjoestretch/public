# Custom compliance discovery scripts for Microsoft Intune

This repository contains a collection of Microsoft Intune Custom Compliance scripts

Before you can use custom settings for compliance with Microsoft Intune, you must define a script that can discover the custom compliance settings that are available on devices.

The discovery script deploys to devices as part of your custom compliance policies. When compliance runs on a device, the script discovers the settings that are defined by the JSON file that you also provide through custom compliance policy.

## All discovery scripts:

* Are added to Intune before you create a compliance policy. After being added, scripts are available to select when you create a compliance policy with custom settings.
  - Each discovery script can only be used with one compliance policy, and each compliance policy can only include one discovery script.
  - Discovery scripts that are assigned to a compliance policy can't be deleted until the script is unassigned from the policy.

* Run on a device that receives the compliance policy. The script evaluates the conditions of the JSON file you upload when creating a custom compliance policy.

* Identify one or more settings, as defined in the JSON, and return a list of discovered values for those settings. A single script can be assigned to each policy, and supports discovery of multiple settings.
