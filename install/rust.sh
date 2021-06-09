#!/bin/zsh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rls rust-analysis rust-src
rustup component add rustfmt

cd ~/dotfiles
