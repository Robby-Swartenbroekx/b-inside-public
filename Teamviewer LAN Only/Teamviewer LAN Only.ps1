if (Test-Path "HKLM:Software\TeamViewer") {
    $Comment = "Teamviewer Native bitversion found"
    $EnableLAN = if ((Get-ItemProperty "HKLM:Software\TeamViewer").General_DirectLAN) { "True" } else {
        New-ItemProperty -Path "HKLM:Software\TeamViewer" -Name "General_DirectLAN" -Value 1 -PropertyType DWORD -Force | Out-Null
        "False"
    }
    $ForceLAN = if ((Get-ItemProperty "HKLM:Software\TeamViewer").LanOnly) { "True" } else { 
        New-ItemProperty -Path "HKLM:Software\TeamViewer" -Name "LanOnly" -Value 1 -PropertyType DWORD -Force | Out-Null
        "False"
    }
}
elseif (Test-Path "HKLM:Software\Wow6432Node\TeamViewer") {
    $Comment = "Teamviewer Wow6432 found"
    $EnableLAN = if ((Get-ItemProperty "HKLM:Software\Wow6432Node\TeamViewer").General_DirectLAN) { "True" } else {
        New-ItemProperty -Path "HKLM:Software\Wow6432Node\TeamViewer" -Name "General_DirectLAN" -Value 1 -PropertyType DWORD -Force | Out-Null
        "False"
    }
    $ForceLAN = if ((Get-ItemProperty "HKLM:Software\Wow6432Node\TeamViewer").LanOnly) { "True" } else {
        New-ItemProperty -Path "HKLM:Software\Wow6432Node\TeamViewer" -Name "LanOnly" -Value 1 -PropertyType DWORD -Force | Out-Null
        "False"
    }
}
else {
    $Comment = "No Teamviewer installed"
    $ForceLAN = "True" # Bogus info
    $EnableLAN = "True" # Bogus info
}

#region Output Values
"Comment   : $Comment"
"ForceLAN  : $ForceLAN"
"EnableLAN : $EnableLAN"
#endregion

