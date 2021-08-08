#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/coelckers/gzdoom.git source
pushd source
git checkout 347324e
git revert e63f3e394c9dd4e38d693b25d7b972dd8f517a7c
git am < ../patches/0001-Workaround-for-missing-PRId64.patch
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
popd

git clone https://github.com/coelckers/ZMusic.git zmusic
pushd zmusic
git checkout -f 9097591
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "fluidsynth"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

pushd "zmusic"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DFLUIDSYNTH_INCLUDE_DIR="$pfx/include" \
    -DFLUIDSYNTH_LIBRARIES="$pfx/lib64" \
    ..
make -j "$(nproc)" install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"

cp -rfv "source/build"/{gzdoom,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv "$pfx/lib/libzmusic.so" "$diststart/common/dist/lib"
cp -rfv "$pfx/lib64"/libfluidsynth.so* "$diststart/common/dist/lib"
cp -rfv assets/* "$diststart/common/dist/"
