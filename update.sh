#!/usr/bin/zsh

cd $HOME/dotfiles/
git pull
cd

# update Systems
$HOME/dotfiles/update/systems.sh
# Install some Languages
$HOME/dotfiles/update/ruby.sh
$HOME/dotfiles/update/rust.sh
$HOME/dotfiles/update/jvmLan.sh
$HOME/dotfiles/update/nodejs.sh
$HOME/dotfiles/update/haskell.sh
## update dein for nvim
$HOME/dotfiles/update/dein.sh
## update zinit for zsh
$HOME/dotfiles/update/zinit.sh
