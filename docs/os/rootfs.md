# Move the Raspberry PI root file system to a USB drive

!!! warning
    This step is intended **ONLY** for the Raspberry OS.

## Insert the USB drive and SD card into the PC

Power the Raspberry down. Remove the card and insert it into a PC. Afterwards connect the USB drive to the same PC.

Run the following command for listing all disks and partitions on your PC. The `-p` parameter make sure that the command output includes the full device name

``` sh
lsblk -p | grep "disk\|part"
```

Make sure the partitions are not mounted before continuing

!!! info
    Change the device names according to the result of the previous command

``` sh
sudo umount /dev/sdb1
sudo umount /dev/sdb2
sudo umount /dev/sdc1
```

## Create and format an EXT4 partition on USB drive

Start out by creating a new partition table on the disk

``` sh
sudo parted /dev/sdc mklabel msdos
```

Next create one big partition. This creates `/dev/sdc1`

``` sh
sudo parted /dev/sdc mkpart primary 0% 100%
```

After the creation of the new `/dev/sdc1` partition, format it as `EXT4`

``` sh
sudo mkfs.ext4 /dev/sdc1
```

## Mount the USB drive and SD card partitions

Create the mount points with the following three commands

``` sh
sudo mkdir -p /mnt/usbdrive
sudo mkdir -p /mnt/sdboot
sudo mkdir -p /mnt/sdrootfs
```

Mount the partitions by running the commands

``` sh
sudo mount /dev/sdb1 /mnt/sdboot
sudo mount /dev/sdb2 /mnt/sdrootfs
sudo mount /dev/sdc1 /mnt/usbdrive
```

To verify that all worked as intended, run

``` sh
lsblk -p | grep "disk\|part"
```

## Copy the SD card root file system to the USB drive

Run the following command. Note that it can take a few minutes for the copy operation to complete

``` sh
sudo rsync -axv /mnt/sdrootfs/* /mnt/usbdrive
```

## Remap the root partition

This needs to be done in two locations:

1. In the command line parameters that the bootloader passes to the Linux kernel.
2. In the file system table file (fstab) that informs the Linux kernel how to mount the file systems.

Run this command to determine the PARTUUID of the partition on the USB drive

``` sh
sudo blkid | grep "/dev/sdc1"
```

### Update `PARTUUID` in kernel parameters

The parameters that the bootloader passes to the kernel are located in file `cmdline.txt` on SD card’s boot partition. One of the parameters is the `PARTUUID` of the partition holding the root file system. Make a backup copy of this file first and then edit this file

``` sh
sudo cp /mnt/sdboot/cmdline.txt /mnt/sdboot/cmdline.org
sudo nano /mnt/sdboot/cmdline.txt
```

### Update `PARTUUID` in file system table

The fstab file is normally located in `/etc/fstab`. Make a backup copy of this file first then edit this file

``` sh
sudo cp /mnt/usbdrive/etc/fstab /mnt/usbdrive/etc/fstab.org
sudo nano /mnt/usbdrive/etc/fstab
```

Add this line at the end of file

``` text
PARTUUID=xxxxxxxx-xx  /               ext4    defaults,noatime  0       1
```

!!! info
    Change the `xxxxxxxx-xx` with the `PARTUUID` of the partition holding the root file system

## Unmount the partitions and delete the mount points

``` sh
sudo umount /mnt/{usbdrive,sdboot,sdrootfs}
sudo rmdir /mnt/{usbdrive,sdboot,sdrootfs}
```

## Boot the Raspberry PI

Remove both the SD card and the USB drive from the PC. Next, insert them into the Raspberry PI. Power on the Raspberry PI and wait a little bit for the boot process to complete.

Once the Raspberry PI completed booting, remotely log in to it via SSH and run the following command to verify that the Raspberry PI’s root file system is actually on the USB drive:

``` sh
lsblk -p
```

It should be something this

``` terminal hl_lines="3 5"
NAME             MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
/dev/sda           8:0    0 223.6G  0 disk
└─/dev/sda1        8:1    0 223.5G  0 part /
/dev/mmcblk0     179:0    0  29.7G  0 disk
├─/dev/mmcblk0p1 179:1    0   256M  0 part /boot
└─/dev/mmcblk0p2 179:2    0   1.5G  0 part
```

## Removing the unused partition

Power the Raspberry down. Remove the card and insert it into a PC.

Select the device

``` sh
sudo fdisk /dev/sdb
```

type the next key sequence:

- ++d++ to delete the partition
- ++2++ the index of the partition to be deleted
- ++p++ to print the disk layout
- ++w++ to finally write the modifications

## Resize the partition

!!! example "to be checked"
    ``` sh
    resize2fs /dev/sdb1
    ```

## Reboot again the Raspberry PI

Remove the SD card from the PC. Next, insert it into the Raspberry PI. Power on the Raspberry PI and wait a little bit for the boot process to complete.

Once the Raspberry PI completed booting, remotely log in to it via SSH and run the following command to verify that the Raspberry PI’s root file system is actually on the USB drive:

``` sh
lsblk -p
```

It should be something this

``` terminal hl_lines="5"
NAME             MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
/dev/sda           8:0    0 223.6G  0 disk
└─/dev/sda1        8:1    0 223.5G  0 part /
/dev/mmcblk0     179:0    0  29.7G  0 disk
└─/dev/mmcblk0p1 179:1    0  29.7G  0 part /boot
```
