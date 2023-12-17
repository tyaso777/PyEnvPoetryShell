# Import Select-Folder.ps1 (dot-sourcing)
. "$PSScriptRoot\.scripts\Select-Folder.ps1"
. "$PSScriptRoot\.scripts\Show-MessageBox.ps1"
. "$PSScriptRoot\.scripts\Set-AuthenticationProxyIfRequired.ps1"

# Main logic
Show-MessageBox `
    -Message "In the next dialog, please select the Project Folder containing 'pyproject.toml'." `
    -Title "Select Folder"

$selectedFolderPath = Select-Folder -Message "Select Folder" 
if ($selectedFolderPath -eq $null) {
    Write-Host Write-Host "Folder selection was cancelled. The process will be terminated."
    exit
}

# Construct the path to 'pyproject.toml' within the selected folder
$pyProjectPath = Join-Path -Path $selectedFolderPath -ChildPath "pyproject.toml"

# Check if the 'pyproject.toml' file exists in the selected folder
if (-Not (Test-Path -Path $pyProjectPath)) {
    # Message to display if the file is not found
    Write-Host "The file 'pyproject.toml' was not found in the selected folder. Please select a valid Poetry project folder."
    # Exit the script if the file does not exist
    exit
}

# Continue with the main logic from here
Write-Host "Selected folder: $selectedFolderPath"

# Set up Proxy, etc.
if (-not (Set-AuthenticationProxyIfRequired)) {
    Write-Host "Failed to set up the proxy."
    exit
}

# PowerShell defaults to UTF-16 encoding, while Poetry expects UTF-8.
# To prevent encoding issues, explicitly set UTF-8 encoding before running Poetry commands.
$env:PYTHONUTF8=1

Write-Host "Please execute your desired Poetry command."
