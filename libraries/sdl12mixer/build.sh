#!/bin/bash

# CLONE PHASE
git clone https://github.com/libsdl-org/SDL_mixer.git sdl_mixer
pushd sdl_mixer
git checkout -f b38fd5e
popd

# BUILD PHASE
pushd "sdl_mixer"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/lib/"* /usr/lib
cp -rfv "$pfx/include/"* /usr/include
