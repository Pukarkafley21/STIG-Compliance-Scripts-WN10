<#
.SYNOPSIS
    This PowerShell script configures the system to ignore NetBIOS name release requests except from WINS servers, in accordance with STIG requirement WN10-CC-000035.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-05-02
    Last Modified   : 2025-05-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000035

.TESTED ON
    Date(s) Tested  : 2025-05-02
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enforce NetBIOS name release protection.
    Example syntax:
    PS C:\> .\Enable-NetBIOSNameReleaseProtection.ps1
#>

# Configure the system to ignore NetBIOS name release requests except from WINS servers

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters"
$regName = "NoNameReleaseOnDemand"

Write-Output "Configuring system to ignore NetBIOS name release requests except from WINS servers..."

# Create key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set registry value to 1 (Enabled)
Set-ItemProperty -Path $regPath -Name $regName -Value 1 -Type DWord

# Confirm the setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 1) {
    Write-Output "NetBIOS name release protection successfully enabled (NoNameReleaseOnDemand = 1)."
} else {
    Write-Output "Failed to apply the setting. Current value: $currentValue"
}
