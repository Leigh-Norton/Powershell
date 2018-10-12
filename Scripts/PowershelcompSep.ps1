<#
Competition Instructions:
1. I want you to get a list of services of your own workstation and save it to a “csv” file
2. Stop the BITs service on your own workstation and get a list of services and save it to a “csv” file.
3. please remember to start the service BITS again.
4. Then you need to compare the two files against each other and show the differences. 
#>

#Globals
$currentUser = $env:USERNAME
$filepath1 = "C:\Users\"+$currentUser+"\Desktop\PCServices.csv"
$filepath2 = "C:\Users\"+$currentUser+"\Desktop\PCServices(BITSstopped).csv"
$filepath3 = "C:\Users\"+$currentUser+"\Desktop\Results.csv"

# 1. Get services and save as .csv
function listServices
{
    $services = Get-Service
    $filePath = $filepath1
    $services | Export-Csv -Path $filePath
}

# 2. Stop BITs service and get new list, save as .csv 
function stopBITS
{
    stop-service BITS
    $services = Get-Service
    $filePath = $filepath2
    $services | Export-Csv -Path $filePath
}

# 3. Restart BITs
function restartBITS
{
    Start-Service BITS
}

# 4. Compare files
function compare
{
    $file1 = Import-Csv -Path 'C:\Users\norton.leigh\Desktop\PCServices.csv'
    $file2 = Import-Csv -Path 'C:\Users\norton.leigh\Desktop\PCServices(BITSstopped).csv'

    $filePath = 'C:\Users\norton.leigh\Desktop\Results.csv'
    Compare-Object -ReferenceObject $file1 -DifferenceObject $file2 | Export-Csv -path $filepath -NoTypeInformation
}

# Run
function Run
{
    listServices
    stopBITS
    restartBITS
    compare
}

run