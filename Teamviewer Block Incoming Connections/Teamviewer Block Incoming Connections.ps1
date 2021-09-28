$TeamViewerRegPath = if (Test-Path "HKLM:Software\TeamViewer") { "HKLM:Software\TeamViewer" }
elseif (Test-Path "HKLM:Software\Wow6432Node\TeamViewer") { "HKLM:Software\Wow6432Node\TeamViewer" }
else { "No TeamViewer Installed" }

if ($TeamViewerRegPath -eq "No TeamViewer Installed") {
    $RandomPassword = "Disabled" # Bogus Data
    $FixedPassword = "Disabled" # Bogus Data
}

$RandomPassword = if ((Get-ItemProperty $TeamViewerRegPath).Security_PasswordStrength -eq 3) { "Disabled" } else {
    New-ItemProperty -Path $TeamViewerRegPath -Name "Security_PasswordStrength" -Value 3 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null
    Restart-Service -Name "Teamviewer" -Force | Out-Null
    "Enabled"
}
$FixedPassword = if ($null -ne (Get-ItemProperty $TeamViewerRegPath).PermanentPassword) { 
    Remove-ItemProperty -Path $TeamViewerRegPath -Name "PermanentPassword" -Force -ErrorAction SilentlyContinue | Out-Null
    Restart-Service -Name "Teamviewer" -Force | Out-Null
    "Enabled"
}
else { "Disabled" }

#region Output Values
"Registry Path   : $TeamViewerRegPath"
"Random Password : $RandomPassword"
"Fixed Password  : $FixedPassword"
#endregion

Test-Path -Path 