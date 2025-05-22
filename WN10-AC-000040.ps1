<#
.SYNOPSIS
    This PowerShell script enables the built-in Microsoft password complexity filter, in accordance with STIG requirement WN10-AC-000040.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-24
    Last Modified   : 2025-04-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000040

.TESTED ON
    Date(s) Tested  : 2025-04-25
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enforce the password complexity policy.
    Example syntax:
    PS C:\> .\Enable-PasswordComplexity.ps1
#>

# Enable "Password must meet complexity requirements"

$seceditFile = "$env:TEMP\secpol.inf"
$logFile     = "$env:TEMP\secpol.log"

Write-Output "Exporting current security policy..."
secedit /export /cfg $seceditFile /log $logFile

Write-Output "Modifying 'Password must meet complexity requirements'..."
(Get-Content $seceditFile).ForEach{
    $_ -replace '^PasswordComplexity\s*=.*', 'PasswordComplexity = 1'
} | Set-Content $seceditFile

Write-Output "Applying updated security policy..."
secedit /configure /db secedit.sdb /cfg $seceditFile /log $logFile /quiet

# Clean up
Remove-Item $seceditFile -Force
Remove-Item $logFile -Force

Write-Output "'Password complexity requirement' successfully enabled."
