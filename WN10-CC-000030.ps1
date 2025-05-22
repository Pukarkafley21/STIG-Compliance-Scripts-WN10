<#
.SYNOPSIS
    This PowerShell script disables ICMP redirects from overriding OSPF-generated routes, in accordance with STIG requirement WN10-CC-000030.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-05-02
    Last Modified   : 2025-05-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000030

.TESTED ON
    Date(s) Tested  : 2025-05-04
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to prevent ICMP redirects from overriding OSPF routes.
    Example syntax:
    PS C:\> .\Disable-ICMPRedirectOverride.ps1
#>

# Disable ICMP redirects overriding OSPF routes

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$regName = "EnableICMPRedirects"

Write-Output "Disabling ICMP redirects from overriding OSPF-generated routes..."

# Create registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set registry value to 0 (disabled)
Set-ItemProperty -Path $regPath -Name $regName -Value 0 -Type DWord

# Confirm setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 0) {
    Write-Output "ICMP redirect override of OSPF routes successfully disabled (EnableICMPRedirects = 0)."
} else {
    Write-Output "Failed to apply setting. Current value: $currentValue"
}
