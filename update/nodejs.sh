#!/bin/zsh

if [ NODE_FLAG ]; then
  cd $HOME/.nvm
  git pull
  source $HOME/.nvm/nvm.sh
  nvm install $NODE_VER
  nvm use $NODE_VER
  node -v
fi
