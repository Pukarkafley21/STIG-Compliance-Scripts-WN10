<#
.SYNOPSIS
    Remediates STIG WN10-00-000031 by configuring BitLocker for pre-boot authentication using TPM + PIN.

.NOTES
    Author        : Pukar Kafley
    LinkedIn      : https://www.linkedin.com/in/pukar-kafley/
    GitHub        : https://github.com/Pukarkafley21
    Created       : 2025-04-18
    STIG-ID       : WN10-00-000031

.TESTED ON
    - Windows 10 Pro (21H2) with TPM present and ready
    - Azure Gen2 VM with vTPM enabled (Trusted Launch)
#>

# Ensure BitLocker module is loaded
Import-Module BitLocker -ErrorAction Stop

# Check TPM availability
$tpm = Get-Tpm
if (-not $tpm.TpmPresent -or -not $tpm.TpmReady) {
    Write-Warning "TPM is not available or not ready. Cannot continue with STIG-compliant remediation."
    exit 1
}

# Configure BitLocker policy (GPO equivalent via registry)
Write-Output "Configuring registry to enforce TPM + PIN policy..."

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"
New-Item -Path $regPath -Force | Out-Null

Set-ItemProperty -Path $regPath -Name "UseTPM" -Value 2 -Type DWord            # TPM required
Set-ItemProperty -Path $regPath -Name "UseTPMPIN" -Value 1 -Type DWord         # PIN required
Set-ItemProperty -Path $regPath -Name "UseTPMKeyPIN" -Value 1 -Type DWord      # Key + PIN (optional, still compliant)
Set-ItemProperty -Path $regPath -Name "EnableBDEWithNoTPM" -Value 0 -Type DWord # Prevent enabling BitLocker without TPM

# Check BitLocker status
$bitlockerStatus = Get-BitLockerVolume -MountPoint "C:"
if ($bitlockerStatus.ProtectionStatus -eq "Off") {
    Write-Output "BitLocker is not enabled on the OS drive. Enabling with TPM + PIN..."

    # Prompt user to set a secure PIN
    $pin = Read-Host -Prompt "Enter a secure BitLocker PIN (will not be masked)"

    Enable-BitLocker -MountPoint "C:" -TpmAndPinProtector -Pin $pin -EncryptionMethod XtsAes256 -UsedSpaceOnly
    Write-Output "BitLocker enabled with TPM + PIN successfully."
} else {
    Write-Output "BitLocker is already enabled. Adding TPM + PIN protector..."

    $pin = Read-Host -Prompt "Enter a secure BitLocker PIN to add"
    Add-BitLockerKeyProtector -MountPoint "C:" -TpmAndPinProtector -Pin $pin
    Write-Output "TPM + PIN protector added to existing BitLocker configuration."
}
