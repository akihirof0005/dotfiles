# alacritty install
if [ "$(uname)" == 'Darwin' ]; then
  if [ "$(uname -m)" == 'arm64' ]; then
    mkdir -p $HOME/src/system
    git clone https://github.com/alacritty/alacritty $HOME/src/system/alacritty
    cd $HOME/src/system/alacritty
    make app
    cp -r target/release/osx/Alacritty.app /Applications/
    cd
    brew install tmux
  else
    brew install alacritty
    brew install tmux
  fi
  ln -s $HOME/dotfiles/alacritty.yml.mac $HOME/.config/alacritty/alacritty.yml
else
  ln -s $HOME/dotfiles/alacritty.yml.linux $HOME/.config/alacritty/alacritty.yml
fi

