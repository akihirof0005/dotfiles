#!/usr/bin/zsh

# update Systems
bash bin/update

# Install plugins

## install dein for nvim
mkdir -p ~/.cache/dein
cd ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
zsh ./installer.sh ~/.cache/dein

## install zgen for zsh
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

chsh -s /bin/zsh
source ~/.zshrc


