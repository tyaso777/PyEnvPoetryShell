function Select-Folder {
    param (
        [string]$Message = "Select Folder"
    )
    Add-Type -AssemblyName System.Windows.Forms

    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop")
    $openFileDialog.Filter = "Folders|\n"
    $openFileDialog.AddExtension = $false
    $openFileDialog.CheckFileExists = $false
    $openFileDialog.CheckPathExists = $true
    $openFileDialog.Multiselect = $false
    $openFileDialog.ValidateNames = $false
    $openFileDialog.FileName = $Message

    $result = $openFileDialog.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return [System.IO.Path]::GetDirectoryName($openFileDialog.FileName)
    } else {
        return $null
    }
}
