<#
.SYNOPSIS
    This PowerShell script disables the display of slide shows on the lock screen, in accordance with STIG requirement WN10-CC-000010.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-30
    Last Modified   : 2025-05-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 2025-05-02
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to disable lock screen slide shows.
    Example syntax:
    PS C:\> .\Disable-LockScreenSlideshow.ps1
#>

# Disable lock screen slideshow via Group Policy registry key

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$regName = "NoLockScreenSlideshow"

Write-Output "Configuring registry to prevent lock screen slide show..."

# Create key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set policy to prevent lock screen slideshow
Set-ItemProperty -Path $regPath -Name $regName -Value 1 -Type DWord

# Confirm setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq 1) {
    Write-Output "Lock screen slide show has been successfully disabled."
} else {
    Write-Output "Failed to disable lock screen slide show. Current value: $currentValue"
}
