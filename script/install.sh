#!/usr/bin/bash
# https://github.com/bianjp/archlinux-installer/

# print command before executing, and exit when any command fails
set -xe

# Generate mirrors
curl -sSL 'https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4' | sed 's/^#Server/Server/g' > /etc/pacman.d/mirrorlist
pacman -Sy
pacman -S --noconfirm pacman-contrib
curl -sSL 'https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on' | sed 's/^#Server/Server/g' | rankmirrors - > /etc/pacman.d/mirrorlist
pacman -Syy

# Install the base packages
pacstrap /mnt base base-devel linux

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Setup new system (make sure setup.sh is executable)
rm -rf /mnt/script && mkdir /mnt/script
cp -r ./* /mnt/script/
arch-chroot /mnt /script/setup.sh

reboot
