#!/bin/bash

# CLONE PHASE
git clone https://github.com/libretro/REminiscence source
pushd source
git checkout 6888c01
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBUILD_CORE=OFF \
    -DUSE_MODPLUG=OFF \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
