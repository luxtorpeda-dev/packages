#!/bin/bash

# CLONE PHASE
git clone https://github.com/ferzkopp/SDL_gfx.git sdl_gfx
pushd sdl_gfx
git checkout -f 0df23ee
popd

# BUILD PHASE
pushd "sdl_gfx"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd
