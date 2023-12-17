function Show-MessageBox {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message,

        [string]$Title = "Information"
    )

    Add-Type -AssemblyName System.Windows.Forms
    $form = New-Object System.Windows.Forms.Form
    $form.TopMost = $true
    [System.Windows.Forms.MessageBox]::Show($form, $Message, $Title)
}

# how to use
# $message = "Please select a new Project Folder in the upcoming dialog."
# $title = "Select Folder"
# Show-MessageBox -Message $message -Title $title
