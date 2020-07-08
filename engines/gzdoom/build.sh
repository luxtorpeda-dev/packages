#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/coelckers/gzdoom.git source
pushd source
git checkout 04e53b8
git am < ../patches/0001-Workaround-for-missing-PRId64.patch
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
cp -rfv "source/build"/{gzdoom,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv "$pfx/lib/libzmusiclite.so" "$diststart/common/dist/"
