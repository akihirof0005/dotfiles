#!/bin/bash
cd
find . -xtype l | xargs rm

SCRIPT_DIR="$HOME/dotfiles"
cd ~/dotfiles
for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".config" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".xmonad" ]] && continue
    rm "$HOME/$f"
    ln -s "$SCRIPT_DIR/$f" "$HOME/$f"
    echo "$f"
done
rm  .ssh/.ssh .xmonad/.xmonad

mkdir ~/.config
cd ~/dotfiles/.config
for f in *
do
  rm "$HOME/.config/$f"
    ln -s "$SCRIPT_DIR/.config/$f" "$HOME/.config/$f"
    echo "$f"
done

mkdir ~/.xmonad
cd ~/dotfiles/.xmonad
for f in *
do
  rm "$HOME/.xmonad/$f"
    ln -s "$SCRIPT_DIR/.xmonad/$f" "$HOME/.xmonad/$f"
    echo "$f"
done
