#!/usr/bin/zsh

$HOME/dotfiles/install/systems.sh
# update Systems
$HOME/dotfiles/update/systems.sh
# Install alacritty
$HOME/dotfiles/install/terminal.sh
# Install some Languages
$HOME/dotfiles/install/ruby.sh
$HOME/dotfiles/install/rust.sh
$HOME/dotfiles/install/jvmLan.sh
$HOME/dotfiles/install/nodejs.sh
$HOME/dotfiles/install/haskell.sh
## install dein for nvim
$HOME/dotfiles/install/dein.sh
## install zinit for zsh
$HOME/dotfiles/install/zinit.sh
## some plugins for nvim CocInstall
$HOME/dotfiles/install/cocplugin.sh
## init install for nvim enviroment
alacritty -e nvim &
##swich to zsh
chsh -s /bin/zsh
exec zsh

