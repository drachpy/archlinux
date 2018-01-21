#!/bin/bash

# set /etc/pacman.d/mirrorlist to the closest repo

printf 'n\n\n\n\n\nw\n' | fdisk /dev/sda
#parted -a optimal /dev/sda mkpart primary 0% 100% -s
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt
pacstrap /mnt base
genfstab -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
