#!/usr/bin/bash
curl -sSL https://get.haskellstack.org/ | sh
stack setup
stack ghc -- --version

cd ~/.cache
git clone https://github.com/haskell/haskell-language-server --recurse-submodules
cd haskell-language-server
stack ./install.hs hls

cd ~/dotfiles
