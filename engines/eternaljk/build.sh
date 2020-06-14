#!/bin/bash

# CLONE PHASE
git clone https://github.com/eternalcodes/EternalJK.git source
pushd source
git checkout 0396e4a
popd

# BUILD PHASE
mkdir -p tmp
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX=../../tmp \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
