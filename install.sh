#!/usr/bin/bash

# Install plugins

## install dein for nvim
mkdir -p ~/.cache/dein
cd ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

## install zgen for zsh
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

source ~/.zshrc


