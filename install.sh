#!/usr/bin/zsh


if [ "$(uname)" == 'Darwin' ]; then
  echo "update system packages"
  softwareupdate --install --all
  echo "update brew packages"
  brew update
  brew upgrade
  echo "update brew cask packages"
  brew cask upgrade
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  if [ -e /etc/arch-release ]; then
     yay -Syu; paccache -r; paccache -ruk0
     sudo grub-mkconfig -o /boot/grub/grub.cfg
     pacman -Qmq > ~/dotfiles/pkgname/yay.list
     pacman -Qnq > ~/dotfiles/pkgname/pacman.list
  elif [ -e /etc/lsb-release ]; then
     sudo apt update
     sudo apt upgrade
     sudo apt autoremove
     sudo apt install neovim zsh
     sudo apt install zip unzip autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev
  elif [ -e /etc/debian_version ]; then
     sudo apt update
     sudo apt upgrade
     sudo apt autoremove

  elif [ "$(expr substr $(uname -m) 1 7)" == 'aarch64' ]; then
     pkg update
     pkg upgrade
     pkg install neovim openssh zsh   rust
     termux-setup-storage
  fi
fi

# update Systems
bash bin/update

# Install plugins

## install dein for nvim
mkdir -p ~/.cache/dein
cd ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
zsh ./installer.sh ~/.cache/dein

## install zinit for zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

## install Rust for *nix
$HOME/dotfiles/install/rust.sh

## install sdk system
$HOME/dotfiles/install/jvmLan.sh

## install nodejs
$HOME/dotfiles/install/nodejs.sh

## install Ruby
$HOME/dotfiles/install/ruby.sh

##swich to zsh
chsh -s /bin/zsh
exec zsh

## some plugins for nvim CocInstall
`nvim -c "source ~/.bin/cocplugins"`
