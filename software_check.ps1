function Software_Check($computer, $programName ) {
$wmi_check = (Get-WMIObject -ComputerName $computer -Query "SELECT * FROM Win32_Product Where Name Like '%$programName%'").Length -gt 0
return $wmi_check;
}
 
Check_Program_Installed("COAC6S8K32","LastPass")