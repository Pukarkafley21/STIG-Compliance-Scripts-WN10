<#
.SYNOPSIS
    Remediates STIG WN10-AC-000010 by setting the Account Lockout Threshold to 3 invalid logon attempts.

.NOTES
    Author        : Pukar Kafley
    LinkedIn      : https://www.linkedin.com/in/pukar-kafley/
    GitHub        : https://github.com/Pukarkafley21
    Created       : 2025-04-21
    STIG-ID       : WN10-AC-000010
#>

# Create temp directory if needed
$tempPath = "C:\temp"
if (-not (Test-Path $tempPath)) {
    New-Item -ItemType Directory -Path $tempPath | Out-Null
}

# Export current security settings
secedit /export /cfg "$tempPath\secpol.cfg" | Out-Null

# Read config file
$config = Get-Content "$tempPath\secpol.cfg"

# Set or add LockoutThreshold = 3
if ($config -match "^LockoutBadCount\s*=") {
    $config = $config -replace "^LockoutBadCount\s*=.*", "LockoutBadCount = 3"
} else {
    $config += "`r`nLockoutBadCount = 3"
}

# Write updated config back
Set-Content "$tempPath\secpol.cfg" $config

# Apply new settings
secedit /configure /db "$env:SystemRoot\security\local.sdb" /cfg "$tempPath\secpol.cfg" /areas SECURITYPOLICY

# Clean up
Remove-Item "$tempPath\secpol.cfg" -Force

Write-Output "STIG WN10-AC-000010 remediated: Account Lockout Threshold set to 3."
