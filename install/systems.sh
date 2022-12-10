#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
    echo "update system packages"
    softwareupdate --install --all
    echo "install brew package manager"
  if [ "$(uname -m)" == 'arm64' ]; then
    arch -arm64e /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
  brew install neovim zip unzip git
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  if [ -e /etc/arch-release ]; then
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -si
    cd ~/dotfiles
    paru -Syu
    paccache -r
    paccache -ruk0
    cat ~/dotfiles/pkgname/paru.list | paru -S -
    cat ~/dotfiles/pkgname/pacman.list | paru -S -
  elif [ -e /etc/lsb-release ]; then
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
    sudo apt install git neovim zsh zip unzip autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev
  elif [ -e /etc/debian_version ]; then
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
    sudo apt install git neovim zsh zip unzip autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev
  elif [ "$(expr substr $(uname -m) 1 7)" == 'aarch64' ]; then
    pkg update
    pkg upgrade
    pkg install neovim openssh zsh  zip unzip git 
    termux-setup-storage
  fi
fi

