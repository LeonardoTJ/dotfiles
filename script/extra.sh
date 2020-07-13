#!/usr/bin/bash
# https://github.com/bianjp/archlinux-installer/

# print command before executing, and exit when any command fails
set -xe

# Install yay AUR helper
mkdir ~/aur && cd $_
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Save yay options
yay --save --answerclean None --answerdiff None --answeredit None

# compression/decompression tools
sudo pacman -S --noconfirm unrar p7zip

# unzip-iconv
yes | yay -S unzip-iconv

# NTFS support
sudo pacman -S --noconfirm ntfs-3g

# Fonts
sudo pacman -S --noconfirm ttf-dejavu ttf-ibm-plex
yay -S ttf-blex-nerd-font-git

# Terminal
sudo pacman -S --noconfirm alacritty

# web browser
sudo pacman -S --noconfirm chromium

# media
sudo pacman -S --noconfirm feh mpv cmus

# other utilities
sudo pacman -S --noconfirm htop ranger zathura redshift xclip

# automatic date and time
sudo systemctl enable systemd-timesyncd.service
