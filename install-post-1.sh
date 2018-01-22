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

cd /opt
mkdir .AUR
cd .AUR
git clone https://aur.archlinux.org/st.git
git clone https://aur.archlinux.org/dwm.git
cd st
makepkg -si
cd ../dwm
sed -i 's/\"st\"/\"xfce4-terminal\"/' config.h
makepkg -si --skipchecksums

cd /opt
mkdir .github
cd .github
git clone https://www.github.com/pypa/get-pip.py
cd get-pip/2.6
python2 get-pip.py
cd ../get-pip/3.2
python3 get-pip.py

# CREATE user arch
useradd -m -G wheel -s /bin/bash arch
passwd arch

echo "Reboot and log in as arch"
