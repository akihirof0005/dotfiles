#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ~/dotfiles

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    ln -s "$SCRIPT_DIR/$f" "$HOME/$f"
    echo "$f"
done
 rm .config/.config .ssh/.ssh .xmonad/.xmonad
