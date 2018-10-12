#region Initial Setup
# Add Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create form object
$form = New-Object System.Windows.Forms.Form

# Adds a title to the form
$form.Text = "Form Test"

# Create an image object
$image = [System.Drawing.Image]::FromFile("$($env:PUBLIC)\Pictures\Sample Pictures\Oryx Antelope.jpg")

# Set background image
$form.BackgroundImage = $image

# Set layout for image. This can be set to "None", "Tile", "Centre", "Stretch" or "Zoom"
$form.BackgroundImageLayout = "None"

# Set icon for form
# From icon file
$icon = New-Object system.drawing.icon("C:\Program Files (x86)\Microsoft Office\Office14\GRAPH.ICO")
# Or from an associated file
$icon = [System.Drawing.Icon]::ExtractAssociatedIcon($PSHOME+"\powershell.exe")
$form.Icon = $icon

<# Window Settings

# Form sizing options
# Specify a size, allows user to resize form
$form.Width = 500
$form.Height = 200

#Enable scroll bars on form, allows user to resize form
$form.AutoScroll = $true

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
$form.ShowInTaskbar = $false

# Opacity settings, 1.0 is fully opaque, 0.0 is invisible
$form.Opacity = 0.7

# This option sets the position of the form when it first opens. This can be set to "CenterScreen", "Manual", 
# "WindowsDefaultLocation", "WindowsDefaultBounds" or "CenterParent"
$form.StartPosition = "CenterScreen"

# Changes background colour of form
# Colour names are static properties of System.Drawing.Color
# Can use ARGB values eg. #FFFFEBCD
$form.BackColor = "Lime"
#>

# Set form size
# Specify a size, allows user to resize form
$form.Width = $image.Width
$form.Height = $image.Height
#endregion

#region Label Text Setup
# Creates a font to be used for text
# Format: System.Drawing.Font(Font, Size, [System.Drawing.FontStyle]::Style)
# Styles available: Regular, Bold, Italic, Underline, Strikeout
$font = New-Object System.Drawing.Font("Times New Roman", 18, [System.Drawing.FontStyle]::Italic)

# Tells the form to use a specified font
$form.Font = $font

# Adds text to the body of the form
# Creates text object
$label = New-Object System.Windows.Forms.Label
$label.Text = "This is the label text"

# Set colour of background behind text. This will default to the grey form colour
$label.BackColor = "Transparent"

$label.AutoSize = $true
# Adds the text object to the form
$form.Controls.Add($label)
#endregion


#region Button setup
# Creates a button object
$button = New-Object System.Windows.Forms.Button
# Sets location for button
$button.location = New-Object System.Drawing.Size(140, 80)
# Set size of button
$button.Size = New-Object System.Drawing.Size(100, 30)
# Set text inside button
$button.Text = "OK"
# Set the button's function
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


$button.Add_Click({$form.Close()})
# Add button to form
$form.Controls.Add($button)
#endregion


# Show form
$form.ShowDialog()