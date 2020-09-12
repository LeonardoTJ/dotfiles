#!/usr/bin/bash
# https://github.com/bianjp/archlinux-installer

# print command before executing, and exit when any command fails
set -xe

# hostname
hostname=arch
# regular user name
username=leonardo
# password for regular user. Password for root will not be set
password=123456

# Timezone
ln -sf /usr/share/zoneinfo/America/Tijuana /etc/localtime
hwclock --systohc

# Locale
sed -i 's/^#es_MX.UTF-8/es_MX.UTF-8/' /etc/locale.gen
sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=es_MX.UTF-8" > /etc/locale.conf
echo "LC_ADDRESS=es_MX.UTF-8" >> /etc/locale.conf
echo "LC_IDENTIFICATION=es_MX.UTF-8" >> /etc/locale.conf
echo "LC_MEASUREMENT=es_MX.UTF-8" >> /etc/locale.conf
echo "LC_MONETARY=es_MX.UTF-8" >> /etc/locale.conf
echo "LC_NAME=es_MX.UTF-8" >> /etc/locale.conf
echo "LC_NUMERIC=es_MX.UTF-8" >> /etc/locale.conf
echo "LC_PAPER=es_MX.UTF-8" >> /etc/locale.conf
echo "LC_TELEPHONE=es_MX.UTF-8" >> /etc/locale.conf
echo "LC_TIME=es_MX.UTF-8" >> /etc/locale.conf

# Hostname
echo $hostname > /etc/hostname

# Hosts file
echo "127.0.0.1     localhost" > /etc/hosts
echo "::1           localhost" >> /etc/hosts
echo "127.0.1.1     $hostname.localdomain   $hostname" >> /etc/hosts

# Install intel-ucode for Intel CPU
is_intel_cpu=$(lscpu | grep 'Intel' &> /dev/null && echo 'yes' || echo '')
if [[ -n "$is_intel_cpu" ]]; then
  pacman -S --noconfirm intel-ucode --overwrite=/boot/intel-ucode.img
fi

# Bootloader
# Use system-boot for EFI mode, and grub for others
if [[ -d "/sys/firmware/efi/efivars" ]]; then
  bootctl install

  cat <<EOF > /boot/loader/entries/arch.conf
    title      Arch Linux
    linux      /vmlinuz-linux
    initrd     /intel-ucode.img
    initrd     /initramfs-linux.img
    options    root=/dev/sda2 rw
EOF

  cat <<EOF > /boot/loader/loader.conf
    default arch
    timeout 3
    editor no
EOF

  if [[ -z "$is_intel_cpu" ]]; then
    sed -i '/intel-ucode/d' /boot/loader/entries/arch.conf
  fi

  # remove leading spaces
  sed -i 's#^ \+##g' /boot/loader/entries/arch.conf
  sed -i 's#^ \+##g' /boot/loader/loader.conf

  # modify root partion in loader conf
  root_partition=$(mount | grep 'on / ' | cut -d' ' -f1)
  root_partition=$(df / | tail -1 | cut -d' ' -f1)
  sed -i "s#/dev/sda2#$root_partition#" /boot/loader/entries/arch.conf
else
  disk=$(df / | tail -1 | cut -d' ' -f1 | sed 's#[0-9]\+##g')
  pacman --noconfirm -S grub os-prober
  grub-install --target=i386-pc "$disk"
  grub-mkconfig -o /boot/grub/grub.cfg
fi

# Config sudo
# allow users of group wheel to use sudo
sed -i 's/^# %wheel ALL=(ALL) ALL$/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Create regular user
useradd -m -g users -G wheel -s /bin/bash $username
echo "$username:$password" | chpasswd

# Network
pacman -S --noconfirm  networkmanager wpa_supplicant
systemctl enable NetworkManager

# Xorg
pacman -S --noconfirm xorg-server xorg-xinit

# Configure xinit/bash
echo "source ~/.bashrc" >> /home/$username/.bash_profile
echo "if systemctl -q is-active graphical.target \
&& [[ ! \$DISPLAY && \$XDG_VTNR -eq 1 ]]; then" >> /home/$username/.bash_profile
echo "	exec startx" >> /home/$username/.bash_profile
echo "fi" >> /home/$username/.bash_profile

# Graphics driver
pacman -S --noconfirm bumblebee
gpasswd -a $username bumblebee
systemctl enable bumblebeed

# Window manager
pacman -S --noconfirm picom nitrogen
pacman -S --noconfirm qtile

# Setup qtile
cp /etc/X11/xinit/xinitrc /home/$username/.xinitrc
head -n -14 /home/$username/.xinitrc > /tmp/.xi_temp && mv /tmp/.xi_temp /home/$username/.xinitrc
echo "exec qtile" >> /home/$username/.xinitrc

# Keyboard layout
setxkbmap latam

# Useful shell utils
pacman -S --noconfirm bash-completion neovim bind-tools dos2unix rsync wget git tree man-db man-pages
pacman -S --noconfirm net-tools whois screen inotify-tools perl-rename recode
