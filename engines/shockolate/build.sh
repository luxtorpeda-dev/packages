#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interrupt/systemshock.git source
pushd source
git checkout 7da4d1b
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig:$pfx/lib64/pkgconfig"

# BUILD PHASE
pushd "fluidsynth"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

pushd source
mkdir build
cd build
cmake \
    -DENABLE_SDL2=ON \
    -DENABLE_FLUIDSYNTH=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DFLUIDSYNTH_INCLUDE_DIR="$pfx/include" \
    -DFLUIDSYNTH_LIBRARIES="$pfx/lib64" \
    ..
make -j "$(nproc)" systemshock
popd

# COPY PHASE
mkdir -p "$diststart/410700/dist/lib"
cp -rfv build/systemshock "$diststart/410700/dist/"
cp -rfv "$pfx/lib64"/libfluidsynth.so* "$diststart/410700/dist/lib"
