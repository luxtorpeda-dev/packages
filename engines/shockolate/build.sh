#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interrupt/systemshock.git source
pushd source
git checkout 9de43cc
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE

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
cp -rfv "source/build/systemshock" "$diststart/410700/dist/"
cp -rfv "source/shaders" "$diststart/410700/dist"
cp -rfv assets/* "$diststart/410700/dist/"
