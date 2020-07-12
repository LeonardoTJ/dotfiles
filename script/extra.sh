#!/usr/bin/bash
# https://github.com/bianjp/archlinux-installer/

# print command before executing, and exit when any command fails
set -xe

# Add archlinuxcn repository
if ! grep 'archlinuxcn' /etc/pacman.conf &> /dev/null; then

  sudo tee /etc/pacman.d/archlinuxcn-mirrorlist <<EOF
Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch
Server = http://mirrors.cqu.edu.cn/archlinux-cn/\$arch
Server = http://repo.archlinuxcn.org/\$arch
EOF

  sudo tee -a /etc/pacman.conf <<EOF
[archlinuxcn]
SigLevel = Optional TrustedOnly
Include = /etc/pacman.d/archlinuxcn-mirrorlist
EOF
  sudo pacman -Syy
  sudo pacman -S --noconfirm archlinuxcn-keyring archlinuxcn-mirrorlist-git

  # Install AUR helper from archlinuxcn repo
  sudo pacman -S --noconfirm yay
  # Save yay options
  yay --save --answerclean None --answerdiff None --answeredit None
fi

sudo pacman -Syy

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
