#!powershell
param([string]$url)

# powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "rdp-protocol-handler.ps1" "rdp://full%20address=s:mypc:3389&audiomode=i:2&disable%20themes=i:1"
if (!$url -match "^rdp://") {
    echo "non rdp url"
    exit
}

# Add-Type -AssemblyName System.Windows.Forms
# [System.Windows.Forms.MessageBox]::Show($url)

# TODO: Parallels Client (https://kb.parallels.com/en/124310)
#       "C:\Program Files\Parallels\Client\TSClient.exe" s!='HOST' t!='PORT' d!='' u!='USER' a!='#4' m!='4' o!='0' i!='' r!='1'
#       if exist HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{5CF25D42-1069-4838-9A68-BCB410EF98EB}
#       HKEY_CLASSES_ROOT\CLSID\{F5DF8D65-559D-4b75-8562-5302BD2F5F20}\InprocServer32\@ = "C:\Program Files\Parallels\Client\TuxClientSystem.dll"
#       HKEY_CLASSES_ROOT\tuxclient\DefaultIcon\@ = "C:\Program Files\Parallels\Client\TSClient.exe,0"

try { $webutil = [System.Web.HttpUtility] } catch { $webutil = [System.Net.WebUtility] }
$url = [regex]::Replace($url, '/$', '')  # chrome append trailing slash
$content = $url.Substring(6).Split('&') | foreach {
    $k, $v = $_.Split('=', 2)
    return ($webutil::UrlDecode($k) + ":" + $webutil::UrlDecode($v))
}

$tmp = New-TemporaryFile
try {
    # rdp file encoding is UCS-2 LE w/ BOM
    $content | Out-File -FilePath $tmp.FullName -Encoding Unicode

    # todo: https://github.com/FuzzySecurity/PowerShell-Suite/blob/master/Invoke-CreateProcess.ps1
    Start-Process -FilePath "mstsc" -ArgumentList @($tmp.FullName)
    Start-Sleep -s 15

} finally {
    Remove-Item $tmp.FullName -Force
}
