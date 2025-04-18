<#
.SYNOPSIS
    This PowerShell script ensures that the Account Lockout Duration for failed login attempts is configured to at least 15 minutes, in accordance with STIG requirement WN10-AC-000005.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-18
    Last Modified   : 2025-04-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 2025-04-18
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (21H2), Windows 11 Pro (23H2)
    PowerShell Ver. : 5.1 and 7.2

.USAGE
    Run this script with administrative privileges to ensure that the local security policy is updated.
    Example syntax:
    PS C:\> .\Set-AccountLockoutDuration.ps1
#>


# Create the temp directory if it doesn't exist
if (-not (Test-Path "C:\temp")) {
    New-Item -ItemType Directory -Path "C:\temp" | Out-Null
}

# Export current security policy
secedit /export /cfg C:\temp\secpol.cfg

# Check if LockoutDuration already exists, if not, add it; otherwise, replace value
$cfgPath = "C:\temp\secpol.cfg"
$content = Get-Content $cfgPath

if ($content -match "^LockoutDuration\s*=") {
    $content = $content -replace "^LockoutDuration\s*=.*", "LockoutDuration = 15"
} else {
    $content += "`r`nLockoutDuration = 15"
}

# Save changes
Set-Content -Path $cfgPath -Value $content

# Apply the updated settings
secedit /configure /db C:\Windows\Security\Local.sdb /cfg $cfgPath /areas SECURITYPOLICY

# Clean up
Remove-Item $cfgPath -Force

Write-Output "Account lockout duration set to 15 minutes."


## You can Also manually set these policies via secpol.msc > Account Policies > Account Lockout policy