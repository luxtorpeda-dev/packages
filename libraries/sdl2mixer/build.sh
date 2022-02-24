#!/bin/bash

# CLONE PHASE
git clone https://github.com/libsdl-org/SDL_mixer.git sdl2_mixer
pushd sdl_mixer
git checkout -f da75a58
popd

# BUILD PHASE
pushd "sdl2_mixer"
./configure --disable-static --prefix="$pfx" --enable-music-midi-fluidsynth --enable-music-midi-fluidsynth-shared
make -j "$(nproc)"
popd

cp -rfv "$pfx/lib/"* /usr/lib
cp -rfv "$pfx/include/"* /usr/include
