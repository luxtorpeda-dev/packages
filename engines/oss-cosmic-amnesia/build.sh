#!/bin/bash

# CLONE PHASE
git clone https://github.com/OSS-Cosmic/AmnesiaTheDarkDescent.git source
pushd source
git checkout -f 6b387d7

git clone https://github.com/OSS-Cosmic/The-Forge.git external/The-Forge
pushd external/The-Forge
git checkout -f 80ddbfe
popd
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DAMNESIA_GAME_DIRECTORY:STRING='' \
    -G Ninja
    ..
ninja
popd

# COPY PHASE
cp -rfv "source/build/"* "$diststart/57300/dist"
cp -rfv "assets/"* "$diststart/57300/dist"
