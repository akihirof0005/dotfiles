#!/usr/bin/zsh

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
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## install sdk system 
 curl -s "https://get.sdkman.io" | bash
 source "~/.sdkman/bin/sdkman-init.sh"
 sdk install java 14.0.2.j9-adpt
 sdk install gradle
 sdk install kotlin

chsh -s /bin/zsh
exec zsh


