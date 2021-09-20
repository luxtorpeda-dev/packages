#!/bin/bash

# CLONE PHASE
git clone https://github.com/libsdl-org/sdl12-compat.git sdl12compat
pushd sdl12compat
git checkout -f a98590a
popd

# BUILD PHASE
pushd "sdl12compat"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd
