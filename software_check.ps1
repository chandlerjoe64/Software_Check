#Function originally copied from https://www.morgantechspace.com/2018/02/check-if-software-program-is-installed-powershell.html

function Software_Check($computer, $programName ) {
    #Use get-wmi to check if remote device has software installed, suppressing error messages, and returning a boolean value
    $wmi_check = (Get-WMIObject -erroraction 'silentlycontinue' -ComputerName $computer -Query "SELECT * FROM Win32_Product Where Name Like '%$programName%'").Length -gt 0
    return $wmi_check; #Boolean value
}
 
#This is a check for software on the local machine for software that is KNOWN INSTALLED
if(Software_Check("COAC6S8K32","LastPass")) {
    Write-Host("LastPass is installed")
} else {
    Write-Host("LastPass is NOT installed")
}

#This is a check for software on the local machine for software that is NOT INSTALLED
if(Software_Check("COAC6S8K32","Safari")) {
    Write-Host("Safari is installed")
} else {
    Write-Host("Safari is NOT installed")
}