$branchName = "develop"
$repositoriesPath = "D:\Repository\Shared"

Set-Location -Path $repositoriesPath
$dir = Get-ChildItem -Directory
$dir | ForEach-Object {
    Set-Location $_
    git checkout $branchName
    git pull
    Set-Location ..\
}