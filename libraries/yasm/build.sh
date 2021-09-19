#!/bin/bash

# CLONE PHASE
git clone https://github.com/yasm/yasm.git yasm
pushd yasm
git checkout -f ba463d3
popd

# BUILD PHASE
pushd "yasm"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="/usr" \
    -DCMAKE_INSTALL_LIBDIR="lib" \
    -DBUILD_SHARED_LIBS=OFF \
    ..
make -j "$(nproc)"
make install
popd
