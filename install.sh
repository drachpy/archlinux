#!/bin/bash

timedatectl set-ntp true
vi /etc/pacman.d/mirrorlist
printf 'n\np\n\n\n\nw\n' | fdisk /dev/sda
#parted -a optimal /dev/sda mkpart primary 0% 100% -s
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt
pacstrap /mnt base
genfstab -p -U /mnt >> /mnt/etc/fstab
# COPY prep install
wget https://raw.githubusercontent.com/drachpy/archlinux/master/install-prep.sh
mv install-prep.sh /mnt/install.sh
chmod a+x /mnt/install.sh
# RUN prep install
arch-chroot /mnt ./install.sh
rm /mnt/install.sh
umount /mnt
reboot
