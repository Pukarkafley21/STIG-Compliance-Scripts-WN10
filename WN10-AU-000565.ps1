<#
.SYNOPSIS
    This PowerShell script configures audit policy to log failures for Other Logon/Logoff Events, in accordance with STIG requirement WN10-AU-000565.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-26
    Last Modified   : 2025-04-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000565

.TESTED ON
    Date(s) Tested  : 2025-04-29
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enable auditing for Other Logon/Logoff Events (Failures).
    Example syntax:
    PS C:\> .\Enable-OtherLogonLogoffFailureAudit.ps1
#>

# Enable audit policy for Other Logon/Logoff Events - Failure

$auditCategory = "Other Logon/Logoff Events"
$currentSetting = auditpol /get /subcategory:"$auditCategory"

Write-Output "Checking current audit settings for '$auditCategory'..."
if ($currentSetting -notmatch "Failure") {
    Write-Output "Failure auditing is not enabled. Enabling now..."
    auditpol /set /subcategory:"$auditCategory" /failure:enable
    Write-Output "'Other Logon/Logoff Events' failure auditing has been enabled."
} else {
    Write-Output "'Other Logon/Logoff Events' failure auditing is already enabled."
}
