<#
.SYNOPSIS
    This PowerShell script sets the ECC curve order to prioritize stronger elliptic curves (NistP384 first), in accordance with STIG requirement WN10-CC-000052.

.STIG SUMMARY
    STIG ID       : WN10-CC-000052
    Rule ID       : SV-220805r971535_rule
    Vuln ID       : V-220805
    Severity      : CAT II
    Description   : Configures SSL to prioritize ECC curves with longer key lengths to enhance cryptographic strength.
    Fix Text      : Set 'EccCurves' to 'NistP384 NistP256' under the correct SSL policy path.
    Registry Path : HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002
    Value Name    : EccCurves
    Value Type    : REG_SZ
    Value Data    : NistP384 NistP256
    Reference     : https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_MS_Windows_10_V3R2_STIG.zip

.NOTES
    Author          : Pukar Kafley
    LinkedIn        : https://www.linkedin.com/in/pukar-kafley/
    GitHub          : https://github.com/Pukarkafley21
    Date Created    : 25-05-09
    Last Modified   : 25-05-012
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to enforce ECC curve ordering.
    Example:
    PS C:\> .\Set-ECCCurveOrder.ps1
#>

# Set ECC Curve Order to 'NistP384 NistP256'

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$regName = "EccCurves"
$desiredValue = "NistP384 NistP256"

Write-Output "Configuring ECC Curve Order for SSL to prioritize stronger curves..."

# Create registry path if needed
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the ECC curve order
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type String

# Confirm setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
if ($currentValue -eq $desiredValue) {
    Write-Output "ECC Curve Order successfully configured (EccCurves = $desiredValue)."
} else {
    Write-Output "Failed to configure ECC curve order. Current value: $currentValue"
}
