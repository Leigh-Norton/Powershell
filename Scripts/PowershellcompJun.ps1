#region Test
#$var = Get-Service

# $var.count
# $var | Select-Object *
# $var | Select-Object -Property name, status
# $var | Select-Object -property name, status | WHERE {$_.Status -match "Running"}
# ($var | Select-Object -property name, status | WHERE {$_.Status -match "Running"}).count

#endregion

$var = Get-Service

function RunningServices
{
    Write-Host "Total Services: " $var.count
     
    Write-Host "Running Services: " ($var | Select-Object -property name, status | 
    WHERE {$_.Status -match "Running"}).count
}

RunningServices