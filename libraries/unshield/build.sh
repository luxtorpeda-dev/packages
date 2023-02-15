#!/bin/bash

# CLONE PHASE
git clone https://github.com/twogood/unshield.git
pushd unshield
git checkout -f c5d3560
popd

# BUILD PHASE
pushd unshield
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/include/"* "/usr/include"
cp -rfv "$pfx/lib/"* "/usr/lib"
