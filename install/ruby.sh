git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv --version
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 2.7.2
rbenv global 2.7.2

cd ~/dotfiles
