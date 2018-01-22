# NETWORK
cat <<EOT >> /etc/systemd/network/en.network
[Match]
Name=en*

[Network]
DHCP=v4
EOT

echo "nameserver 208.67.220.220 8.8.4.4" >> /etc/resolv.conf
systemctl start systemd-networkd
systemctl enable systemd-networkd
ip a

# SYSTEM update
pacman -Syyu --noconfirm
pacman -Sy --noconfirm base-devel systemd-swap sudo vim xorg xorg-xinit git curl wget tree htop ttf-dejavu adobe-source-code-pro-fonts ufw xfce4-terminal jdk8-openjdk mono python2 firefox flatpak

# UFW enable
ufw enable
ufw status verbose
systemctl start ufw.service
systemctl enable ufw.service

# SWAP file
echo "swapfu_enabled=1" >> /etc/systemd/swap.conf
echo "vm.swappiness=10" >> /etc/sysctl.d/99-sysctl.conf
systemctl start systemd-swap
systemctl enable systemd-swap

# CREATE user arch
useradd -m -G wheel -s /bin/bash drach
passwd drach
visudo

wget https://raw.githubusercontent.com/drachpy/archlinux/master/install-post-2.sh
mv install-post-2.sh /home/drach/install.sh
chmod a+x /home/drach/install.sh

echo "Re-login as drach and run install.sh"
