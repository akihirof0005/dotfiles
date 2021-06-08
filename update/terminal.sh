if [ "$(uname)" == 'Darwin' ]; then
  if [ "$(uname -m)" == 'arm64' ]; then
    cd $HOME/src/system/alacritty
    git pull
    make app
    cp -r target/release/osx/Alacritty.app /Applications/
    cd
  fi
fi

