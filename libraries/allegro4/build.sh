#!/bin/bash

# CLONE PHASE
git clone https://github.com/liballeg/allegro5.git allegro4
pushd allegro4
git checkout -f 8a386b2
popd

# BUILD PHASE
pushd allegro4
mkdir -p build
cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DWANT_DOCS=OFF
make -j "$(nproc)"
make install
popd
