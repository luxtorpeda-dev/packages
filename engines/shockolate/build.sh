#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interrupt/systemshock.git source
pushd source
git checkout 9de43cc
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE

sudo apt-get -y remove libsdl2-2.0-0 libsdl2-dev

pushd source
sudo ./osx-linux/install_32bit_sdl.sh
mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)" systemshock
popd

# COPY PHASE
mkdir -p "$diststart/410700/dist/lib"
cp -rfv "source/build/systemshock" "$diststart/410700/dist/"
cp -rfv "source/shaders" "$diststart/410700/dist"
cp -rfv assets/* "$diststart/410700/dist/"
cp -rfv "source/build_ext/built_sdl/lib/"libSDL2*.so* "$diststart/410700/dist/lib"
cp -rfv "source/build_ext/built_sdl_mixer/lib/"libSDL2*.so* "$diststart/410700/dist/lib"
