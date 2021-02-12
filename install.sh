#!/usr/bin/zsh

cd $HOME/dotfiles/
git pull

$HOME/dotfiles/install/systems.sh

# update Systems
$HOME/dotfiles/update/systems.sh
bash .bin/update

# Install some Languages
$HOME/install/ruby.sh
$HOME/install/rust.sh
$HOME/install/jvmLan.sh
$HOME/install/nodejs.sh
$HOME/install/haskell.sh

## install dein for nvim
mkdir -p ~/.cache/dein
cd ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
zsh ./installer.sh ~/.cache/dein
cd ~/dotfiles

## install zinit for zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

## some plugins for nvim CocInstall
nvim -c "source ~/.bin/cocplugins"

##swich to zsh
chsh -s /bin/zsh
exec zsh

