<#
.SYNOPSIS
    This PowerShell script remediates STIG WN10-CC-000238 by configuring Windows 10 to prevent users from overriding certificate errors in Microsoft Edge.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-18
    Last Modified   : 2025-04-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000238

.TESTED ON
    Date(s) Tested  : 2025-04-18
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (21H2)
    PowerShell Ver. : 5.1 and 7.2

.USAGE
    Run this script as Administrator to configure the required registry key that prevents certificate error overrides in Microsoft Edge.
    Example:
    PS C:\> .\Set-EdgeCertOverridePolicy.ps1
#>

#Check if the path exists; if not create it

$regPath = "HKLM:\Software\Policies\Microsoft\MicrosoftEdge\Main"
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value to enable the policy
Set-ItemProperty -Path $regPath -Name "PreventCertErrorOverrides" -Value 1 -Type DWord

Write-Output "Policy applied: Prevent certificate error overrides is now enabled."


# type-DWord tells the regristry to treat the value as a number 
# 1 means enabled 

#Then you can run this scirpt as Administrator or un-comment the following:

#For current User:
# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

# For whole machine:
# Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemooteSigned -Force

