<#
.SYNOPSIS
    This PowerShell script configures audit policy to log failures for Account Logon - Credential Validation, in accordance with STIG requirement WN10-AU-000005.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-25
    Last Modified   : 2025-04-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000005

.TESTED ON
    Date(s) Tested  : 2025-04-25
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enable audit logging for Credential Validation failures.
    Example syntax:
    PS C:\> .\Enable-CredentialValidationFailureAudit.ps1
#>

# Configure audit policy for Credential Validation failures
Write-Output "Enabling audit policy for Credential Validation failures..."

$auditCategory = "Credential Validation"
$currentSetting = auditpol /get /subcategory:"$auditCategory"

if ($currentSetting -notmatch "Failure") {
    auditpol /set /subcategory:"$auditCategory" /failure:enable
    Write-Output "'Credential Validation' failure auditing has been enabled."
} else {
    Write-Output "'Credential Validation' failure auditing is already enabled."
}
