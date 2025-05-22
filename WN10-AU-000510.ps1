<#
.SYNOPSIS
    This PowerShell script configures the System event log maximum size to 32768 KB, in accordance with STIG requirement WN10-AU-000510.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-24
    Last Modified   : 2025-04-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000510

.TESTED ON
    Date(s) Tested  : 2025-04-27
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enforce the System event log size policy.
    Example syntax:
    PS C:\> .\Set-SystemLogMaxSize.ps1
#>

# Set system event log maximum size to 32768 KB (32 MB)

$logName = "System"
$maxSizeKB = 32768

Write-Output "Configuring System event log maximum size to $maxSizeKB KB..."
wevtutil sl $logName /ms:$maxSizeKB

# Verify
$currentSize = wevtutil gl $logName | Select-String "maxSize"
Write-Output "Current System log size setting: $currentSize"
