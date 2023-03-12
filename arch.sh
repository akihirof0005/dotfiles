NEWHOSTNAME=deskmini
ROOTPASSWD=ak1h1r0

DISK=nvme0n1

# Setup HDD

parted /dev/$DISK mklabel gpt
parted /dev/$DISK mkpart ESP fat32 1MiB 551MiB
parted -s /dev/$DISK set 1 esp on
parted /dev/$DISK mkpart primary xfs 551MiB 100%

mkfs.vfat -F32 /dev/${DISK}p1
mkfs.xfs /dev/${DISK}p2

# Install Base system
mount /dev/${DISK}p2 /mnt
mkdir /mnt/boot
mount /dev/${DISK}p1 /mnt/boot

yes "" | pacstrap -i /mnt linux linux-headers base base-devel linux-firmware xfsprogs

# fstab
genfstab -U /mnt > /mnt/etc/fstab

# Create Setup Script on chroot environment
cat <<++EOS>/mnt/setup.sh
#!/bin/bash
curl "https://archlinux.org/mirrorlist/?country=JP&protocol=https&ip_version=4&ip_version=6" | sed -e "s/^#//g" > /etc/pacman.d/mirrorlist
echo $NEWHOSTNAME >> /etc/hostname

#ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
echo ja_JP.UTF-8 UTF-8 >> /etc/locale.gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf
echo KEYMAP=jp106 > /etc/vconsole.conf
locale-gen

echo root:$ROOTPASSWD | chpasswd

hwclock --systohc --utc

## install 
pacman --noconfirm -S linux-zen linux-zen-headers linux-lts linux-lts-headers openssh amd-ucode

##if you have wifi
pacman -S networkmanager
systemctl enable NetworkManager
#type "sudo nmtui" after installed on terminal

## sshd
systemctl enable sshd

## kernel image
mkinitcpio -P

## add user
useradd -g wheel -s /bin/bash -d /home/akihiro akihiro
chown akihiro:wheel /home/akihiro
# after installed type "passwd akihiro" to setting your password
# Don't forget to separate your home directories, /home is used by system's users you are building.

## boot loader
bootctl install
# Use the lts kernel to avoid driver changes causing hardware drivers to fail to load.
# I am setting the zen kernel and default kernel bootable as an option just booting case.

echo "default lts"   > /boot/loader/loader.conf
echo "timeout 5"    >> /boot/loader/loader.conf
echo "editor no"    >> /boot/loader/loader.conf

echo "title arch linux"                  > /boot/loader/entries/lts.conf
echo "linux /vmlinuz-linux-lts"         >> /boot/loader/entries/lts.conf
echo "initrd /initramfs-linux-lts.img"  >> /boot/loader/entries/lts.conf
echo "options root=$(blkid -o export /dev/${DISK}2 | grep ^UUID) rw"  >> /boot/loader/entries/lts.conf

echo "title arch linux"  > /boot/loader/entries/zen.conf
echo "linux /vmlinuz-linux-zen"  >> /boot/loader/entries/zen.conf
echo "initrd /initramfs-linux-zen.img"  >> /boot/loader/entries/zen.conf
echo "options root=$(blkid -o export /dev/${DISK}2 | grep ^UUID) rw"  >> /boot/loader/entries/zen.conf

echo "title arch linux"  > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux"  >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img"  >> /boot/loader/entries/arch.conf
echo "options root=$(blkid -o export /dev/${DISK}2 | grep ^UUID) rw"  >> /boot/loader/entries/arch.conf

## boot loaders hook
mkdir /etc/pacman.d/hooks
echo '[Trigger]' > /etc/pacman.d/hooks/systemd-boot.hook
echo "Type = Package" >> /etc/pacman.d/hooks/systemd-boot.hook
echo "Operation = Upgrade" >> /etc/pacman.d/hooks/systemd-boot.hook
echo "Target = systemd" >> /etc/pacman.d/hooks/systemd-boot.hook

echo '[Action]' >> /etc/pacman.d/hooks/systemd-boot.hook
echo "Description = Updating systemd-boot" >> /etc/pacman.d/hooks/systemd-boot.hook
echo "When = PostTransaction" >> /etc/pacman.d/hooks/systemd-boot.hook
echo "Exec = /usr/bin/bootctl update" >> /etc/pacman.d/hooks/systemd-boot.hook

## install
pacman --noconfirm -S neovim htop docker docker-compose gitlab-runner

## not auto update
#sed -e "s/#IgnorePkg   =/IgnorePkg   = linux-lts linux-lts-headers docker docker-compose gitlab-runner/g" /etc/pacman.conf

++EOS

chmod +x /mnt/setup.sh

# Setup chroot environment
arch-chroot /mnt "/setup.sh"
