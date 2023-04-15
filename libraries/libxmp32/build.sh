#!/bin/bash

# CLONE PHASE
git clone https://github.com/libxmp/libxmp.git libxmp
pushd libxmp
git checkout -f a04bb8f
popd

# BUILD PHASE
export CFLAGS=-m32
pushd libxmp
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd
