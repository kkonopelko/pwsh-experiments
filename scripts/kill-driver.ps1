# Kill chromedriver in the processes, usefull for AQA engineers.
$chromeDrivers = Get-Process | Where-Object {$_.ProcessName.StartsWith("chromedriver")}
    if($chromeDrivers)
    {
        Stop-Process $chromeDrivers
    }