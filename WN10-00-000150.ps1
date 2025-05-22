<#
.SYNOPSIS
    This PowerShell script enables Structured Exception Handling Overwrite Protection (SEHOP) by configuring the required registry setting, in accordance with STIG requirement WN10-00-000150.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-18
    Last Modified   : 2025-04-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000150

.TESTED ON
    Date(s) Tested  : 2025-04-20
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enable SEHOP.
    Example syntax:
    PS C:\> .\Enable-SEHOP.ps1
#>

# Define registry path and value
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"
$regName = "DisableExceptionChainValidation"

Write-Output "Configuring Structured Exception Handling Overwrite Protection (SEHOP)..."

# Ensure the registry path exists
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value to 0 to enable SEHOP
Set-ItemProperty -Path $regPath -Name $regName -Value 0 -Type DWord

# Verify the change
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
If ($currentValue -eq 0) {
    Write-Output "SEHOP has been successfully enabled. Registry value set to 0."
} else {
    Write-Output "Failed to enable SEHOP. Current registry value: $currentValue"
}
