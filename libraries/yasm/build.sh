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
    ..
make -j "$(nproc)"
make install
popd
