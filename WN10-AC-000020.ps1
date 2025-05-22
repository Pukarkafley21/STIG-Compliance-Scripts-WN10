<#
.SYNOPSIS
    This PowerShell script configures the "Enforce password history" policy to remember 24 passwords, in accordance with STIG requirement WN10-AC-000020.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 2025-04-23
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enforce the password history policy.
    Example syntax:
    PS C:\> .\Set-PasswordHistoryPolicy.ps1
#>

# Set "Enforce password history" to 24 passwords remembered

$seceditFile = "$env:TEMP\secpol.inf"
$logFile     = "$env:TEMP\secpol.log"

Write-Output "Exporting current security policy..."
secedit /export /cfg $seceditFile /log $logFile

Write-Output "Modifying 'Enforce password history' value..."
(Get-Content $seceditFile).ForEach{
    $_ -replace '^PasswordHistorySize\s*=.*', 'PasswordHistorySize = 24'
} | Set-Content $seceditFile

Write-Output "Applying updated security policy..."
secedit /configure /db secedit.sdb /cfg $seceditFile /log $logFile /quiet

# Clean up
Remove-Item $seceditFile -Force
Remove-Item $logFile -Force

Write-Output "'Enforce password history' successfully set to 24 passwords remembered."
