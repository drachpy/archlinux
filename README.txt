# archlinux

### TL;DR;
1. Boot to archlinux iso
2. $ wget tiny.cc/archinstall
3. $ chmod a+x archinstall
4. run the script: $ ./archinstall
Note: This will auto shutdown the image once it is done. You can remove the disk and start the machine.
5. login as root to the new system. Edit the file install-post.sh to fit your needs like user name and other commands you wanted to run and then run post install: $ ./install-post.sh
6. logout and login as the user you created, run again ./install.sh to prep the user related environment
7. startx to run DWM.


### Do it manually?

https://wiki.archlinux.org/index.php/Installation_guide
How to read this file.
1. # is a comment or a note
2. > run this on a terminal/console
3. ~ content of a file

### 1, 2, 3 go!!!

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
> genfsstab -p /mnt >> /mnt/etc/fstab
> arch-chroot /mnt

### PREP STAGE
> ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
> hwclock --systohc
> vi /etc/vconsole.conf
~ KEYMAP=us
> vi /etc/locale.conf
~ LANGUAGE=en_us.UTF-8
~ LANG=en_US.UTF-8
> locale-gen
> vi /etc/hostname
~ myarch
> vi /etc/hosts
~ 127.0.0.1    localhost    localhost
~ ::1    localhost    localhost
# impt: see note at the bottom of this file if you are booting from USB
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

> sudo pacman -S linux-lts linux-lts-headers
> vi /boot/syslinux/syslinux.cfg
~ ... setup linux-lts...
> sudo pacman -Rs linux
> reboot

### POST INSTALL
> sudo vi /etc/systemd/swap.conf
# search for swapfu
~ swapfu_enabled=1
> sudo systemctl enable systemd-swap
> sudo vi /etc/sysctl.d/99-sysctl.conf
~ vm.swappiness=10
> pacman -S base-devel vim xorg xorg-xinit git ttf-dejavu adobe-source-code-pro-fonts ufw mate-terminal jdk8-openjdk mono python3 python2 curl wget tree htop
> sudo ufw enable
> sudo ufw status verbose
> sudo systemctl enable ufw.service
> mkdir ~/.AUR
> cd ~/.AUR
> git clone https://aur.archlinux.org/st.git
> cd st
> makepkg -si
> git clone https://aur.archlinux.org/dwm.git
> cd dwm
# edit config to use mate-terminal instead of st
> makepkg -si
> vim ~/.xinitrc
~ exec dwm
> mkdir -p ~/.source/github
> cd ~/.source/github
> git clone https://www.github.com/pypa/get-pip.py
> cd ~/.source/github/get-pip/2<tab>
> python2 get-pip.py
> cd ~/.source/github/get-pip/3<tab>
> python3 get-pip.py


### When going LTS you might as well try to ignore some packages in your /etc/pacman.conf
IgnorePkg = linux linux-headers linux-lts linux-headers-lts virtualbox virtualbox-guest-iso virtualbox-host-modules virtualbox-host-modules-lts

# Booting from USB? before running > mkinitcpio -p linux
> vim /etc/mkinitcpio.conf
# Search for HOOKS
~ move the `block` before autodetect
