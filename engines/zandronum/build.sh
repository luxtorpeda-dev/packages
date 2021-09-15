#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/TorrSamaho/zandronum.git source
pushd source
git checkout 99a19d7
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
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

cp -rfv "source/build"/{zandronum,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv "$pfx/lib64"/libfluidsynth.so* "$diststart/common/dist/lib"
cp -rfv assets/* "$diststart/common/dist/"
