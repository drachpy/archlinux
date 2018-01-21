# NETWORK
cat <<EOT >> /etc/systemd/network/en.network
[Match]
Name=en*

[Network]
DHCP=v4
EOT

echo "nameserver 208.67.220.220 8.8.4.4" >> /etc/resolv.conf
systemctl start system-networkd
systemctl enable system-networkd
ip a

# SYSTEM update
pacman -Syyu --noconfirm
pacman -Sy --noconfirm base-devel systemd-swap vim xorg xorg-xinit git ttf-dejavu adobe-source-code-pro-fonts ufw gnome-terminal jdk8-openjdk mono python2 curl wget tree htop

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
useradd -m -G wheel -s /bin/bash arch
passwd arch

echo "Reboot and log in as arch"
