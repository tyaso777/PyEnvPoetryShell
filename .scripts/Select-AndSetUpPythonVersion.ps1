<#
.SYNOPSIS
This script contains the function Select-AndSetUpPythonVersion, which allows users to select a Python version to install and set up using pyenv.

.DESCRIPTION
Select-AndSetUpPythonVersion displays a list of installed and available Python versions. The user can select a version to install and set as the local Python environment. If a version is already installed, it will be skipped.

.EXAMPLE
To use the Select-AndSetUpPythonVersion function in your script, follow these steps:

1. Import this script to make the function available:
   . "$PSScriptRoot\.scripts\Select-AndSetupPythonVersion.ps1"

2. Call the function and check the result:
   $result = Select-AndSetUpPythonVersion

3. If no version was selected, you can choose to exit your script:
   if (-not $result) {
       Write-Host "Exiting the main script as no Python version was selected."
       exit
   }

   You can then continue with the rest of your script after this check.
#>

function Select-AndSetUpPythonVersion {
    try {
        # Get installed Python versions
        $installedVersions = pyenv versions --bare

        # Get available Python versions
        $availableVersions = pyenv install --list
        if ($availableVersions -isnot [Array]) {
            $availableVersions = @($availableVersions)
        }
        $availableVersions[0] = "— Below is a list of all available Python versions. Installation via pyenv's python install is required. —"

        # Combine the lists and pass to Out-GridView
        $combinedList = $installedVersions + $availableVersions

        # Display a popup for the user to select a Python version
        $selectedVersion = $combinedList | Out-GridView -PassThru -Title "Select a Python version to apply"

        # Check if a version was selected
        if ([string]::IsNullOrEmpty($selectedVersion)) {
            Write-Host "No Python version was selected."
            return $false
        }

        # Install the selected version, skipping if it's already installed
        pyenv install $selectedVersion --skip-existing

        # Execute pyenv local for the selected version
        pyenv local $selectedVersion
        Write-Host "The pyenv local has been set with the selected Python version ($selectedVersion)."

        # Return true if everything was successful
        return $true
    }
    catch {
        Write-Host "An error occurred: $_"
        return $false
    }
}

