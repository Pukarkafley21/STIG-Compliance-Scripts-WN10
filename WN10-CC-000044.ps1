<#
.SYNOPSIS
    This PowerShell script disables Internet Connection Sharing on DNS domain networks, in accordance with STIG requirement WN10-CC-000044.

.STIG SUMMARY
    STIG ID       : WN10-CC-000044
    Rule ID       : SV-220803r958478_rule
    Vuln ID       : V-220803
    Severity      : CAT II
    Description   : Prevents a system from acting as a mobile hotspot or network bridge by enforcing ICS restrictions.
    Fix Text      : Set 'NC_ShowSharedAccessUI' to 0 under the Network Connections policy registry path.
    Registry Path : HKLM\SOFTWARE\Policies\Microsoft\Windows\Network Connections
    Value Name    : NC_ShowSharedAccessUI
    Value Type    : REG_DWORD
    Value Data    : 0
    Reference     : https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_MS_Windows_10_V3R2_STIG.zip

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 25-05-07
    Last Modified   : 25-05-09
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to disable Internet Connection Sharing.
    Example:
    PS C:\> .\Disable-InternetConnectionSharing.ps1
#>

# Disable Internet Connection Sharing

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
$regName = "NC_ShowSharedAccessUI"

Write-Output "Disabling Internet Connection Sharing on DNS domain networks..."

# Create registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set registry value to 0 (Disabled)
Set-ItemProperty -Path $regPath -Name $regName -Value 0 -Type DWord

# Confirm application
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 0) {
    Write-Output "Internet Connection Sharing successfully disabled (NC_ShowSharedAccessUI = 0)."
} else {
    Write-Output "Failed to disable ICS. Current value: $currentValue"
}
