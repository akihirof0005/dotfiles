#!/usr/bin/bash
curl -s "https://get.sdkman.io" | bash
source ~/.sdkman/bin/sdkman-init.sh
sdk install java 14.0.2.j9-adpt
sdk install gradle
sdk install kotlin
