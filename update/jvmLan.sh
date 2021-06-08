#!/bin/bash

JVM_FLAG=$(cat ~/dotfiles/config.json | jq .languages.jvm.enable)
JVM_VER=$(cat ~/dotfiles/config.json | jq -r .languages.jvm.version)
JVM_MODULES=$(cat ~/dotfiles/config.json | jq -r .languages.jvm.modules[] | tr '\n' ' ')

if [ JVM_FLAG ]; then

export SDKMAN_DIR=$HOME"/.sdkman"
[[ -s $HOME"/.sdkman/bin/sdkman-init.sh" ]] && source $HOME"/.sdkman/bin/sdkman-init.sh"
sdk update
sdk selfupdate
fi
