#!/bin/zsh

if [ $RUBY_FLAG ]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv --version
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  rbenv install $RUBY_VER
  rbenv global $RUBY_VER

[ -z "$RBENV_ROOT" ] && export RBENV_ROOT="$HOME/.rbenv"
mkdir -p "$RBENV_ROOT/plugins"

  git clone https://github.com/rkh/rbenv-update.git "$RBENV_ROOT/plugins/rbenv-update"
  gem install ${RUBY_MODULES}
  cd ~/dotfiles
fi
