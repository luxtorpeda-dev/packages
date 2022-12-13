#!/bin/bash

# CLONE PHASE
git clone https://github.com/libsdl-org/SDL.git sdl2
pushd sdl2
git checkout -f 8c9beb0
popd

# BUILD PHASE
pushd "sdl2"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

cp -rfv "$pfx/lib/"* /usr/lib
cp -rfv "$pfx/include/"* /usr/include
