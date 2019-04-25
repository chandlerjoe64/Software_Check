#Specify the program for which we are checking
$programName = "LastPass"

#$Computers = Import-CSV "Devices.csv"
$Computers = Import-CSV "Rewrite_debug.csv"

#Iterate over each device in the CSV
foreach($Computer in $Computers) {
    #append domain to hostname for alive-check
    $hostname = $Computer.Computer + ".na.corp"
    #perform alive check to prevent errors on offline devices
    if(Test-Connection -BufferSize 32 -Count 1 -ComputerName $hostname -Quiet) {
        #check if the software is installed on the remote machine
        $Installed = ((Get-WMIObject -ComputerName $Computer.Computer -Query "SELECT * FROM Win32_Product Where Name Like '%$programName%'").Name).Length -ne 0
        #Update terminal with status of device
        if($Installed) {
            Write-Host($programName + " is installed on host " + $Computer.Computer)
        } else {
            Write-Host($programName + " is NOT installed on host " + $Computer.Computer)
        }
        #If software is installed, change boolean value to reflect that
        $Computer.'Program Installed' = $Installed
        #if computer is checked sucessfuly, change 'checked' to true
        $Computer.'Checked' = $(1 -eq 1)
    }
}

Echo $Computers | Export-CSV "Rewrite_debug.csv" -NoTypeInformation
