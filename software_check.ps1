#Specify the program for which we are checking
$programName = "LastPass"

#DEBUG
#TODO replace with read-in values for computers in the domain
$Computers = "COAC6S8K32", "COA26SQHQ2", "COA26SSHQ2"

foreach($Computer in $Computers) {
    Write-Host($Computer)
}

#((Get-WMIObject -Query "SELECT * FROM Win32_Product Where Name Like '%$programName%'").Name).Length -ne 0