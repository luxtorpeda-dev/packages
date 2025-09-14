#!/bin/bash

# CLONE PHASE
git clone https://github.com/coelckers/ZMusic.git zmusic
pushd zmusic
git checkout -f ac3e232
popd

# BUILD PHASE
pushd "zmusic"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

