#!/bin/bash

# CLONE PHASE
git clone https://github.com/jbeder/yaml-cpp.git yaml-cpp
pushd yaml-cpp
git checkout -f 0579ae3
popd

# BUILD PHASE
pushd yaml-cpp
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd
