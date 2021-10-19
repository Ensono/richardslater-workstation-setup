#Requires -RunAsAdministrator

Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));

Set-Service -Name "ssh-agent" -StartupType Automatic
Start-Service -Name "ssh-agent"

$repoProfile = Join-Path -Path $PSScriptRoot -ChildPath "Microsoft.PowerShell_profile.ps1"
if (Test-Path $repoProfile) {
    if (Test-Path $PROFILE) {
        Remove-Item $PROFILE;
    }
    New-Item -Path $PROFILE -ItemType SymbolicLink -Value $repoProfile;
}

$repoScriptsPath = Join-Path -Path $PSScriptRoot -ChildPath "scripts"
$profilePath = Split-Path $PROFILE
$scriptsPath = Join-Path $profilePath -ChildPath "scripts"
if (Test-Path $repoScriptsPath) {
    if (Test-Path $scriptsPath) {
        Remove-Item $scriptsPath -Recurse -Force;
    }
    New-Item -Path $scriptsPath -ItemType SymbolicLink -Value $repoScriptsPath;
}