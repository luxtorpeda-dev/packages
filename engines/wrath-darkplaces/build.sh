#!/bin/bash

# CLONE PHASE
git clone https://github.com/KillPixelGames/wrath-darkplaces.git source
pushd source
git checkout -f 2e4c399
git submodule update --init --recursive
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
pushd "source"
make sdl2-release -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build-obj/release/darkplaces-sdl" "$diststart/1000410/dist/"
