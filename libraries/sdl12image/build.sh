#!/bin/bash

# CLONE PHASE
git clone https://github.com/libsdl-org/SDL_image.git sdl_image
pushd sdl_image
git checkout -f b312f7a
popd

# BUILD PHASE
pushd "sdl_image"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd
