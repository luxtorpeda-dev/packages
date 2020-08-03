#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenMW/openmw source
pushd source
git checkout -f 0abcb54
git submodule update --init --recursive
popd

git clone https://github.com/jedisct1/libsodium.git libsodium
pushd libsodium
git checkout -f 1.0.18
popd

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"

pushd "libsodium"
./configure
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -GNinja \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
