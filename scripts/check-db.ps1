# DB check 

# Variables
$connectionString = "string"
$isAqaReleaseEnv = $true

# Instal module sql server under admin rights ? (installed manualy, but need to do it automatically)
# Install-Module -Name sqlserver -Scope CurrentUser - accept Yes
# Import-Module -Name sqlserver

# 1. Check system user
$system_user_id = "00000000-0000-0000-0000-000000000000"
$check_system_user_query = "SELECT EMail FROM dbo.Persons WHERE Id ='$system_user_id'"

$check_system_user_result = Invoke-Sqlcmd -ConnectionString $connectionString -Query $check_system_user_query
Write-Host "1. User with Id = $system_user_id exists:" ($null -ne $check_system_user_result) -ForegroundColor Green

# 2. Check user count
if($isAqaReleaseEnv) {
    Write-Host "2. Users count:" $check_users_count_result.Column1 -ForegroundColor Green
    $check_users_count_query = "SELECT COUNT(EMail) FROM dbo.Persons"

    $check_users_count_result = Invoke-Sqlcmd -ConnectionString $connectionString -Query $check_users_count_query

    if($check_users_count_result.Column1 -lt 150){
        Write-Host "DB has been re-deployed." -ForegroundColor Green
    }    
    else {
        Write-Host "DB has NOT been re-deployed." -ForegroundColor Red
    }
}

# 3. Check settings in DB
$check_settings_query = "SELECT Name, IntValue FROM dbo.Settings WHERE Name in 
('test')"

$check_settings_result = Invoke-Sqlcmd -ConnectionString $connectionString -Query $check_settings_query
Write-Host "3. Settings table" -ForegroundColor Green
$check_settings_result | Format-Table -AutoSize
