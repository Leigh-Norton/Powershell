#region Form Setup
# Add Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms
Import-Module activedirectory

# Create form object
$form = New-Object System.Windows.Forms.Form

# Adds a title to the form
$form.Text = "Combined Form and Script"

# Set icon for form
# From icon file
$icon = New-Object system.drawing.icon("C:\Program Files (x86)\Microsoft Office\Office14\GRAPH.ICO")
# Or from an associated file
$icon = [System.Drawing.Icon]::ExtractAssociatedIcon($PSHOME+"\powershell.exe")
$form.Icon = $icon

# Set form size
#Enable AutoSize, Auto fits to controls placed in form but does NOT allow user resizing
$form.AutoSize = $true
# AutosizeMode can be "GrowAndShrink" or "GrowOnly", GrowOnly allows user to adjust size but does not scale the height of the form
$form.AutosizeMode = "GrowAndShrink"

# These settings disable the Maximise and Minimise buttons
$form.MinimizeBox = $false
$form.MaximizeBox = $false

# This option sets how the form starts. Options for this are "Maximized", "Minimized" or "Normal"
$form.WindowState = "Normal"

# This option sets the visibility of the Resize grip. Options for this are "Auto", "Hide" or "Show"
$form.SizeGripStyle = "Hide"

# This option decides if the form will show as an icon in the task bar
$form.ShowInTaskbar = $true

# This option sets the position of the form when it first opens. This can be set to "CenterScreen", "Manual", 
# "WindowsDefaultLocation", "WindowsDefaultBounds" or "CenterParent"
$form.StartPosition = "CenterScreen"
#endregion

#region Label Text Setup
# Creates a font to be used for text
# Format: System.Drawing.Font(Font, Size, [System.Drawing.FontStyle]::Style)
# Styles available: Regular, Bold, Italic, Underline, Strikeout
$font = New-Object System.Drawing.Font("Times New Roman", 12, [System.Drawing.FontStyle]::Regular)

# Tells the form to use a specified font
$form.Font = $font

# Adds text to the body of the form
# Creates text object
#region Header label
$labelHeader = New-Object System.Windows.Forms.Label
$labelHeader.Text = "Please select from an option below: "
#$labelHeader.Location
$labelHeader.BackColor = "Transparent"
$labelHeader.AutoSize = $true
$form.Controls.Add($labelHeader)
#endregion Header label

#region Service Tag label
$labelServiceTag = New-Object System.Windows.Forms.Label
$labelServiceTag.Text = "Search by Service Tag"

$labelServiceTag.Location = New-Object System.Drawing.Point(0, ($labelHeader.Location.Y + 30))

# Set colour of background behind text. This will default to the grey form colour
$labelServiceTag.BackColor = "Transparent"

$labelServiceTag.AutoSize = $true
# Adds the text object to the form
$form.Controls.Add($labelServiceTag)
#endregion Service Tag label

#region IP label
$labelIP = New-Object System.Windows.Forms.Label
$labelIP.Text = "Search by IP"

$labelIP.Location = New-Object System.Drawing.Point(0, ($labelServiceTag.Location.Y + 40))

# Set colour of background behind text. This will default to the grey form colour
$labelIP.BackColor = "Transparent"

$labelIP.AutoSize = $true
# Adds the text object to the form
$form.Controls.Add($labelIP)
#endregion IP label

#region User label
$labelUser = New-Object System.Windows.Forms.Label
$labelUser.Text = "Access user specific information"

$labelUser.Location = New-Object System.Drawing.Point(0, ($labelIP.Location.Y + 40))

# Set colour of background behind text. This will default to the grey form colour
$labelUser.BackColor = "Transparent"

$labelUser.AutoSize = $true
# Adds the text object to the form
$form.Controls.Add($labelUser)
#endregion User label

#endregion Label Text Setup

#region Text Boxes Setup

#region Service Tag Text Box
# Create text box object
$textBoxServiceTag = New-Object System.Windows.Forms.TextBox

# Set location and size
$textBoxServiceTag.Location = New-Object System.Drawing.Point(($labelServiceTag.Location.X + 160),$labelServiceTag.Location.Y)
$textBoxServiceTag.Size = New-Object System.Drawing.Size(160, 20)
# Add text box to form
$form.Controls.Add($textBoxServiceTag)
#endregion Service text box

#region IP Text Box
# Create text box object
$textBoxIP = New-Object System.Windows.Forms.TextBox

# Set location and size
$textBoxIP.Location = New-Object System.Drawing.Point(($labelIP.Location.X + 160),$labelIP.Location.Y)
$textBoxIP.Size = New-Object System.Drawing.Size(160, 20)
# Add text box to form
$form.Controls.Add($textBoxIP)
#endregion Service text box

#endregion Text Boxes Setup

#region Button Setup

#region Service Tag Button
# Creates a button object
$buttonServiceTag = New-Object System.Windows.Forms.Button
# Sets location for button
$buttonServiceTag.location = New-Object System.Drawing.Point(($textboxServiceTag.Location.X + 165),$textboxServiceTag.Location.Y)
# Set size of button
$buttonServiceTag.Size = New-Object System.Drawing.Size(100, 25)
# Set text inside button
$buttonServiceTag.Text = "Search"
# Set the button's function
#region Function Help
# Method 1, directly though a cmdlet: $button.Add_Click({Get-Process | Out-GridView})
# Method 2, calling a script file:
<#
$button.Add_Click(
{
    Invoke-Expression -Command "J:\a-norton.leigh\Desktop\Powershell\Scripts\PowershellcompJun.ps1"
}
)
#>
# Method 3, using a function name by converting script to function
<#
function service
{
    Get-Service | select DisplayName, Status | Out-GridView
}
$button.Add_Click({service})
#>
#endregion Function Help

$buttonServiceTag.Add_Click({serviceTagPopUp})

# Add button to form
$form.Controls.Add($buttonServiceTag)

#endregion Service Tag Button

#region IP Button
# Creates a button object
$buttonIP = New-Object System.Windows.Forms.Button
# Sets location for button
$buttonIP.location = New-Object System.Drawing.Point(($textBoxIP.Location.X + 165),$textBoxIP.Location.Y)
# Set size of button
$buttonIP.Size = New-Object System.Drawing.Size(100, 25)
# Set text inside button
$buttonIP.Text = "Search"
# Set the button's function
#region Function Help
# Method 1, directly though a cmdlet: $button.Add_Click({Get-Process | Out-GridView})
# Method 2, calling a script file:
<#
$button.Add_Click(
{
    Invoke-Expression -Command "J:\a-norton.leigh\Desktop\Powershell\Scripts\PowershellcompJun.ps1"
}
)
#>
# Method 3, using a function name by converting script to function
<#
function service
{
    Get-Service | select DisplayName, Status | Out-GridView
}
$button.Add_Click({service})
#>
#endregion Function Help

$buttonIP.Add_Click({ipPopUp})

# Add button to form
$form.Controls.Add($buttonIP)

#endregion IP Button

#region User Button
# Creates a button object
$buttonUser = New-Object System.Windows.Forms.Button
# Sets location for button
$buttonUser.location = New-Object System.Drawing.Point($buttonIP.Location.X, ($buttonIP.Location.Y + 40))
# Set size of button
$buttonUser.Size = New-Object System.Drawing.Size(100, 25)
# Set text inside button
$buttonUser.Text = "Go"
# Set the button's function
#region Function Help
# Method 1, directly though a cmdlet: $button.Add_Click({Get-Process | Out-GridView})
# Method 2, calling a script file:
<#
$button.Add_Click(
{
    Invoke-Expression -Command "J:\a-norton.leigh\Desktop\Powershell\Scripts\PowershellcompJun.ps1"
}
)
#>
# Method 3, using a function name by converting script to function
<#
function service
{
    Get-Service | select DisplayName, Status | Out-GridView
}
$button.Add_Click({service})
#>
#endregion Function Help

$buttonUser.Add_Click({userForm})

# Add button to form
$form.Controls.Add($buttonUser)

#endregion User Button

#endregion Button Setup

function serviceTagPopUp
{
    # Pop up after searching BY service tag that informs the user of the IP address
    # New form for pop up
    $formServiceTag = New-Object System.Windows.Forms.Form
    # Adds a title to the form with given Service Tag. -replace ".*:" removes everything up to and including the : symbol
    $usersTag = $textBoxServiceTag.ToString() -replace ".*:"
    $formServiceTag.Text = "IP for Service Tag $usersTag"
    # Set icon for form using Parent form icon
    $formServiceTag.Icon = $icon
    #Set font to same overall font from main form
    $formServiceTag.Font = $font
    # Set form size
    #Enable AutoSize, Auto fits to controls placed in form but does NOT allow user resizing
    $formServiceTag.AutoSize = $true
    $formServiceTag.AutosizeMode = "GrowAndShrink"
    # These settings disable the Maximise and Minimise buttons
    $formServiceTag.MinimizeBox = $false
    $formServiceTag.MaximizeBox = $false
    # This option sets how the form starts. Options for this are "Maximized", "Minimized" or "Normal"
    $formServiceTag.WindowState = "Normal"
    # This option sets the visibility of the Resize grip. Options for this are "Auto", "Hide" or "Show"
    $formServiceTag.SizeGripStyle = "Hide"
    # This option decides if the form will show as an icon in the task bar
    $formServiceTag.ShowInTaskbar = $false
    # This option sets the position of the form when it first opens. This can be set to "CenterScreen", "Manual", 
    # "WindowsDefaultLocation", "WindowsDefaultBounds" or "CenterParent"
    $formServiceTag.StartPosition = "CenterScreen"

    # Label for pop up form
    $labelPopUp = New-Object System.Windows.Forms.Label
    $labelLastUser = New-Object System.Windows.Forms.Label
    $labelLastUser.location = New-Object System.Drawing.Point(0, ($labelPopUp.Location.Y + 30))
    
    $usersIP = Invoke-Command -ComputerName $textBoxServiceTag.Text -ScriptBlock{ipconfig | Select-String IPv4}
    $usersIP = $usersIP.toString() -replace ".*:"

    $lastUser = (Get-WmiObject -Class win32_process -ComputerName $textBoxServiceTag.Text | Where-Object name -Match explorer).getowner().user

    $labelPopUp.Text = "The IP for$usersTag is$usersIP"
    $labelLastUser.Text = "Last Known User: $lastUser"

    $labelPopUp.BackColor = "Transparent"
    $labelPopUp.AutoSize = $true
    $formServiceTag.Controls.Add($labelPopUp)

    $labelLastUser.BackColor = "Transparent"
    $labelLastUser.AutoSize = $true
    $formServiceTag.Controls.Add($labelLastUser)


    $formServiceTag.ShowDialog()
}

function ipPopUp
{
    # Pop up after searching BY IP that informs the user of the Service Tag
    # New form for pop up
    $formIP = New-Object System.Windows.Forms.Form

    #$testIP = $textBoxIP.ToString() -replace ".*:" #removes everything up to and including :
    #$testIP = $testIP.TrimStart(" ") #removes the space at the start left over after the -replace

    # Adds a title to the form with given Service Tag. -replace ".*:" removes everything up to and including the : symbol
    $usersIP = $textBoxIP.ToString() -replace ".*:"
    $usersIP = $usersIP.TrimStart(" ")
    $formIP.Text = "Service Tag for IP $usersIP"
    # Set icon for form using Parent form icon
    $formIP.Icon = $icon
    #Set font to same overall font from main form
    $formIP.Font = $font
    # Set form size
    #Enable AutoSize, Auto fits to controls placed in form but does NOT allow user resizing
    $formIP.AutoSize = $true
    $formIP.AutosizeMode = "GrowAndShrink"
    # These settings disable the Maximise and Minimise buttons
    $formIP.MinimizeBox = $false
    $formIP.MaximizeBox = $false
    # This option sets how the form starts. Options for this are "Maximized", "Minimized" or "Normal"
    $formIP.WindowState = "Normal"
    # This option sets the visibility of the Resize grip. Options for this are "Auto", "Hide" or "Show"
    $formIP.SizeGripStyle = "Hide"
    # This option decides if the form will show as an icon in the task bar
    $formIP.ShowInTaskbar = $false
    # This option sets the position of the form when it first opens. This can be set to "CenterScreen", "Manual", 
    # "WindowsDefaultLocation", "WindowsDefaultBounds" or "CenterParent"
    $formIP.StartPosition = "CenterScreen"

    # Label for pop up form
    $labelPopUp = New-Object System.Windows.Forms.Label
    $labelLastUser = New-Object System.Windows.Forms.Label
    $labelLastUSer.location = New-Object System.Drawing.Point(0, ($labelPopUp.Location.Y + 30))
    
    $usersTag = ([System.Net.Dns]::GetHostByAddress($usersIP).HostName)
    #$testbool = [bool]($testIP -as [ipaddress]) #Tests if a given string is in an IP format
    $usersTag = $usersTag.ToString() -replace "(.wlcorporate.westlothian.gov.uk)" # removes the standard phrase after a service tag
    
    $lastUser = (Get-WmiObject -Class win32_process -ComputerName $textBoxIP.Text | Where-Object name -Match explorer).getowner().user

    $labelPopUp.Text = "The Service Tag for$usersIP is $usersTag"
    $labelLastUser.Text = "Last Known User: $lastUser"

    $labelPopUp.BackColor = "Transparent"
    $labelPopUp.AutoSize = $true
    $formIP.Controls.Add($labelPopUp)

    $labelLastUser.BackColor = "Transparent"
    $labelLastUser.AutoSize = $true
    $formIP.Controls.Add($labelLastUser)

    $formIP.ShowDialog()

}

function userForm
{
    $formUser = New-Object System.Windows.Forms.Form

    $formUser.Text = "User Information"
    # Set icon for form using Parent form icon
    $formUser.Icon = $icon
    #Set font to same overall font from main form
    $formUser.Font = $font
    # Set form size
    #Enable AutoSize, Auto fits to controls placed in form but does NOT allow user resizing
    $formUser.AutoSize = $true
    $formUser.AutosizeMode = "GrowAndShrink"
    # These settings disable the Maximise and Minimise buttons
    $formUser.MinimizeBox = $false
    $formUser.MaximizeBox = $false
    # This option sets how the form starts. Options for this are "Maximized", "Minimized" or "Normal"
    $formUser.WindowState = "Normal"
    # This option sets the visibility of the Resize grip. Options for this are "Auto", "Hide" or "Show"
    $formUser.SizeGripStyle = "Hide"
    # This option decides if the form will show as an icon in the task bar
    $formUser.ShowInTaskbar = $true
    # This option sets the position of the form when it first opens. This can be set to "CenterScreen", "Manual", 
    # "WindowsDefaultLocation", "WindowsDefaultBounds" or "CenterParent"
    $formUser.StartPosition = "CenterScreen"

    #region UserForm Labels
    #region Header Label
    $labelUserHeader = New-Object System.Windows.Forms.Label
    $labelUserHeader.Text = "Please enter the name of the user:"
    $labelUserHeader.BackColor = "Transparent"
    $labelUserHeader.AutoSize = $true
    $formUser.Controls.Add($labelUserHeader)
    #endregion Header Label

    #region Username Label
    $labelUserName = New-Object System.Windows.Forms.Label
    $labelUserName.Text = "Username:"
    $labelUserName.Location = New-Object System.Drawing.Point(0, ($labelUserHeader.Location.Y + 50))
    $labelUserName.BackColor = "Transparent"
    $labelUserName.AutoSize = $true
    $formUser.Controls.Add($labelUserName)
    #endregion Username Label

    #region Account Locked Label
    $labelAccountLocked = New-Object System.Windows.Forms.Label
    $labelAccountLocked.Text = "Account Locked:"
    $labelAccountLocked.Location = New-Object System.Drawing.Point(0, ($labelUserName.Location.Y + 20))
    $labelAccountLocked.BackColor = "Transparent"
    $labelAccountLocked.AutoSize = $true
    $formUser.Controls.Add($labelAccountLocked)
    #endregion Account Locked Label

    #region Account Disabled Label
    $labelAccountDisabled = New-Object System.Windows.Forms.Label
    $labelAccountDisabled.Text = "Account Disabled:"
    $labelAccountDisabled.Location = New-Object System.Drawing.Point(0, ($labelAccountLocked.Location.Y + 20))
    $labelAccountDisabled.BackColor = "Transparent"
    $labelAccountDisabled.AutoSize = $true
    $formUser.Controls.Add($labelAccountDisabled)
    #endregion Account Disabled Label

    #region Account Location Label
    $labelAccountLocation = New-Object System.Windows.Forms.Label
    $labelAccountLocation.Text = "Account Location (wlcorporate.westlothian.gov.uk/):"
    $labelAccountLocation.Location = New-Object System.Drawing.Point(0, ($labelAccountDisabled.Location.Y + 20))
    $labelAccountLocation.BackColor = "Transparent"
    $labelAccountLocation.AutoSize = $true
    $formUser.Controls.Add($labelAccountLocation)
    #endregion Account Location Label

    #region Password Last Set Label
    $labelPasswordLastSet = New-Object System.Windows.Forms.Label
    $labelPasswordLastSet.Text = "Password Last Set:"
    $labelPasswordLastSet.Location = New-Object System.Drawing.Point(0, ($labelAccountLocation.Location.Y + 20))
    $labelPasswordLastSet.BackColor = "Transparent"
    $labelPasswordLastSet.AutoSize = $true
    $formUser.Controls.Add($labelPasswordLastSet)
    #endregion Password Last Set Label

    #region Password Expired Label
    $labelPasswordExpired = New-Object System.Windows.Forms.Label
    $labelPasswordExpired.Text = "Password Expired:"
    $labelPasswordExpired.Location = New-Object System.Drawing.Point(0, ($labelPasswordLastSet.Location.Y + 20))
    $labelPasswordExpired.BackColor = "Transparent"
    $labelPasswordExpired.AutoSize = $true
    $formUser.Controls.Add($labelPasswordExpired)
    #endregion Password Expired Label

    #region Bad Password Label
    $labelBadPassword = New-Object System.Windows.Forms.Label
    $labelBadPassword.Text = "Bad Password Attempts:"
    $labelBadPassword.Location = New-Object System.Drawing.Point(0, ($labelPasswordExpired.Location.Y + 20))
    $labelBadPassword.BackColor = "Transparent"
    $labelBadPassword.AutoSize = $true
    $formUser.Controls.Add($labelBadPassword)
    #endregion Bad Password Label


    #endregion UserForm Labels

    $textBoxUser = New-Object System.Windows.Forms.TextBox

    $textBoxUser.Location = New-Object System.Drawing.Point(($labelUserHeader.Location.X + 240),$labelUserHeader.Location.Y)
    $textBoxUser.Size = New-Object System.Drawing.Size(160, 20)
    # Add text box to form
    $formUser.Controls.Add($textBoxUser)


    # Creates a button object
    $buttonUser = New-Object System.Windows.Forms.Button
    # Sets location for button
    $buttonUser.location = New-Object System.Drawing.Point(($textBoxUser.Location.X + 170),$textBoxUser.Location.Y)
    # Set size of button
    $buttonUser.Size = New-Object System.Drawing.Size(100, 25)
    # Set text inside button
    $buttonUser.Text = "Go"
    # Set the button's function


    #region Answer Labels
    #region Username Answer Label
    $labelUserNameAnswer = New-Object System.Windows.Forms.Label
    $labelUserNameAnswer.Text = "ANSWER"
    $labelUserNameAnswer.Location = New-Object System.Drawing.Point($formUser.Width, $labelUserName.Location.Y)
    $labelUserNameAnswer.BackColor = "Transparent"
    $labelUserNameAnswer.AutoSize = $true
    $formUser.Controls.Add($labelUserNameAnswer)
    #endregion Username Answer Label

    #region Account Locked Answer Label
    $labelAccountLockedAnswer = New-Object System.Windows.Forms.Label
    $labelAccountLockedAnswer.Text = "ANSWER2"
    $labelAccountLockedAnswer.Location = New-Object System.Drawing.Point($labelUserNameAnswer.Location.X, $labelAccountLocked.Location.Y)
    $labelAccountLockedAnswer.BackColor = "Transparent"
    $labelAccountLockedAnswer.AutoSize = $true
    $formUser.Controls.Add($labelAccountLockedAnswer)
    #endregion Account Locked Answer Label

    #region Account Disabled Answer Label
    $labelAccountDisabledAnswer = New-Object System.Windows.Forms.Label
    $labelAccountDisabledAnswer.Text = "ANSWER3"
    $labelAccountDisabledAnswer.Location = New-Object System.Drawing.Point($labelAccountLockedAnswer.Location.X, $labelAccountDisabled.Location.Y)
    $labelAccountDisabledAnswer.BackColor = "Transparent"
    $labelAccountDisabledAnswer.AutoSize = $true
    $formUser.Controls.Add($labelAccountDisabledAnswer)
    #endregion Account Disabled Answer Label

    #region Account Location Answer Label
    $labelAccountLocationAnswer = New-Object System.Windows.Forms.Label
    $labelAccountLocationAnswer.Text = "ANSWER4"
    $labelAccountLocationAnswer.Location = New-Object System.Drawing.Point($labelAccountLockedAnswer.Location.X, $labelAccountLocation.Location.Y)
    $labelAccountLocationAnswer.BackColor = "Transparent"
    $labelAccountLocationAnswer.AutoSize = $true
    $formUser.Controls.Add($labelAccountLocationAnswer)
    #endregion Account Location Answer Label

    #region Password Last Set Answer Label
    $labelPasswordLastSetAnswer = New-Object System.Windows.Forms.Label
    $labelPasswordLastSetAnswer.Text = "ANSWER5"
    $labelPasswordLastSetAnswer.Location = New-Object System.Drawing.Point($labelAccountLockedAnswer.Location.X, $labelPasswordLastSet.Location.Y)
    $labelPasswordLastSetAnswer.BackColor = "Transparent"
    $labelPasswordLastSetAnswer.AutoSize = $true
    $formUser.Controls.Add($labelPasswordLastSetAnswer)
    #endregion Password Last Set Answer Label

    #region Password Expired Answer Label
    $labelPasswordExpiredAnswer = New-Object System.Windows.Forms.Label
    $labelPasswordExpiredAnswer.Text = "ANSWER6"
    $labelPasswordExpiredAnswer.Location = New-Object System.Drawing.Point($labelAccountLockedAnswer.Location.X, $labelPasswordExpired.Location.Y)
    $labelPasswordExpiredAnswer.BackColor = "Transparent"
    $labelPasswordExpiredAnswer.AutoSize = $true
    $formUser.Controls.Add($labelPasswordExpiredAnswer)
    #endregion Password Expired Answer Label

    #region Bad Password Answer Label
    $labelBadPasswordAnswer = New-Object System.Windows.Forms.Label
    $labelBadPasswordAnswer.Text = "ANSWER7"
    $labelBadPasswordAnswer.Location = New-Object System.Drawing.Point($labelAccountLockedAnswer.Location.X, $labelBadPassword.Location.Y)
    $labelBadPasswordAnswer.BackColor = "Transparent"
    $labelBadPasswordAnswer.AutoSize = $true
    $formUser.Controls.Add($labelBadPasswordAnswer)
    #endregion Bad Password Answer Label
    #endregion Answer Labels

    # On clicking, take the entered name and fill out the below details
    $buttonUser.Add_Click(
    {
        $ADUser = $textBoxUser.Text
        # Answer for Use Name
        $labelUserNameAnswer.text = Get-ADUser $ADUser -Properties CN | Select-Object -ExpandProperty CN
        # Answer for Locked
        #region Locked
        $labelAccountLockedAnswer.text = Get-ADUser $ADUser -Properties LockedOut | Select-Object -ExpandProperty LockedOut
        if ($labelAccountLockedAnswer.text -eq "False")
        {
            $labelAccountLockedAnswer.ForeColor = "green"
        }
        else 
        {
            $labelAccountLockedAnswer.ForeColor = "red"
        }
        #endregion Locked
        # Answer for Disabled
        #region Disabled
        $labelAccountDisabledAnswer.text = Get-ADUser $ADUser -Properties Enabled | Select-Object -ExpandProperty Enabled
        if ($labelAccountDisabledAnswer.text -eq "True")
        {
            $labelAccountDisabledAnswer.ForeColor = "green"
        }
        else
        {
            $labelAccountDisabledAnswer.ForeColor = "red"
        }
        #regionend Disabled
        # Answer for Location
        $labelAccountLocationAnswer.text = Get-ADUser $ADUser -Properties CanonicalName | Select-Object -ExpandProperty CanonicalName
        $labelAccountLocationAnswer.text =  $labelAccountLocationAnswer.toString() -replace ".*uk"
     
    }
    )

    # Add button to form
    $formUser.Controls.Add($buttonUser)
    

    $formUser.ShowDialog()
}

# Show form
$form.ShowDialog()