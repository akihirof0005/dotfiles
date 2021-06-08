#!/bin/bash

NODE_FLAG=$(cat ~/dotfiles/config.json | jq .languages.nodejs.enable)
NODE_VER=$(cat ~/dotfiles/config.json | jq -r .languages.nodejs.version)
NODE_MODULES=$(cat ~/dotfiles/config.json | jq -r .languages.nodejs.modules[] | tr '\n' ' ')

if [ NODE_FLAG ]; then
  cd $HOME/.nvm
  git pull
  source $HOME/.nvm/nvm.sh
  nvm install $NODE_VER
  nvm use $NODE_VER
  node -v
fi
