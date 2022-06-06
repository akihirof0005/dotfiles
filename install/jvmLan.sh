#!/bin/zsh

if [ $JVM_FLAG ]; then
  curl -s "https://get.sdkman.io" | bash
  source ~/.sdkman/bin/sdkman-init.sh

  if [ "$(uname)" = 'Darwin' ]; then
    if [ "$(uname -m)" = 'arm64' ]; then
      sdk install java $JVM_VER-zulu
    else
      sdk install java $JVM_VER.9-ms
    fi
  else
    sdk install java $JVM_VER-ms
  fi
sdk install $JVM_MODULES
fi
