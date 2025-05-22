<#
.SYNOPSIS
    This PowerShell script disables system-wide camera access by setting the webcam consent policy to "Deny", in accordance with STIG requirement WN10-CC-000007.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-29
    Last Modified   : 2025-04-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000007

.TESTED ON
    Date(s) Tested  : 2025-04-29
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to disable system-wide camera access.
    Example syntax:
    PS C:\> .\Disable-CameraAccess.ps1
#>

# Deny webcam access via CapabilityAccessManager consent store

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam"
$regName = "Value"

Write-Output "Configuring registry to deny system-wide access to the webcam..."

# Create registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set 'Value' to 'Deny'
Set-ItemProperty -Path $regPath -Name $regName -Value "Deny" -Type String

# Confirm setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq "Deny") {
    Write-Output "Webcam access has been successfully denied at the system level."
} else {
    Write-Output "Failed to apply camera access policy. Current value: $currentValue"
}
