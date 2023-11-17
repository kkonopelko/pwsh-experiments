# Useful information

## Powershell versions:

 - v5.x - not cross platform, usually on the Win OS by default
 - v6.x - cross-platform, compatibal commands with v5.x
 - v7.x - cross-platform, new cool commands, not compatible with v5.x v6.x, but v5.x compatible with v7.x

## Powershell supports:

1. Window native command: notepad, ipconfig /all, calculator...
2. Scripts : if, else, while
3. Cmdlets:
	- set-location c:\ (cd) 
	- get-childitem (ls)
	- clear-host - clear screen (cls)
4. Aliasis: 
	- cd c:\
	- dir
	- cls
	

## PowerShell Cmdlets:

`get-alias cls` - return info about cls

`get-help get-service` -detailed (or -showwindow)

`get-help *process*/get-*service*` - will search for similar cmdlets in pwsh

`get-verb` - shoes all verb that pwsh is working with

`get-module, import-module -name selenium`  - get info about modules

`set-location c:\` - sets location for specific path

`get-childitem path/directory` - gets list of objects


## Structure od pwsh command:

`Get-Fake -param Arg -param -param arg,arg`

- can be -param Arg
- can be -param without arg (switch param)
- can be -param arg,arg (multiple args)
