#!/bin/bash

# CLONE PHASE
git clone https://github.com/libsdl-org/sdl12-compat.git sdl12compat
pushd sdl12compat
git checkout -f 4388700
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

pushd "sdl12compat"
rm -rf build
mkdir -p build
cd build
cmake \
    ..
make -j "$(nproc)" install
popd

cp -rfv "$pfx/lib/"* /usr/lib
cp -rfv "$pfx/include/"* /usr/include
