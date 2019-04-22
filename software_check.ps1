#Specify the program for which we are checking
$programName = "LastPass"

$Computers = Import-CSV "Devices.csv"

foreach($Computer in $Computers) {
    $Installed = ((Get-WMIObject -ComputerName $Computer.Computer -Query "SELECT * FROM Win32_Product Where Name Like '%$programName%'").Name).Length -ne 0
    if($Installed) {
        Write-Host($programName + " is installed on host " + $Computer.Computer)
    } else {
        Write-Host($programName + " is NOT installed on host " + $Computer.Computer)
    }
    $Computer.'Program Installed' = $Installed
}

Echo $Computers | Export-CSV "Rewrite_debug.csv" -NoTypeInformation
