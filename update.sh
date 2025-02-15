#!/bin/zsh
echo "##################################"
echo "########SYSTEM IMFORMATION########"
echo "##################################"
#neofetch
source $HOME/dotfiles/enviroment.sh

echo "##################################"
echo "##########DOTFILE UPDATE##########"
echo "##################################"
cd $HOME/dotfiles/
git pull
git submodule update --remote --merge 
cd

# update Systems
echo "##################################"
echo "##########SYSTEM  UPDATE##########"
echo "##################################"
$HOME/dotfiles/update/systems.sh
# Install some terminal
echo "##################################"
echo "##########TERMINAL UPDATE#########"
echo "##################################"
$HOME/dotfiles/update/terminal.sh
# Install some Languages
echo "##################################"
echo "#############RUBY UPDATE##########"
echo "##################################"
$HOME/dotfiles/update/ruby.sh
echo "##################################"
echo "#############RUST UPDATE##########"
echo "##################################"
$HOME/dotfiles/update/rust.sh
echo "##################################"
echo "##########SDKMAN  UPDATE##########"
echo "##################################"
$HOME/dotfiles/update/jvmLan.sh
echo "##################################"
echo "#############NVM  UPDATE##########"
echo "##################################"
$HOME/dotfiles/update/nodejs.sh
echo "##################################"
echo "##########HASKELL UPDATE##########"
echo "##################################"
$HOME/dotfiles/update/haskell.sh
## update dein for nvim
echo "##################################"
echo "#############DEIN UPDATE##########"
echo "##################################"
#$HOME/dotfiles/update/dein.sh
$HOME/dotfiles/update/cocplugin.sh
## update zinit for zsh
echo "##################################"
echo "############SHELDON UPDATE##########"
echo "##################################"
$HOME/dotfiles/update/sheldon.sh
