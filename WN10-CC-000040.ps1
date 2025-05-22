<#
.SYNOPSIS
    This PowerShell script disables insecure guest logons to the SMB server, in accordance with STIG requirement WN10-CC-000040.

.STIG SUMMARY
    STIG ID       : WN10-CC-000040
    Rule ID       : SV-220802r991589_rule
    Vuln ID       : V-220802
    Severity      : CAT II
    Description   : Prevents unauthenticated access to SMB shares by disabling insecure guest logons.
    Fix Text      : Set 'AllowInsecureGuestAuth' to 0 under the LanmanWorkstation policy key.
    Affected Path : HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation
    Value Name    : AllowInsecureGuestAuth
    Value Type    : REG_DWORD
    Value Data    : 0
    Reference     : https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_MS_Windows_10_V3R2_STIG.zip

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-05-02
    Last Modified   : 2025-05-08
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to disable insecure SMB guest logons.
    Example:
    PS C:\> .\Disable-InsecureGuestLogons.ps1
#>

# Disable insecure guest SMB logons

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation"
$regName = "AllowInsecureGuestAuth"

Write-Output "Disabling insecure SMB guest logons..."

# Create registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value to 0 (Disabled)
Set-ItemProperty -Path $regPath -Name $regName -Value 0 -Type DWord

# Confirm result
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 0) {
    Write-Output "Insecure guest logons successfully disabled (AllowInsecureGuestAuth = 0)."
} else {
    Write-Output "Failed to apply setting. Current value: $currentValue"
}
