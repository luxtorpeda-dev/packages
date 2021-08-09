#!/bin/bash

# CLONE PHASE
git clone https://github.com/EasyRPG/Player.git source
pushd source
git checkout -f 4dd00a6
git submodule update --init --recursive
popd

git clone https://github.com/EasyRPG/liblcf.git liblcf
pushd liblcf
git checkout -f bb9f9e2
popd

git clone https://github.com/unicode-org/icu.git icu
pushd icu
git checkout -f c8bc56e
popd

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib64/pkgconfig:$pfx/lib/pkgconfig"

pushd icu/icu4c/source
./runConfigureICU Linux --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd liblcf
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local;$pfx/root/packages/engines/easyrpg-player/local/" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

# COPY PHASE
