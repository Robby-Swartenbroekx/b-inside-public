#Test File, input variable of AMP (that will give the correct hosts file, but by default VS Code doesn't have write access to that location)
$strLocation = "C:\temp\hosts"

$HostContent = Get-Content $strLocation
Clear-Content $strLocation

Foreach ($Hostline in $HostContent) {
    $output = switch -Regex ($Hostline) {
        '^\s*$' { break } # Empty line
        '^\s*[#]' { break } # Line already starts with a #
        'vmware\-plugin' { break }
        'view\-localhost' { break }
        'vmware\-localhost' { break }
        '^\s*127\.0\.0\.1\s+localhost' { break }
        '::1\s+localhost' { break }
        'eazylink\.zetes\.be' { break }
        default {
            "# n-able # "
        }
    }
    $output + $Hostline | Out-File $strLocation -append -enc ascii
}