#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
  echo "update system packages"
  softwareupdate --install --all
  echo "install brew package manager"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  brew install neovim zip unzip
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  if [ -e /etc/arch-release ]; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si
    cd ~/dotfiles
    yay -Syu
    paccache -r
    paccache -ruk0
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    cat ~/dotfiles/pkgname/yay.list | yay -S -
    cat ~/dotfiles/pkgname/pacman.list | yay -S -
  elif [ -e /etc/lsb-release ]; then
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
    sudo apt install neovim zsh zip unzip autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev
  elif [ -e /etc/debian_version ]; then
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
    sudo apt install neovim zsh zip unzip autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev
  elif [ "$(expr substr $(uname -m) 1 7)" == 'aarch64' ]; then
    pkg update
    pkg upgrade
    pkg install neovim openssh zsh  zip unzip 
    termux-setup-storage
  fi
fi

