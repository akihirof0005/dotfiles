git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv --version
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 3.0.0
rbenv global 3.0.0
[ -z "$RBENV_ROOT" ] && export RBENV_ROOT="$HOME/.rbenv"
mkdir -p "$RBENV_ROOT/plugins"
git clone https://github.com/rkh/rbenv-update.git "$RBENV_ROOT/plugins/rbenv-update"
gem install solargraph
cd ~/dotfiles
