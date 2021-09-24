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
