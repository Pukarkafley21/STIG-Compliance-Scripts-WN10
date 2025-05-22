<#
.SYNOPSIS
    This PowerShell script configures the IPv6 source routing protection level to "Highest protection" by setting DisableIPSourceRouting to 2, in accordance with STIG requirement WN10-CC-000020.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-05-12
    Last Modified   : 2025-05-14
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000020

.TESTED ON
    Date(s) Tested  : 2025-05-14
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to apply the highest IPv6 source routing protection.
    Example syntax:
    PS C:\> .\Set-IPv6SourceRoutingProtection.ps1
#>

# Set DisableIPSourceRouting for IPv6 to "2" (highest protection)

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$regName = "DisableIPSourceRouting"

Write-Output "Applying highest protection for IPv6 source routing..."

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set value to 2
Set-ItemProperty -Path $regPath -Name $regName -Value 2 -Type DWord

# Confirm setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 2) {
    Write-Output "IPv6 source routing protection set to highest level (DisableIPSourceRouting = 2)."
} else {
    Write-Output "Failed to apply IPv6 source routing setting. Current value: $currentValue"
}
