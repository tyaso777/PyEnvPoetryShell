function Set-AuthenticationProxyIfRequired {
    # Check the current system proxy settings
    $proxyInfo = netsh winhttp show proxy
    $regexPattern = 'Proxy Server\(s\) : +|プロキシ サーバー: +'
    $matchResult = $proxyInfo -match $regexPattern
    $proxyAddress = ($matchResult -join "" -replace $regexPattern, '').Trim()

    # If a proxy address exists, set up the authentication details
    if ($proxyAddress) {
        try {
            # Prompt the user to enter proxy username and password
            $proxyUser = Read-Host -Prompt "Enter your proxy username"
            $password = Read-Host -Prompt "Enter your proxy password" -AsSecureString
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
            $proxyPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

            # Construct the proxy address with authentication information
            $proxyAddressWithAuthentication = "http://$($proxyUser):$($proxyPassword)@$($proxyAddress)"

            # Apply the proxy settings to environment variables for HTTP, HTTPS, and FTP
            # These environment variables affect other applications and processes during the script execution
            $env:http_proxy = $proxyAddressWithAuthentication
            $env:https_proxy = $proxyAddressWithAuthentication
            $env:ftp_proxy = $proxyAddressWithAuthentication

            # Set up a proxy with authentication details for PowerShell web requests
            # This setting only affects web requests made from this script
            $passwordSecure = ConvertTo-SecureString $proxyPassword -AsPlainText -Force
            $creds = New-Object System.Management.Automation.PSCredential $proxyUser, $passwordSecure
            $proxy = New-Object System.Net.WebProxy "http://$($proxyAddress)/"
            $proxy.Credentials = $creds
            [System.Net.WebRequest]::DefaultWebProxy = $proxy

            Write-Host "Proxy settings have been applied."
            return $true
        }
        catch {
            Write-Host "Error occurred while setting up the proxy: $_"
            return $false
        }
    }
    else {
        Write-Host "Proxy settings are not required."
        return $true  # No proxy settings required
    }
}

# Example of usage
# $result = Set-AuthenticationProxyIfRequired
# if (-not $result) {
#     # Handle the error
#     Write-Host "Failed to set up the proxy."
#     return
# }
