# Variables
$project_id = "1" # open your TestRail project in the browser and view the ID at the end of the URL
$milestone_id = "43" # every release new value, need to be passed as a parameter to script
$admin20_test_suite_id = "741" # static for admin team
$admin10_test_suite_id = "217" # static for admin team

# url for requests - REPLACE URL with valid value!!!
$get_run_url = "https://test.testrail.io/index.php?/api/v2/get_run/5555"
$get_case_url = "https://test.testrail.io/index.php?/api/v2/get_case/95888"
$create_test_plan_url = "https://test.testrail.io/index.php?/api/v2/add_plan/$project_id"

$add_test_run_to_test_plan_url = "https://test.testrail.io/index.php?/api/v2/add_plan_entry/8228"
$create_test_run_url = "https://test.testrail.io/index.php?/api/v2/add_run/$project_id"
$get_admin20_cases_url = "https://test.testrail.io/index.php?/api/v2/get_cases/$project_id&suite_id=$admin20_test_suite_id"
$get_admin10_cases_url = "https://test.testrail.io/index.php?/api/v2/get_cases/$project_id&suite_id=$admin10_test_suite_id"


$smoke_test_plan_name = "ADMIN R1.1 / AQA / Automated Smoke"
$regression_test_plan_name = "ADMIN R1.1 / AQA / Automated Regression"
$test_run_api_name = "ADMIN R1.1 - API"
$test_run_e2e_name = "ADMIN R1.1 - UI"

$authorization = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("email:password"))

$headers = @{
    Authorization = "Basic $authorization"
}

# Invoke-RestMethod -Uri $get_run_url -Method Get -Headers $headers


# Create Test plan for Milestone

$create_test_plan_body = @{
    "name" = $smoke_test_plan_name
    "milestone_id" = $milestone_id
} | ConvertTo-Json

$result = Invoke-RestMethod -Uri $create_test_plan_url -Method Post -Headers $headers -Body $create_test_plan_body -ContentType "application/json"
$test_plan_id;
Write-Host "Test Plan was created. $test_plan_id = "$result.id


# Get case information

# $info = Invoke-RestMethod -Uri $get_case_url -Method Get -Headers $headers
# Write-Host $info


# Get cases by filter, save case ids to array, pass to next step

# custom_automated=1; - Yes
# custom_automation_type=3; - E2E
# custom_cur_state=1; up to date
# type_id=15 - Core Smoke / 15

$smoke_e2e_cases_filter = "custom_automated=1&custom_automation_type=3&custom_cur_state=1&type_id=15"

$automated_smoke_test_case_ids = Invoke-RestMethod -Uri "$get_admin20_cases_url&$smoke_e2e_cases_filter" -Method Get -Headers $headers

$array = $automated_smoke_test_case_ids.cases.id
Write-Host $array, $array.Length


# # Create test run for Test plan

# $create_test_run_body = @{
#     "suite_id" = "741"
#     "name" = "$test_run_e2e_name : Admin 2.0"
#     "milestone_id" = $milestone_id
#     "include_all" = "0"
#     "description" = "Smoke test run for E2E tests for Admin 2.0"
#     "case_ids" = $array
# } | ConvertTo-Json

# $result = Invoke-RestMethod -Uri $create_test_run_url -Method Post -Headers $headers -Body $create_test_run_body -ContentType "application/json"
# $test_run_id;
# Write-Host "Test run was created. $test_run_id = "$result.id

# Update test plan

$update_test_plan_body = @{
    "name" = "$test_run_e2e_name : Admin 2.0: RC3"
    "suite_id" = $admin20_test_suite_id
    "runs" = @(
        @{
            "include_all"= $false
            "case_ids" = $array
    })
} | ConvertTo-Json -Depth 10

Invoke-RestMethod -Uri $add_test_run_to_test_plan_url -Method Post -Headers $headers -Body $update_test_plan_body -ContentType "application/json"



# Output: 
# test plan id:
# test run id: 