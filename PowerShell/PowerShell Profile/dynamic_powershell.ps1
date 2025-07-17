# Pull PowerShell profile from GitHub
$remoteProfile = 'https://raw.githubusercontent.com/bigjoestretch/public/refs/heads/main/PowerShell/PowerShell%20Profile/Microsoft.PowerShell_profile.ps1'

try {
    Invoke-RestMethod -Uri $remoteProfile -OutFile "$env:TEMP\remote_profile.ps1" -ErrorAction Stop
    . "$env:TEMP\remote_profile.ps1"
    Write-Host "✅ Remote profile loaded from bigjoestretch's GitHub"
} catch {
    Write-Warning "⚠ Failed to load remote profile: $_"
}
