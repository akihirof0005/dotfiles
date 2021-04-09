#!/bin/bash
cd $HOME/dotfiles/
git pull

if [ "$(uname)" == 'Darwin' ]; then
  echo "update system packages"
  softwareupdate --install --all
  echo "update brew packages"
  brew update
  brew upgrade
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  if [ -e /etc/arch-release ]; then
    yay -Syu;
    paccache -r;
    paccache -ruk0
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    pacman -Qmq > ~/dotfiles/pkgname/yay.list
    pacman -Qnq > ~/dotfiles/pkgname/pacman.list
  elif [ -e /etc/lsb-release ]; then
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
  elif [ -e /etc/debian_version ]; then
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
  elif [ "$(expr substr $(uname -m) 1 7)" == 'aarch64' ]; then
    pkg update
    pkg upgrade
    termux-setup-storage
  fi
fi

