<#
.SYNOPSIS
    This PowerShell script applies UAC token filtering to local administrator accounts on network logons, in accordance with STIG requirement WN10-CC-000037.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-20
    Last Modified   : 2025-04-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000037

.TESTED ON
    Date(s) Tested  : 2025-04-23
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2) (domain-joined)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enable UAC token filtering on local accounts.
    Example syntax:
    PS C:\> .\Enable-LocalAccountUACFiltering.ps1
#>

# Enforce UAC restrictions for local admin accounts on network logons

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "LocalAccountTokenFilterPolicy"

Write-Output "Applying UAC token filtering for local administrator accounts on network logons..."

# Ensure registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the policy value to 0 (Enabled / Compliant)
Set-ItemProperty -Path $regPath -Name $regName -Value 0 -Type DWord

# Confirm result
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 0) {
    Write-Output "UAC token filtering successfully applied (LocalAccountTokenFilterPolicy = 0)."
} else {
    Write-Output "Failed to apply setting. Current value: $currentValue"
}
