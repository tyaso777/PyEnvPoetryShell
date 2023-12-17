# 必要なアセンブリを読み込む
Add-Type -AssemblyName System.Windows.Forms

# スクリプト自身のディレクトリを取得
$scriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# 更にその親ディレクトリを取得
$parentDirectory = Split-Path -Parent -Path $scriptPath

# OpenFileDialogのインスタンスを作成
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog

# ファイルの種類をフィルター
$openFileDialog.Filter = "PowerShell Scripts (*.ps1)|*.ps1"

# スクリプトの格納ディレクトリの親ディレクトリを初期ディレクトリとして設定
$openFileDialog.InitialDirectory = $parentDirectory

# ダイアログを表示
$result = $openFileDialog.ShowDialog()

# ユーザーが「OK」を選択した場合、選択したファイルのパスを出力
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $openFileDialog.FileName
}
else
{
    # ユーザーがキャンセルした場合、何も出力しない
}
