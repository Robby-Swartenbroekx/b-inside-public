$Output = If ((Get-Service | where-object { $_.DisplayName -like "Veeam Distribution Service" }).Count -eq 1) {
    $ExePath = (Get-CimInstance Win32_Service -Filter 'DisplayName = "Veeam Distribution Service"').PathName.Trim('"')
    If (Test-Path -Path $ExePath) {
        $VeeamDistVersionInfo = (Get-Item -Path $ExePath).VersionInfo
        $Version = $VeeamDistVersionInfo.FileVersion    
        if ((Get-Service | where-object { $_.DisplayName -like "Veeam Distribution Service" }).StartType -like "Automatic*") {
            Switch ($VeeamDistVersionInfo.FileMajorPart) {
                { $_ -le 8 } { "Warning: Veeam te oud"; break }
                9 {
                    Switch ($VeeamDistVersionInfo.FileMinorPart) {
                        { $_ -le 4 } { "Warning: Veeam te oud"; break }
                        5 { "Error: Vulnerable versie - upgrade naar 10 of nieuwer" ; break }
                        default { "Error: Fout bij uitlezen versie" ; break }
                    }
                }
                10 {
                    Switch ($VeeamDistVersionInfo.FileMinorPart) {
                        0 {
                            Switch ($VeeamDistVersionInfo.FileBuildPart) {
                                0 { "Error: Vulnerable versie - upgrade naar 10a of nieuwer"; break }
                                1 {
                                    Switch ($VeeamDistVersionInfo.FilePrivatePart) {
                                        { $_ -lt 4854 } { "Error: Vulnerable versie - upgrade naar 10a of nieuwer"; break }
                                        4854 {
                                            if ($VeeamDistVersionInfo.Comments -like "Private Fix KB20220304*") {
                                                "OK: Patched version" ; break
                                            }
                                            else {
                                                "Error: Vulnerable versie - Installeer de patch P20220304"
                                            }
                                        }
                                        { $_ -gt 4854 } { "OK: Fixed version" ; break }
                                        default { "Error: Fout bij uitlezen versie" ; break }
                                    }
                                }
                                { $_ -ge 2 } { "OK: Fixed version" ; break }
                                default { "Error: Fout bij uitlezen versie" ; break }
                            }
                        }
                        { $_ -ge 1 } { "OK: Fixed version" ; break }
                        default { "Error: Fout bij uitlezen versie" ; break }
                    }
                }
                11 {
                    Switch ($VeeamDistVersionInfo.FileMinorPart) {
                        0 {
                            Switch ($VeeamDistVersionInfo.FileBuildPart) {
                                0 { "Error: Vulnerable versie - upgrade naar 11a of nieuwer"; break }
                                1 {
                                    Switch ($VeeamDistVersionInfo.FilePrivatePart) {
                                        { $_ -lt 1261 } { "Error: Vulnerable versie - upgrade naar 11a of nieuwer"; break }
                                        1261 {
                                            if ($VeeamDistVersionInfo.Comments -like "Private Fix KB20220302*") {
                                                "OK: Patched version" ; break
                                            }
                                            else {
                                                "Error: Vulnerable versie - Installeer de patch P20220302"
                                            }
                                        }
                                        { $_ -gt 1261 } { "OK: Fixed version" ; break }
                                        default { "Error: Fout bij uitlezen versie" ; break }
                                    }
                                }
                                { $_ -ge 2 } { "OK: Fixed version" ; break }
                                default { "Error: Fout bij uitlezen versie" ; break }
                            }
                        }
                        { $_ -ge 1 } { "OK: Fixed version" ; break }
                        default { "Error: Fout bij uitlezen versie" ; break }
                    }
                }
                { $_ -ge 12 } { "OK: Fixed version" }
                default { "Error: Fout bij uitlezen versie" ; break }
            }
        }
        else {
            "OK: Installed but disabled"
        }
    }
    else {
        $Version = "0.0.0.0"
        "Error: Executable path not found"
    }
}
else {
    $Version = "0.0.0.0"
    "OK: Not installed"
}

$Output
$Version