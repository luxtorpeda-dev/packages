#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information

apt-get install -y wget

# CLONE PHASE
git clone https://github.com/TorrSamaho/zandronum.git source
pushd source
git checkout 99a19d7
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
popd

wget https://zandronum.com/essentials/fmod/fmodapi42416linux64.tar.gz
tar -xvf fmodapi42416linux64.tar.gz

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib64/pkgconfig:$pfx/lib/pkgconfig"

# BUILD PHASE
pushd "fmodapi42416linux64"
make install
popd

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
cp -rfv fmodapi42416linux64/api/lib/* "$diststart/common/dist/lib"
cp -rfv fmodapi42416linux64/api/plugins "$diststart/common/dist/lib"
cp -rfv "source/build"/{zandronum,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv "$pfx/lib64"/libfluidsynth.so* "$diststart/common/dist/lib"
cp -rfv assets/* "$diststart/common/dist/"
