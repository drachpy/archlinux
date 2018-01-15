# archlts

https://wiki.archlinux.org/index.php/Installation_guide

# prep net and time
> ping archlinux.org
> timedatectl set-ntp true

# fdisk

> fdisk -l
> fdisk /dev/sda
>>> n
>>> p
>>> whole disk? you know what to do here..
>>> w
> mkfs.ext4 /dev/sda1
> mount /dev/sda1 /mnt
> pacstrap /mnt base

# linux lts - start
> pacman -Sy
> pacstrap /mnt $(pacman -Sqg base | sed 's/^linux$/&-lts/')
# linux lts - end

> genfsstab -U /mnt >> /mnt/etc/fstab
> arch-chroot /mnt
> ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
> hwclock --systohc
> locale-gen
> vi /etc/locale.conf
~ LANGUAGE=en_us.UTF-8
~ LANG=en_US.UTF-8
> vi /etc/hostname
~ myarch
> vi /etc/hosts
~ 127.0.0.1    localhost    localhost
~ ::1    localhost    localhost
> mkinitcpio -p linux
> passwd

# syslinux
> pacman -S syslinux
> syslinux-install_update -i -a -m
> vi /boot/syslinux/syslinux.cfg
~ ..... /dev/sda1

# FIN!
> exit
> poweroff


### NETWORKING
> ps 
# you should see BASH running

> vi /etc/systemd/network/en.network
~ [Match]
~ Name=en\*
~ 
~ [Network]
~ DHCP=v4
~
> vi /etc/resolv.conf
~ nameserver 8.8.4.4 8.8.8.8 # 208.67.220.220 208.67.222.222
> systemctl enable systemd-networkd
> ip a
# you should have IP by now
> ping archlinux.org

> pacman -Syyu
> useradd -m -G wheel -s /bin/bash user1
> passwd user1

### LOGOUT as root

> sudo pacman -S linux-lts
> vi /boot/syslinux/syslinux.cfg
~ ... add linux-lts...
> reboot

### POST INSTALL
> pacman -S base-devel vim xorg git
> 
