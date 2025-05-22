<#
.SYNOPSIS
    This PowerShell script sets the minimum password age to 1 day, in accordance with STIG requirement WN10-AC-000030.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-22
    Last Modified   : 2025-04-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000030

.TESTED ON
    Date(s) Tested  : 2025-04-22
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enforce the minimum password age policy.
    Example syntax:
    PS C:\> .\Set-MinPasswordAge.ps1
#>

# Set "Minimum password age" to 1 day

$seceditFile = "$env:TEMP\secpol.inf"
$logFile     = "$env:TEMP\secpol.log"

Write-Output "Exporting current security policy..."
secedit /export /cfg $seceditFile /log $logFile

Write-Output "Modifying 'Minimum password age' value..."
(Get-Content $seceditFile).ForEach{
    $_ -replace '^MinimumPasswordAge\s*=.*', 'MinimumPasswordAge = 1'
} | Set-Content $seceditFile

Write-Output "Applying updated security policy..."
secedit /configure /db secedit.sdb /cfg $seceditFile /log $logFile /quiet

# Clean up
Remove-Item $seceditFile -Force
Remove-Item $logFile -Force

Write-Output "'Minimum password age' successfully set to 1 day."
