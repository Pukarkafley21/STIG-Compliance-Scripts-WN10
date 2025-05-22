<#
.SYNOPSIS
    This PowerShell script removes "Run as different user" from context menus for key executable file types, in accordance with STIG requirement WN10-CC-000039.

.STIG SUMMARY
    STIG ID       : WN10-CC-000039
    Rule ID       : SV-220801r958478_rule
    Vuln ID       : V-220801
    Severity      : CAT II
    Description   : Prevents users from using alternate credentials via context menus, which could expose privileged credentials in user sessions.
    Fix Text      : Set the 'Attributes' value to 4096 under the appropriate FileAssociation paths in the registry.
    Affected Paths:
        HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer\FileAssociation\batfile\shell\runasuser
        HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer\FileAssociation\cmdfile\shell\runasuser
        HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer\FileAssociation\exefile\shell\runasuser
        HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer\FileAssociation\mscfile\shell\runasuser
    Reference     : https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_MS_Windows_10_V3R2_STIG.zip

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 2025-05-03
    Last Modified   : 2025-05-05
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enforce removal of "Run as different user" from context menus.
    Example:
    PS C:\> .\Disable-RunAsDifferentUserContext.ps1
#>

# File types to apply the policy to
$fileTypes = @("batfile", "cmdfile", "exefile", "mscfile")
$basePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer\FileAssociation"

foreach ($fileType in $fileTypes) {
    $regPath = "$basePath\$fileType\shell\runasuser"

    # Ensure path exists
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    # Set the Attributes value to 4096 to remove "Run as different user"
    Set-ItemProperty -Path $regPath -Name "Attributes" -Value 4096 -Type DWord

    # Confirm application
    $current = (Get-ItemProperty -Path $regPath -Name "Attributes").Attributes
    if ($current -eq 4096) {
        Write-Output "'Run as different user' successfully removed for $fileType (Attributes = 4096)."
    } else {
        Write-Output "Failed to apply setting for $fileType. Current value: $current"
    }
}
