#!/bin/bash

# CLONE PHASE
git clone https://github.com/cortex-command-community/Cortex-Command-Community-Project-Source.git source
pushd source
git checkout -f 5280ac5
popd

git clone https://github.com/cortex-command-community/Cortex-Command-Community-Project-Data.git data
pushd data
git checkout -f 4f46182
popd

git clone https://github.com/liballeg/allegro5.git allegro4
pushd allegro4
git checkout -f 30aabed
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f afb333b7
git submodule update --init --recursive
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
pushd allegro4
mkdir -p build
cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DWANT_DOCS=OFF
make -j "$(nproc)"
popd

./build-boost.sh


# COPY PHASE
