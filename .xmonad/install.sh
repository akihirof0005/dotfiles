cd  ~/.xmonad
stack install
chmod a+x build
xmonad --recompile
cp $HOME/dotfiles/.xmonad/xmonad.desktop  /usr/share/xsessions/
