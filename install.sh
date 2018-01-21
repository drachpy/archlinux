#!/bin/bash

# set /etc/pacman.d/mirrorlist to the closest repo

printf 'n\n\n\n\n\nw\n' | fdisk /dev/sda
#parted -a optimal /dev/sda mkpart primary 0% 100% -s
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt
pacstrap /mnt base
pacman -S base
genfsstab -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
hwclock --systohc
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "LANGUAGE=en_US.UTF-8" > /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen
echo "dracha" > /etc/hostname
echo "127.0.0.1    localhost    localhost" >> /etc/hosts
echo "::1          localhost    localhost" >> /etc/hosts
mkinitcpio -p linux
pacman -S syslinux
syslinux-install_update -i -a -m
sed -i 's/\/dev\/sda3/\/dev\/sda1/' /boot/syslinux/syslinux.cfg
passwd
#poweroff
