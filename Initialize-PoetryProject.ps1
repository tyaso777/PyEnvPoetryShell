# Import Select-Folder.ps1 (dot-sourcing)
. "$PSScriptRoot\.scripts\Select-Folder.ps1"
. "$PSScriptRoot\.scripts\Select-AndSetupPythonVersion.ps1"
. "$PSScriptRoot\.scripts\Create-VSCodeWorkspace.ps1"
. "$PSScriptRoot\.scripts\Show-MessageBox.ps1"

# Main logic

{
    $message = "Please select a new Project Folder in the upcoming dialog."
    $title = "Select Folder"
    Show-MessageBox -Message $message -Title $title
}

Show-MessageBox -Message "Please select a new Project Folder in the upcoming dialog." -Title "Select Folder"

$selectedFolderPath = Select-Folder -Message "Select Folder" 
if ($selectedFolderPath -eq $null) {
    Write-Host Write-Host "Folder selection was cancelled. The process will be terminated."
    return
}

$selectedFolderName = (Split-Path $selectedFolderPath -Leaf)

# Continue with the main logic from here
Write-Host "Selected folder: $selectedFolderPath"

# Set up Proxy, etc.

# PowerShell defaults to UTF-16 encoding, while Poetry expects UTF-8.
# To prevent encoding issues, explicitly set UTF-8 encoding before running Poetry commands.
$env:PYTHONUTF8=1

# Move to the project folder
cd $selectedFolderPath

# Configure pyenv
if (-not (Select-AndSetUpPythonVersion)) {
    Write-Host "Exiting the main script as no Python version was selected."
    exit
}

# Setting up poetry
poetry new $selectedFolderName

# Move into the poetry folder
cd $selectedFolderName

# Add basic packages with Poetry
poetry add notebook ipykernel black flake8 mypy isort --group dev

# Get the path of the virtual environment created by Poetry
$poetryEnvPath = poetry env info -p

# create workspace in VSCode
Create-VSCodeWorkspace -folderPath $selectedFolderPath -pythonPath $poetryEnvPath

# Show a message box to the user instructing them to manually set the Python interpreter in VSCode
$message = "Please set the Python interpreter in vscode using path written in the log."
$title = "Set Python Interpreter"
Show-MessageBox -Message $message -Title $title

# Output the Python interpreter path to the console for the user's reference
Write-Host ("the Python interpreter to the path: " + ($poetryEnvPath + "\Scripts"))

