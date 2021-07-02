# Set Symbolic links for AdoptOpenJDK
# Written by Robby Swartenbroekx (b-inside bv)
#
# Distributed under a CC BY-SA 4.0 license (https://creativecommons.org/licenses/by-sa/4.0/)
# Share — copy and redistribute the material in any medium or format
# Adapt — remix, transform, and build upon the material for any purpose, even commercially.
# Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
# ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
# No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
#
# Releases:
# v1.0  7/06/2021   Initial release
#

# Variables (you can change the progress path and AdoptOpenJDK paths if you install this on different locations)
$AOJDK = @{
    Progress = "C:\Progress"
    Path     = @{
        x86 = (Get-ChildItem -Path "${env:ProgramFiles(x86)}\AdoptOpenJDK" -Directory -ErrorAction SilentlyContinue)
        x64 = (Get-ChildItem -Path "${env:ProgramFiles}\AdoptOpenJDK" -Directory -ErrorAction SilentlyContinue)
    }
}
$Output = ""

# Script (Do not change)
try {
    if (-not (Test-Path -Path $AOJDK.Progress)) {
        New-Item -ItemType Directory -Path $AOJDK.Progress
        $Output += "$($AOJDK.Progress) folder created <br>"
    }
    foreach ($BitVersion in ($AOJDK.Path.Keys -split " ")) {
        switch ($AOJDK.Path.($BitVersion).count) {
            0 { $Output += "$($Bitversion): Not Installed = OK<br>"; break }
            1 {
                if (Test-Path -Path "$($AOJDK.Progress)\jdk_$BitVersion") {
                    if (((Get-Item -Path "$($AOJDK.Progress)\jdk_$BitVersion").LinkType -eq "SymbolicLink") -and
                        ((Get-Item -Path "$($AOJDK.Progress)\jdk_$BitVersion").Target -eq $AOJDK.Path.($BitVersion).FullName)) {
                        $Output += "$($Bitversion): Folder OK<br>"; break
                    }
                    (Get-Item -Path "$($AOJDK.Progress)\jdk_$BitVersion").Delete()
                }
                $null = New-Item -ItemType SymbolicLink -Path "$($AOJDK.Progress)\jdk_$BitVersion" -Target "$($AOJDK.Path.($BitVersion).FullName)"
                $Output += "$($Bitversion): Folder (re)created<br>"
                break
            }
            default { $Output += "$($Bitversion): ERROR: $($AOJDK.Path.($BitVersion).count) paths found<br>"; break }
        }
    }
}
catch {
    $Output += "ERROR: $($_.Exception.Message.ToString())<br>"
}

# Output from script (tekst, html formated)
$Output