#!/bin/bash

ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
hwclock --systohc
echo "KEYMAP=us" > /etc/vconsole.conf
echo "LANGUAGE=en_US.UTF-8" > /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen
echo "dracha" > /etc/hostname
echo "127.0.0.1    localhost    localhost" > /etc/hosts
echo "::1          localhost    localhost" >> /etc/hosts
mkinitcpio -p linux
passwd
pacman -S --noconfirm syslinux
syslinux-install_update -i -a -m
sed -i 's/\/dev\/sda3/\/dev\/sda1/' /boot/syslinux/syslinux.cfg
extlinux --install /boot/syslinux/
echo "Exit and reboot"
