<#
.SYNOPSIS
    This PowerShell script enables auditing for Process Creation failures, in accordance with STIG requirement WN10-AU-000585.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-27
    Last Modified   : 2025-04-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000585

.TESTED ON
    Date(s) Tested  : 2025-04-27
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enable Process Creation failure auditing.
    Example syntax:
    PS C:\> .\Enable-ProcessCreationFailureAudit.ps1

.NOTICE
    While the STIG requires enabling auditing for "Process Creation" failures, Microsoft typically logs only **success events** for this subcategory.
    Specifying failure auditing is syntactically valid but may not result in actual failure event logs being generated. Enabling failure logging ensures 
    STIG compliance but may not provide additional telemetry unless supported in future Windows builds.
#>

# Enable audit policy for Process Creation - Failure

$auditCategory = "Process Creation"
$currentSetting = auditpol /get /subcategory:"$auditCategory"

Write-Output "Checking current audit settings for '$auditCategory'..."
if ($currentSetting -notmatch "Failure") {
    Write-Output "Failure auditing is not enabled. Enabling now..."
    auditpol /set /subcategory:"$auditCategory" /failure:enable
    Write-Output "'Process Creation' failure auditing has been enabled."
} else {
    Write-Output "'Process Creation' failure auditing is already enabled."
}
