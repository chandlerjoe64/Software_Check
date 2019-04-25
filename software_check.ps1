Function Initialize_False {
    $Devices = Import-CSV "Devices.csv"
    foreach($Device in $Devices) {
        $Device.'Checked' = $false
        $Device.'Program Installed' = $false
    }
    Echo $Devices | Export-CSV "Devices.csv" -NoTypeInformation
}

#Only run this line once to initialize the CSV with proper values
#Initialize_False
#Start-Sleep -Seconds 600


#Specify the program for which we are checking
$programName = "Cylance"


While($true) {
    $Computers = Import-CSV "Devices.csv"

    #Iterate over each device in the CSV
    foreach($Computer in $Computers) {
        #If device has been checked, skip
        if($Computer.'Checked' -ne "False") {
            Continue
        }
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
            $Computer.'Checked' = $true
        }
    }
    Echo $Computers | Export-CSV "Devices.csv" -NoTypeInformation
    
    #sleep for 10 minutes to slow execution
    Start-Sleep -Seconds 600
}