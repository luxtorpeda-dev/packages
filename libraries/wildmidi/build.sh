#!/bin/bash

# CLONE PHASE
git clone https://github.com/Mindwerks/wildmidi.git wildmidi
pushd wildmidi
git checkout -f 99dc051
popd

# BUILD PHASE
pushd wildmidi
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
