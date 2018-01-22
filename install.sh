#!/bin/bash

timedatectl set-ntp true
vi /etc/pacman.d/mirrorlist
printf 'n\n\n\n\n\nw\n' | fdisk /dev/sda
#parted -a optimal /dev/sda mkpart primary 0% 100% -s
mkfs.ext4 /dev/sda1 -O \^64bit
mount /dev/sda1 /mnt
pacstrap /mnt base
genfstab -p /mnt >> /mnt/etc/fstab

# COPY prep install
wget https://raw.githubusercontent.com/drachpy/archlinux/master/install-prep.sh
mv install-prep.sh /mnt/install.sh
chmod a+x /mnt/install.sh

# COPY post install
wget https://raw.githubusercontent.com/drachpy/archlinux/master/install-post-1.sh
cp install-post-1.sh /mnt/root/install-post.sh
chmod a+x /mnt/root/install-post.sh

# RUN prep install
arch-chroot /mnt ./install.sh
rm /mnt/install.sh
umount -R /mnt
echo ""
echo "Please verify installation."
poweroff
