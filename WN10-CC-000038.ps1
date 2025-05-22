<#
.SYNOPSIS
    This PowerShell script disables WDigest Authentication to prevent plaintext credentials from being stored in memory, in accordance with STIG requirement WN10-CC-000038.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-05-02
    Last Modified   : 2025-05-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000038

.TESTED ON
    Date(s) Tested  : 2025-05-06
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to ensure WDigest is disabled.
    Example syntax:
    PS C:\> .\Disable-WDigestAuthentication.ps1
#>

# Disable WDigest Authentication (UseLogonCredential = 0)

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest"
$regName = "UseLogonCredential"

Write-Output "Disabling WDigest Authentication to prevent plaintext password storage..."

# Create registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the value to 0 (disabled)
Set-ItemProperty -Path $regPath -Name $regName -Value 0 -Type DWord

# Confirm the setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 0) {
    Write-Output "WDigest Authentication successfully disabled (UseLogonCredential = 0)."
} else {
    Write-Output "Failed to disable WDigest. Current value: $currentValue"
}
