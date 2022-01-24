#Requires -RunAsAdministrator

# Delete all of the shortcuts that get created on the Desktop
$publicDesktopShortcuts = Get-ChildItem C:\Users\Public\Desktop -Filter *.lnk;
$personalDesktopShortcuts = Get-ChildItem ([System.Environment]::GetFolderPath('Desktop')) -Filter *.lnk;
$shortCutsToDelete = $publicDesktopShortcuts + $personalDesktopShortcuts;
if (($shortCutsToDelete | Measure-Object).Count -gt 0) {
    $shortCutsToDelete | Remove-Item;
}

# remove executables that get in the way of functional SSH and PGP authentication
$gpgBinRoot = "C:\Program Files\Git\usr\bin\"
$gbgBinExecutablesToRemove = @(
  "gpg.exe"
  "ssh.exe"
)
Get-ChildItem -Path $gpgBinRoot | Where-Object { $gbgBinExecutablesToRemove.Contains($_.Name) } | Remove-Item
