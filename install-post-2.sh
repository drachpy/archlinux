#!/bin/bash

echo "==> Installing DWM"
cd ~
mkdir -p ~/.source/aur
cd ~/.source/aur
git clone https://aur.archlinux.org/st.git
git clone https://aur.archlinux.org/dwm.git
cd ~/.source/aur/st
makepkg -si
cd ~/.source/aur/dwm
sed -i 's/\"st\"/\"xfce4-terminal\"/' config.h
makepkg -si --skipchecksums

echo "==> Installing PIP2 and PIP3"
mkdir -p ~/.source/github
cd ~/.source/github
git clone https://www.github.com/pypa/get-pip.git
cd ~/.source/github/get-pip/2.6
python2 get-pip.py
cd ~/.source/github//get-pip/3.2
python3 get-pip.py

cd~
echo "exec dwm" > ~/.xinitrc
startx
