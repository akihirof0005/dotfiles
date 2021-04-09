#!/usr/bin/bash
curl -s "https://get.sdkman.io" | bash
source ~/.sdkman/bin/sdkman-init.sh
if [ "$(uname)" == 'Darwin' ]; then
if [ "$(uname -m)" == 'arm64' ]; then
sdk install java 11.0.10-zulu
fi
else
sdk install java 11.0.10.9-ms
fi
sdk install gradle
sdk install kotlin
