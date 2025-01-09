#!/bin/zsh

if [ RUBY_FLAG ]; then
  cd ~/.rbenv
  git pull origin master

  git -C "$(rbenv root)"/plugins/ruby-build pull origin master
  gem update
  gem update --system
fi
