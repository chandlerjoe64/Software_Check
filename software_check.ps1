#Specify the program for which we are checking
$programName = "LastPass"

((Get-WMIObject -Query "SELECT * FROM Win32_Product Where Name Like '%$programName%'").Name).Length -ne 0