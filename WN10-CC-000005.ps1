<#
.SYNOPSIS
    This PowerShell script disables camera access from the lock screen, in accordance with STIG requirement WN10-CC-000005.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-28
    Last Modified   : 2025-04-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 2025-04-30
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to disable lock screen camera access.
    Example syntax:
    PS C:\> .\Disable-LockScreenCamera.ps1
#>

# Disable camera access from lock screen

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$regName = "NoLockScreenCamera"

Write-Output "Configuring registry to disable camera access from the lock screen..."

# Create the key if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the policy value
Set-ItemProperty -Path $regPath -Name $regName -Value 1 -Type DWord

# Confirm setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 1) {
    Write-Output "Camera access from the lock screen has been successfully disabled."
} else {
    Write-Output "Failed to disable lock screen camera access. Current value: $currentValue"
}
