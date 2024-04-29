# Import Select-Folder.ps1 (dot-sourcing)
. "$PSScriptRoot\.scripts\Select-Folder.ps1"
. "$PSScriptRoot\.scripts\Select-AndSetupPythonVersion.ps1"
. "$PSScriptRoot\.scripts\Create-VSCodeWorkspace.ps1"
. "$PSScriptRoot\.scripts\Show-MessageBox.ps1"
. "$PSScriptRoot\.scripts\Set-AuthenticationProxyIfRequired.ps1"

# Main logic

Show-MessageBox `
    -Message "Please select a new Project Folder in the upcoming dialog." `
    -Title "Select Folder"

$selectedFolderPath = Select-Folder -Message "Select Folder" 
if ($selectedFolderPath -eq $null) {
    Write-Host Write-Host "Folder selection was cancelled. The process will be terminated."
    exit
}

$selectedFolderName = (Split-Path $selectedFolderPath -Leaf)

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

# Move to the project folder
cd $selectedFolderPath

# Configure pyenv
if (-not (Select-AndSetUpPythonVersion)) {
    Write-Host "Exiting the main script as no Python version was selected."
    exit
}

# Initialize a new poetry project without interaction to create pyproject.toml
poetry init --no-interaction

# Create the main project folder
$projectFolderPath = Join-Path -Path . -ChildPath $selectedFolderName
New-Item -Path $projectFolderPath -ItemType "directory"

# Create the __init__.py file in the project folder
$initFilePath = Join-Path -Path $projectFolderPath -ChildPath "__init__.py"
New-Item -Path $initFilePath -ItemType "file"

# Create the main script file in the project folder
$mainScriptPath = Join-Path -Path $projectFolderPath -ChildPath "${selectedFolderName}.py"
New-Item -Path $mainScriptPath -ItemType "file"

# Create the tests folder at the project root
$testsFolderPath = Join-Path -Path . -ChildPath "tests"
New-Item -Path $testsFolderPath -ItemType "directory"

# Create a subfolder within the tests folder corresponding to the project
$testProjectFolderPath = Join-Path -Path $testsFolderPath -ChildPath $selectedFolderName
New-Item -Path $testProjectFolderPath -ItemType "directory"

# Create an __init__.py file in the tests subfolder
$testInitFilePath = Join-Path -Path $testProjectFolderPath -ChildPath "__init__.py"
New-Item -Path $testInitFilePath -ItemType "file"

# Add basic packages with Poetry
poetry add notebook ipykernel black flake8 mypy isort --group dev

# Get the path of the virtual environment created by Poetry
$poetryEnvPath = poetry env info -p

# create workspace in VSCode
Create-VSCodeWorkspace -folderPath $selectedFolderPath -pythonPath $poetryEnvPath

# Show a message box to the user instructing them to manually set the Python interpreter in VSCode
# $message = "Please set the Python interpreter in vscode using path written in the log."
# $title = "Set Python Interpreter"
Show-MessageBox `
    -Message "Please set the Python interpreter in vscode using path written in the log." `
    -Title "Set Python Interpreter"

# Output the Python interpreter path to the console for the user's reference
Write-Host ("ctrl+shift+p in vscode => enter 'Python Select Interpreter' => Enter the path")
Write-Host ("the Python interpreter to the path: `n" + ($poetryEnvPath + "\Scripts\python.exe"))
