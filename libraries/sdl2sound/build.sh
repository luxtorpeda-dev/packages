#!/bin/bash

# CLONE PHASE
git clone https://github.com/icculus/SDL_sound.git sdl2_sound
pushd sdl2_sound
git checkout -f 6cb07c2
popd

# BUILD PHASE
pushd "sdl2_sound"
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
