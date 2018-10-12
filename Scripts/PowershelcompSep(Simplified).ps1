<#
Competition Instructions:
1. I want you to get a list of services of your own workstation and save it to a “csv” file
2. Stop the BITs service on your own workstation and get a list of services and save it to a “csv” file.
3. please remember to start the service BITS again.
4. Then you need to compare the two files against each other and show the differences. 
#>

#Globals
$currentUser = $env:USERNAME
$filepathCurr = "C:\Users\"+$currentUser+"\Desktop\PCServices.csv"
$filepathNew = "C:\Users\"+$currentUser+"\Desktop\PCServices(BITSstopped).csv"
$filepathResult = "C:\Users\"+$currentUser+"\Desktop\Results.csv"

# 1. Get services and save as .csv
$services = Get-Service
$services | Export-Csv -Path $filepathCurr

# 2. Stop BITs service and get new list, save as .csv 
stop-service BITS
$services = Get-Service
$services | Export-Csv -Path $filepathNew

# 3. Restart BITs
Start-Service BITS

# 4. Compare files
$file1 = Import-Csv -Path $filepathCurr
$file2 = Import-Csv -Path $filepathNew

Compare-Object $file1 $file2 -property Name, DisplayName, Status | export-csv -Path $filepathResult -NoTypeInfo

