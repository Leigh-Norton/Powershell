$usersAnswer
$usersExpand
$usersTag = $null
$usersIP = $null


# Ask user if they have the service tag or IP
function options
{
    $usersAnswer = Read-host -prompt "Would you like to search by Service Tag or IP Address?"

    if ($usersAnswer -eq "Service Tag" -or $usersAnswer -eq "ST" -or $usersAnswer -eq "Service" -or $usersAnswer -eq "Tag" -or $usersAnswer -eq "ServiceTag")
    {
        getIP
    }

    if ($usersAnswer -eq "IP" -or $usersAnswer -eq "Address" -or $usersAnswer -eq "IP Address" -or $usersAnswer -eq "IPAddress")
    {
        getTag
    }

    if ($usersAnswer -eq "Test")
    {
        getTest
    }

}


# If the user asks to search by Service Tag this function will take the provided tag and run IPconfig on that machine to produce 
# an IP address
function getIP
{
    # Prompt user for service tag and take input
    $usersTag = Read-host -prompt "Please provide a service tag"

    #write-host $usersTag

    #$usersIP = (Test-Connection -ComputerName ($usersTag) -Count 1).IPV4Address.IPAddressToString
    
    #Write-Host "`nThe IP address for $usersTag is $usersIP"

    $usersExpand = Read-host -Prompt "Would you like expanded information?"
    
    if ($usersExpand -eq "no")
    {
        $usersIP = Invoke-Command -ComputerName $usersTag -ScriptBlock{ipconfig | Select-String IPv4} 
        Write-host "`n$usersTag . . . . $usersIP"
    }

    if ($usersExpand -eq "yes")
    {
        Invoke-Command -ComputerName $usersTag -ScriptBlock{ipconfig}
    }
}

# If the user asks to search by IP this function will take the provided IP adderess and run a script to find the Host Name on the PC
# at that address
function getTag
{
    # Prompt user for IP and take input
    $usersIP = Read-host -prompt "Please provide an IP"

    #$usersTag = Test-Connection $usersIP -count 1 | Select destination
    #$usersTag = [System.Net.dns]::GetHostEntry($usersIP) #SOMETHING WRONG HERE

    #Write-Host "`nThe Service Tag for $usersIP is $usersTag"

    $usersTag = ([System.Net.Dns]::GetHostByAddress($usersIP).HostName)

    Write-Host "`nThe Service Tag for $usersIP is $usersTag"
}

# Function for testing
function getTest
{
    Write-Host "Test Tags:
               5CG6042WP8
               CZC1483YM7
               CZC4450NTN
               CZC6397JTK - Dean
               CZC6397JZY - Hayley"
    $usersTag = Read-host -prompt "Please provide a service tag"

    Invoke-Command -ComputerName $usersTag -ScriptBlock{ipconfig}
}

# Runs initial function that asks users which service they would like to run
options


<#
#Get-NetIPAddress
#Get-NetIPAddress | Format-Table
#invoke-command
#>