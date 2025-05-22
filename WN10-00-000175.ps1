<#
.SYNOPSIS
    Disables the Secondary Logon service to comply with STIG ID WN10-00-000175.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-18
    Last Modified   : 2025-04-18
    Version         : 1.0
    STIG-ID         : WN10-00-000175

.TESTED ON
    Date(s) Tested  : 2025-04-18
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (21H2), 
    PowerShell Ver. : 5.1 and 7.2

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\> .\Disable-SecondaryLogon.ps1
#>

# Disable the Secondary Logon service
Write-Output "Disabling the 'Secondary Logon' service (seclogon)..."

Set-Service -Name "seclogon" -StartupType Disabled

# Stop the service if it's running
if ((Get-Service -Name "seclogon").Status -eq "Running") {
    Stop-Service -Name "seclogon" -Force
}

Write-Output "'Secondary Logon' service has been disabled successfully."
