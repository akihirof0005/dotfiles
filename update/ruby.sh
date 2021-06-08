RUBY_FLAG=$(cat ~/dotfiles/config.json | jq .languages.ruby.enable)
RUBY_VER=$(cat ~/dotfiles/config.json | jq -r .languages.ruby.version)
RUBY_MODULES=$(cat ~/dotfiles/config.json | jq -r .languages.ruby.modules[] | tr '\n' ' ')

if [ RUBY_FLAG ]; then
  rbenv update
  gem update
  gem update --system
fi
