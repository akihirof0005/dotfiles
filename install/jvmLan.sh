#!/bin/bash

JVM_FLAG=$(cat config.json | jq .languages.jvm.enable)
JVM_VER=$(cat config.json | jq -r .languages.jvm.version)
JVM_MODULES=$(cat config.json | jq -r .languages.jvm.modules[] | tr '\n' ' ')

if [ $JVM_FLAG ]; then
  curl -s "https://get.sdkman.io" | bash
  source ~/.sdkman/bin/sdkman-init.sh

  if [ "$(uname)" == 'Darwin' ]; then
    if [ "$(uname -m)" == 'arm64' ]; then
      sdk install java $JVM_VER-zulu
    else
      sdk install java $JVM_VER.9-ms
    fi
  else
    sdk install java $JVM_VER-ms
  fi
sdk install $JVM_MODULES
fi
