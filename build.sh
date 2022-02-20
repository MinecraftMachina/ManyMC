#!/bin/bash
set -eu -o pipefail -E

rm -r "build" "dist" || true
mkdir "build"
JAVA_HOME=$(/usr/libexec/java_home -v 1.8 -a arm64) \
    cmake \
    -B "build" \
    -DCMAKE_C_COMPILER="/usr/bin/clang " \
    -DCMAKE_CXX_COMPILER="/usr/bin/clang++ " \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX:PATH="$PWD/dist/" \
    -DLauncher_LAYOUT=mac-bundle \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=10.7 \
    -DLauncher_META_URL="https://minecraftmachina.github.io/meta-multimc-arm64/" \
    -DLauncher_EMBED_SECRETS=$(test -d secrets && echo "ON" || echo "OFF")
make -C "build" -j$(sysctl -n hw.physicalcpu) install
chmod -R u+w "dist/ManyMC.app"
find "dist/ManyMC.app" -depth -exec codesign -f -s - {} \;
codesign -f --no-strict -s - --entitlements "entitlements.plist" "dist/ManyMC.app"
