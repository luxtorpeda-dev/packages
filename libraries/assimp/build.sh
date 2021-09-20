#!/bin/bash

# CLONE PHASE
git clone https://github.com/assimp/assimp.git assimp
pushd assimp
git checkout -f 8f0c6b0
popd

# BUILD PHASE
pushd "assimp"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd
