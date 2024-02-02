# EFI Volume Info

## Description

This AMP checks the EFI volume and outputs the total size and free size.
In the Custom Service and Service Templates, I've use 250Mb as the minimum free space needed as this is indicated by Microsoft in KB5034441 (https://support.microsoft.com/en-au/topic/kb5034441-windows-recovery-environment-update-for-windows-10-version-21h2-and-22h2-january-9-2024-62c04204-aaa5-4fee-a02a-2fdea17075a8)

## Author

These script were created by Robby Swartenbroekx for b-inside bv.

## Version History

Version | Date | Comments
:---:|---:|---
v1.0.0 | 2/02/2024 | Initial Release

## Included files

Filename | Description
---|---
README.md | This file
EFI Volume Info.amp | The Automation Policy object that is being used
EFI Volume Info.xml | The Custom Service (includes the AMP)
ServiceTemplateExport-EFI Volume Info (Laptop).zip | The Service Template for Laptops (Includes Custom Service & AMP)
ServiceTemplateExport-EFI Volume Info (Workstations).zip | The Service Template for Workstations (Includes Custom Service & AMP)

## Disclaimers

This script/AMP/Custom Service/Service Templates are provided "as is" and is intended to work with N-central of N-able. These objects were created and tested against N-central version 2023.9.1.30