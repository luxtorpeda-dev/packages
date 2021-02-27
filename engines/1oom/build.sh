#!/bin/bash

# CLONE PHASE
git clone https://gitlab.com/Tapani_/1oom.git source
pushd source
git checkout -f 8926f6470cb1dce19049392b7d0fbd5e598ebbe6
popd


git clone https://github.com/SDL-mirror/SDL_mixer.git SDL_mixer
pushd SDL_mixer
git checkout -f release-2.0.4
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
pushd "SDL_mixer"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd source
autoreconf -fi
mkdir build
cd build
../configure --disable-hwsdl1 -prefix="$pfx"
make -j "$(nproc)"
popd

# COPY PHASE

mkdir -p "$diststart/410970/dist/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/410970/dist/lib"
cp -rfv source/build/src/1oom_classic_sdl2 "$diststart/410970/dist/"
