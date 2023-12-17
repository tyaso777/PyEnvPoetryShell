@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Display a message to the user
echo Please select the PowerShell script to execute from the following dialog.

:: Execute a PowerShell script to obtain the file path
FOR /F "delims=" %%I IN ('powershell -ExecutionPolicy RemoteSigned -File ".\.scripts\Select-PsScript.ps1"') DO (
    SET FILEPATH=%%I
)

:: Use the selected file path to execute a PowerShell script
IF NOT "!FILEPATH!"=="" (
    powershell -NoExit -ExecutionPolicy RemoteSigned -File "!FILEPATH!"
) ELSE (
    echo No file selected.
)

pause
ENDLOCAL
