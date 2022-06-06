#!/bin/bash

# CLONE PHASE
git clone https://github.com/libsdl-org/SDL_image.git sdl2_image
pushd sdl2_image
git checkout -f ab2a9c6
popd

# BUILD PHASE
pushd "sdl2_image"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/lib/"* /usr/lib
cp -rfv "$pfx/include/"* /usr/include
