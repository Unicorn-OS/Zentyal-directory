$vm = "Zentyal"
$cpu = 6
$memory = 4
$storage = 20
$network = "External"
$generation = 2
$iso = "zentyal-7.0-development-amd64.iso"


$RAM = $memory * 1GB
$DISK = $storage * 1GB

New-VM -Name $vm -ProcessorCount $cpu -MemoryStartupBytes $RAM -Path "C:\Users\Public\Documents\Hyper-V\Virtual hard disks" -NewVHDPath "C:\Users\Public\Documents\Hyper-V\Virtual hard disks\Zentyal.vhdx" -NewVHDSize $DISK -SwitchName $network -generation $generation -BootDevice vhd

Add-VMDvdDrive -VMName $vm -Path C:\Users\uni\iso\${iso}

# Set before start
Set-VM -Name $vm -ProcessorCount $cpu

$dvd = Get-VMDvdDrive -VMName $vm

Write-Information "Adding a dvd drive for installation"
$dvdDrives = Get-VMDvdDrive -VMName $vm

Write-Information "Setting boot order to hard drive, dvd and removing the NIC from the boot order"
$hardDrives = Get-VMHardDiskDrive -VMName $vm
$primaryDrive = $hardDrives[0]

Set-VMFirmware -BootOrder @($primaryDrive, $dvdDrive) -VMName $vm

Set-VMFirmware -EnableSecureBoot Off -FirstBootDevice $dvd -VMName $vm




<#
Solution:
https://forums.overclockers.com.au/threads/powershell-script-creation-of-vm-and-install-os.1159588/page-2

keep, Tutorial:
https://www.frakkingsweet.com/script-the-creation-of-vm-in-hyper-v/

Tutorial:
https://youtu.be/HQF5Gr8tlks
https://pixelrobots.co.uk/2017/04/create-a-hyper-v-virtual-machine-using-powershell/


Func:
https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vmfirmware?view=windowsserver2019-ps
#>
