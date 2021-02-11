#!/usr/bin/zsh

cd $HOME/dotfiles/
git pull

$HOME/dotfiles/install/systems.sh

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
