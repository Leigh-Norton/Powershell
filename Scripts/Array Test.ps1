# Test Arrays

$Line = "-"
$Edge = "|"


$myMultiArray = @()
$myArrayCounter = $null
$arrayOutput= @()

$numberX = $null
$numberY = $null

$stringArray = $null

# Write-Host $Line
# Write-host $Edge


<# Test FOR loop
for ($i = 0; $i -lt 10; $i++)
{
    if ($i % 2 -eq 0)
    {
        Write-Host $i $Line "EVEN" 
    }
    else 
    {
        Write-Host $i $Edge "ODD"
    }
}
#>

<#
$myArrayCounter ++
$myMultiArray += ,@($myArrayCounter, "First")
$myArrayCounter ++
$myMultiArray += ,@($myArrayCounter, "Second")
$myArrayCounter ++
$myMultiArray += ,@($myArrayCounter, "Third")
$myArrayCounter ++
$myMultiArray += ,@($myArrayCounter, "Fourth")
$myArrayCounter ++
$myMultiArray += ,@($myArrayCounter, "Fifth")
$myArrayCounter ++
$myMultiArray += ,@($myArrayCounter, "Sixth")

foreach($number in $myMultiArray)
{
    Write-Host ($number)
}

#>

for ($x = 0; $x -lt 5; $x ++)
{
    for ($y = 0; $y -lt 5; $y ++)
    {
        #$myMultiArray += ,@($x, $y)

        #$stringArray += $y.ToString() 
        #$stringArray 

        if (($y -eq 0) -or ($y -eq 4))
        {
            $myMultiArray += (0 + $y) #$Edge
        }

        else
        {
            $myMultiArray += (0 + $x) #$Line
        }

    }

    #$stringArray += $x.ToString() 
    #$stringArray 
    Write-Host $myMultiArray
    
}

#Write-Host $myMultiArray



