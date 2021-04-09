#!/bin/bash

cd $HOME/.nvm
git pull
source $HOME/.nvm/nvm.sh
nvm install  v15.5.0
nvm use  v15.5.0
node -v
