# Deploying the Datto RMM Agent using Microsoft Intune

## Overview
Microsoft Intune has functionality to deploy and run PowerShell scripts to Managed Windows 10 devices and Bash and Shell scripts to managed macOS devices, provided that they are fully enrolled in Microsoft Intune and not just Azure AD domain-joined. We can leverage this functionality to deploy scripts that will download and install the Datto RMM Agent.

The process consists of three stages:

- Create scripts for each Datto RMM site you wish to deploy Agents to.
- For each site, create a Device Group within the Microsoft Intune portal containing that customer’s Windows or macOS devices.
- Upload the correct script for that customer’s Datto RMM site for the respective OS and associate it with the Device Group you created for them.
