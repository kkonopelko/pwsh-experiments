# v5.x - not cross platform, usually on the Win OS by default
# v6.x - cross-platform, compatibal commands with v5.x
# v7.x - cross-platform, new cool commands, not compatible with v5.x v6.x, but v5.x compatible with v7.x


Write-Output "Check PowerShell version"
$PSVersionTable # for powershel 5.x version
# pwsh -version - for v7.x

Write-Output "Check .NET SDK version"
dotnet --version

Write-Output "Check Python version"
python --version
git --version