
# Approach 1: Import Selenium-driver
$workingPath = "D:\Repository_mine\learning-pwsh"

Import-Module "$workingPath\WebDriver.dll"

# Create a new ChromeDriver Object instance.
# $ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
# $ChromeOptions.AddArgument('start-maximized')
# $ChromeOptions.AcceptInsecureCertificates = $true

$ChromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver 

#-ArgumentList $ChromeOptions

# Launch a browser and go to URL
$ChromeDriver.Navigate().GoToURL('https://google.com')

#  Cleanup
$ChromeDriver.Close()
$ChromeDriver.Quit()

# Approach 2: The line below will Import-Module Selenium if it fails it will display the installation command and stop the script. 
Install-Module -Name Selenium -Scope CurrentUser # need to find way to accept Yes
# Import-Module -Name Selenium

# Start the Selenium Chrome Driver
# Start-SeDriver -Browser Chrome -StartURL $env_url
$Driver = Start-SeChrome