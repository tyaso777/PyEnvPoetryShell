function Create-VSCodeWorkspace {
    param (
        [Parameter(Mandatory=$true)]
        [string]$folderPath,

        [string]$pythonPath,

        [string]$workspaceFileName = "workspace.code-workspace"
    )

    # Construct the full path for the workspace file
    $workspaceFilePath = Join-Path $folderPath $workspaceFileName

    $dmypyPath = Join-Path -Path $pythonPath -ChildPath "Scripts\dmypy.exe"

    # Define the content of the workspace file
    $workspaceContent = @{
        folders = @(
            @{
                path = "."
            }
        )
        settings = @{
            # "mypy.dmypyExecutable" = $dmypyPath
            "mypy.runUsingActiveInterpreter" = $true
            "python.analysis.typeCheckingMode" = "basic" # Enable basic mypy type checking
            "[python]" = @{
                "editor.defaultFormatter" = "ms-python.black-formatter"
                "editor.formatOnSave" = $true
                "editor.codeActionsOnSave" = @{
                    "source.organizeImports" = $true
                }
            }
            "isort.args" = @("--profile", "black")
            "terminal.integrated.env.windows" = @{
                "PYTHONPATH" = "`${workspaceFolder}"
            }
            "terminal.integrated.env.linux" = @{
                "PYTHONPATH" = "`${workspaceFolder}"
            }
            "terminal.integrated.env.osx" = @{
                "PYTHONPATH" = "`${workspaceFolder}"
            }
            "jupyter.notebookFileRoot" = "`${workspaceFolder}"
            # Add more settings as needed
        }
    }

    # Convert the content to JSON with a specified depth to properly format nested structures
    $jsonContent = $workspaceContent | ConvertTo-Json -Depth 5 | Out-String

    # Write the JSON content to the workspace file
    $jsonContent | Out-File -FilePath $workspaceFilePath -Force

    # Write the JSON content to the workspace file with UTF8 encoding
    [System.IO.File]::WriteAllText($workspaceFilePath, $jsonContent, [System.Text.Encoding]::UTF8)


    # Open the workspace in VSCode
    code $workspaceFilePath
}

# Example Usage:
# Create-VSCodeWorkspace -folderPath "C:\path\to\your\workspace"
