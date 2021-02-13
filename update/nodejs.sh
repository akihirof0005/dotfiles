#!/bin/bash

cd $HOME/.nvm
git pull
source $HOME/.nvm/nvm.sh
nvm install --lts
nvm use --lts
