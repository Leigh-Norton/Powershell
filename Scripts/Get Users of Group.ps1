$ADGroup = "SocPolAllstaff" # Set name of required group here
$filepath = "C:\Users\"+$env:USERNAME+"\Desktop\"+$ADGroup+"List.csv" # Saves .csv file to current users desktop with name AD group name specified

Get-ADGroupMember -identity $ADGroup -Recursive | Get-ADUser -Property DisplayName | Select Name | Sort-Object name | export-csv -Path $filepath -NoTypeInfo
