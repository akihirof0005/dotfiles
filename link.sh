#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ~/dotfiles
for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".config" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    ln -s "$SCRIPT_DIR/$f" "$HOME/$f"
    echo "$f"
done
rm  .ssh/.ssh .xmonad/.xmonad

mkdir ~/.config
cd ~/dotfiles/.config
for f in *
do
    ln -s "$SCRIPT_DIR/.config/$f" "$HOME/.config/$f"
    echo "$f"
done
