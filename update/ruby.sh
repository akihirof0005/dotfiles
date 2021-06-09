#!/bin/zsh

if [ RUBY_FLAG ]; then
  rbenv update
  gem update
  gem update --system
fi
