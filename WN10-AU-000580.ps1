<#
.SYNOPSIS
    This PowerShell script enables auditing for MPSSVC Rule-Level Policy Change failures, in accordance with STIG requirement WN10-AU-000580.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-24
    Last Modified   : 2025-04-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000580

.TESTED ON
    Date(s) Tested  : 2025-04-27
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enable auditing for MPSSVC Rule-Level Policy Change (Failures).
    Example syntax:
    PS C:\> .\Enable-MPSSVCPolicyChangeFailureAudit.ps1
#>

# Enable auditing for MPSSVC Rule-Level Policy Change - Failure

$auditCategory = "MPSSVC Rule-Level Policy Change"
$currentSetting = auditpol /get /subcategory:"$auditCategory"

Write-Output "Checking current audit settings for '$auditCategory'..."
if ($currentSetting -notmatch "Failure") {
    Write-Output "Failure auditing is not enabled. Enabling now..."
    auditpol /set /subcategory:"$auditCategory" /failure:enable
    Write-Output "'MPSSVC Rule-Level Policy Change' failure auditing has been enabled."
} else {
    Write-Output "'MPSSVC Rule-Level Policy Change' failure auditing is already enabled."
}
