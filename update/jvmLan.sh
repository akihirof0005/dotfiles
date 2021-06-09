#!/bin/zsh

if [ JVM_FLAG ]; then

export SDKMAN_DIR=$HOME"/.sdkman"
[[ -s $HOME"/.sdkman/bin/sdkman-init.sh" ]] && source $HOME"/.sdkman/bin/sdkman-init.sh"
sdk update
sdk selfupdate
fi
