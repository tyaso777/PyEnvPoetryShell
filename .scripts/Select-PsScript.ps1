# Load the necessary assembly
Add-Type -AssemblyName System.Windows.Forms

# Get the script's directory
$scriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Get the parent directory of the script
$parentDirectory = Split-Path -Parent -Path $scriptPath

# Create an instance of OpenFileDialog
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog

# Filter file types
$openFileDialog.Filter = "PowerShell Scripts (*.ps1)|*.ps1"

# Set the initial directory to the parent directory of the script's storage
$openFileDialog.InitialDirectory = $parentDirectory

# Display the dialog
$result = $openFileDialog.ShowDialog()

# If the user selects "OK," output the selected file path
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    return $openFileDialog.FileName
}
else {
    return $null # If the user cancels, output nothing
}
