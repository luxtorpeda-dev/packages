#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interrupt/systemshock.git source
pushd source
git checkout 7da4d1b
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig:$pfx/lib64/pkgconfig"

# BUILD PHASE

pushd source
mkdir build
cd build
cmake \
    -DENABLE_SDL2=ON \
    -DENABLE_FLUIDSYNTH=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DFLUIDSYNTH_INCLUDE_DIR="$pfx/include" \
    -DFLUIDSYNTH_LIBRARIES="$pfx/lib64/libfluidsynth.so.2.3.3" \
    ..
make -j "$(nproc)" systemshock
popd

# COPY PHASE
mkdir -p "$diststart/410700/dist/lib"
mkdir -p "$diststart/410700/dist/res"
cp -rfv "source/build/systemshock" "$diststart/410700/dist/"
cp -rfv "source/shaders" "$diststart/410700/dist"
cp -rfv assets/* "$diststart/410700/dist/"
