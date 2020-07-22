#!/usr/bin/bash
# https://github.com/bianjp/archlinux-installer/

# print command before executing, and exit when any command fails
set -xe

# Dev stuff
sudo pacman -S --noconfirm python python-pip nodejs npm nasm
python3 -m pip install --user --upgrade pynvim

# Install pikaur
mkdir /tmp/aur && cd $_
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg --noconfirm -fsri

# compression/decompression tools
sudo pacman -S --noconfirm unrar p7zip

# unzip-iconv
pikaur -S --noconfirm unzip-iconv

# NTFS support
sudo pacman -S --noconfirm ntfs-3g

# Fonts
sudo pacman -S --noconfirm ttf-dejavu ttf-ibm-plex
pikaur -S --no-confirm ttf-blex-nerd-font-git

# Terminal
sudo pacman -S --noconfirm alacritty

# web browser
sudo pacman -S --noconfirm chromium

# media
sudo pacman -S --noconfirm feh mpv cmus

# other utilities
sudo pacman -S --noconfirm htop ranger zathura redshift xclip
pikaur -S --noconfirm inxi

# automatic date and time
sudo systemctl enable systemd-timesyncd.service
