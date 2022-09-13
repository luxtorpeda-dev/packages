#!/bin/bash

# CLONE PHASE
git clone https://github.com/libsdl-org/SDL_mixer.git sdl2_mixer
pushd sdl2_mixer
git checkout -f 75f3181
popd

# BUILD PHASE
pushd "sdl2_mixer"
./configure --disable-static --prefix="$pfx" --enable-music-midi-fluidsynth --enable-music-midi-fluidsynth-shared
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/lib/"* /usr/lib
cp -rfv "$pfx/include/"* /usr/include
