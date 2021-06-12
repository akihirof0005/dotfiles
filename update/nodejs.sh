#!/bin/zsh

if [ NODE_FLAG ]; then

(
  cd "$NVM_DIR"
  git fetch --tags origin
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"
  nvm install $NODE_VER
  nvm use $NODE_VER
  nvm install-latest-npm
  node -v
fi
