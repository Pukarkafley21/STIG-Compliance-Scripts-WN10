<#
.SYNOPSIS
    This PowerShell script disables IP source routing for IPv4 by setting DisableIPSourceRouting to 2, in accordance with STIG requirement WN10-CC-000025.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-05-02
    Last Modified   : 2025-05-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000025

.TESTED ON
    Date(s) Tested  : 2025-05-03
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to apply highest IP source routing protection for IPv4.
    Example syntax:
    PS C:\> .\Set-IPv4SourceRoutingProtection.ps1
#>

# Set DisableIPSourceRouting for IPv4 to "2" (highest protection)

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$regName = "DisableIPSourceRouting"

Write-Output "Applying highest protection for IPv4 source routing..."

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set value to 2
Set-ItemProperty -Path $regPath -Name $regName -Value 2 -Type DWord

# Confirm setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 2) {
    Write-Output "IPv4 source routing protection set to highest level (DisableIPSourceRouting = 2)."
} else {
    Write-Output "Failed to apply IPv4 source routing setting. Current value: $currentValue"
}
