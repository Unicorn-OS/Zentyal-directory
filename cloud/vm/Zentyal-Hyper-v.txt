Add-WindowsFeature RSAT-Hyper-V-Tools -IncludeAllSubFeature

Update-Help

$vm = "Zentyal"
$cpu = 6
$memory = 4
$storage = 20
$network = "External"
$generation = 2
$iso = "zentyal-7.0-development-amd64.iso"


$RAM = $memory * 1GB
$DISK = $storage * 1GB

New-VM -Name $vm -ProcessorCount $cpu -MemoryStartupBytes $RAM -Path "C:\Users\Public\Documents\Hyper-V\Virtual hard disks" -NewVHDPath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\Zentyal.vhdx" -NewVHDSize $DISK -SwitchName $network -generation $generation

# Set after
Set-VM -Name $vm -ProcessorCount $cpu

# Attach ISO install media
Add-VMDvdDrive -VMName $vm -Path C:\Users\uni\iso\${iso}


<#
Solution:
https://forums.overclockers.com.au/threads/powershell-script-creation-of-vm-and-install-os.1159588/page-2

Tutorial:
https://youtu.be/HQF5Gr8tlks
#>
