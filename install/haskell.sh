#!/bin/bash

HASKELL_FLAG=$(cat ~/dotfiles/config.json | jq -r .languages.haskell.enable)

if [ HASKELL_FLAG ]; then
curl -sSL https://get.haskellstack.org/ | sh
stack setup
stack ghc -- --version

cd ~/.cache
git clone https://github.com/haskell/haskell-language-server --recurse-submodules
cd haskell-language-server
stack ./install.hs hls

cd ~/dotfiles
fi
