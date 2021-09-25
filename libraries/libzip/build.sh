#!/bin/bash

# CLONE PHASE
git clone https://github.com/nih-at/libzip.git libzip
pushd libzip
git checkout -f dcd9a0b
popd

# BUILD PHASE
pushd libzip
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd
