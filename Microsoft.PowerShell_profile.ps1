Set-StrictMode -Version Latest;
$Global:DebugPreference = "SilentlyContinue";
$Global:VerbosePreference = "SilentlyContinue";
$host.ui.RawUI.WindowTitle = "PowerShell";

# Configure ServicePointManager to Prefer TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$global:WindowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent();
$global:WindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($WindowsIdentity);
$global:IsAdmin = $WindowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator);

# PoshGit
$poshGitPath = 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'
if (Test-Path($poshGitPath)) {
    Import-Module "$poshGitPath"
}

# Oh My PoSH
if ((Get-Module -ListAvailable oh-my-posh | Measure-Object).Count -gt 0) {
    Import-Module oh-my-posh
    Set-PoshPrompt -Theme blue-owl
}

# Import Scripts
$ProfilePath = Split-Path $PROFILE;
Get-ChildItem "$ProfilePath\scripts" -Filter *.ps1 | ForEach-Object {
    . $_.FullName
};

if ((Get-Command -Type Application git -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0) {
    $env:SSH_AUTH_SOCK = $null;
    git config --global user.name "Richard Slater";
    git config --global user.email "richard.slater@amido.com";
    git config --global core.editor "vim";
    git config --global color.ui true;
    git config --global core.eol lf;
    git config --global core.autocrlf input;
    git config --global mergetool.vimdiff3.cmd 'vim -f -d -c "wincmd J" "$MERGED" "$LOCAL" "$BASE" "$REMOTE"';
    git config --global merge.tool vimdiff3;
    git config --global branch.autosetupmerge true;
    git config --global push.default simple;
    git config --global pull.rebase true;
    git config --global commit.gpgsign true
    git config --global user.signingkey E5CF0F3B67127D6A;

    if ((ssh-add -l | Where-Object {$_.Contains("Richard Slater 2018")} | Measure-Object).Count -eq 0) {
        ssh-add "$env:USERPROFILE\.ssh\richard@richard-slater.co.uk-2018.rsa"
    }   
}