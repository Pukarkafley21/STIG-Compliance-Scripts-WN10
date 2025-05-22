<#
.SYNOPSIS
    This PowerShell script configures the "Reset account lockout counter after" policy to 15 minutes, in accordance with STIG requirement WN10-AC-000015.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-20
    Last Modified   : 2025-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000015

.TESTED ON
    Date(s) Tested  : 2025-04-21
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to configure the account lockout counter reset policy.
    Example syntax:
    PS C:\> .\Set-AccountLockoutResetCounter.ps1
#>

# Configure "Reset account lockout counter after" to 15 minutes

$seceditFile = "$env:TEMP\secpol.inf"
$logFile     = "$env:TEMP\secpol.log"

Write-Output "Exporting current security policy..."
secedit /export /cfg $seceditFile /log $logFile

Write-Output "Modifying 'Reset account lockout counter after' value..."
(Get-Content $seceditFile).ForEach{
    $_ -replace '^ResetLockoutCount\s*=.*', 'ResetLockoutCount = 15'
} | Set-Content $seceditFile

Write-Output "Applying updated security policy..."
secedit /configure /db secedit.sdb /cfg $seceditFile /log $logFile /quiet

# Clean up
Remove-Item $seceditFile -Force
Remove-Item $logFile -Force

Write-Output "'Reset account lockout counter after' successfully set to 15 minutes."
