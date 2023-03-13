#!/bin/zsh

NVM_DIR=""

if [ $NODE_FLAG ]; then

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm install $NODE_VER
  nvm use $NODE_VER
  node -v
  npm install -g yarn

  cd ~/dotfiles/

fi
