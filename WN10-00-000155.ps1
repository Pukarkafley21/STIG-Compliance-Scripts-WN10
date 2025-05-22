<#
.SYNOPSIS
    This PowerShell script disables the Windows PowerShell 2.0 feature to mitigate downgrade attacks, in accordance with STIG requirement WN10-00-000155.

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-04-19
    Last Modified   : 2025-04-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000155

.TESTED ON
    Date(s) Tested  : 2025-04-22
    Tested By       : Pukar Kafley
    Systems Tested  : Windows 10 Pro (22H2)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to disable Windows PowerShell 2.0.
    Example syntax:
    PS C:\> .\Disable-PowerShell2.ps1
#>

# Disable PowerShell 2.0 Feature
Write-Output "Disabling Windows PowerShell 2.0 feature..."

$features = @(
    "MicrosoftWindowsPowerShellV2Root",
    "MicrosoftWindowsPowerShellV2"
)

foreach ($feature in $features) {
    $current = Get-WindowsOptionalFeature -Online -FeatureName $feature
    if ($current.State -ne "Disabled") {
        Disable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart -ErrorAction Stop
        Write-Output "$feature has been disabled."
    } else {
        Write-Output "$feature is already disabled."
    }
}
