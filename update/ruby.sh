RUBY_FLAG=$(cat config.json | jq .languages.ruby.enable)
RUBY_VER=$(cat config.json | jq -r .languages.ruby.version)
RUBY_MODULES=$(cat config.json | jq -r .languages.ruby.modules[] | tr '\n' ' ')

if [ RUBY_FLAG ]; then
  rbenv update
  gem update
  gem update --system
fi
