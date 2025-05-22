<#
.SYNOPSIS
    This PowerShell script sets the minimum password length to 14 characters, in accordance with STIG requirement WN10-AC-000035.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-23
    Last Modified   : 2025-04-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 2025-04-25
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enforce the minimum password length policy.
    Example syntax:
    PS C:\> .\Set-MinPasswordLength.ps1
#>

# Set "Minimum password length" to 14 characters

$seceditFile = "$env:TEMP\secpol.inf"
$logFile     = "$env:TEMP\secpol.log"

Write-Output "Exporting current security policy..."
secedit /export /cfg $seceditFile /log $logFile

Write-Output "Modifying 'Minimum password length' value..."
(Get-Content $seceditFile).ForEach{
    $_ -replace '^MinimumPasswordLength\s*=.*', 'MinimumPasswordLength = 14'
} | Set-Content $seceditFile

Write-Output "Applying updated security policy..."
secedit /configure /db secedit.sdb /cfg $seceditFile /log $logFile /quiet

# Clean up
Remove-Item $seceditFile -Force
Remove-Item $logFile -Force

Write-Output "'Minimum password length' successfully set to 14 characters."
