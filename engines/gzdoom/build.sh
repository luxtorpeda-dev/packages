#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/coelckers/gzdoom.git source
pushd source
git checkout 04e53b8
popd

git clone https://github.com/coelckers/ZMusic.git zmusic
pushd zmusic
git checkout -f 9097591
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "zmusic"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=/usr/bin/gcc-9 \
    -DCMAKE_CXX_COMPILER=/usr/bin/g++-9 \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=/usr/bin/gcc-9 \
    -DCMAKE_CXX_COMPILER=/usr/bin/g++-9 \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build"/{gzdoom,soundfonts,*.pk3} "$diststart/common/dist/"
