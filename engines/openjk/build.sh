#!/bin/bash

# CLONE PHASE
git clone https://github.com/JACoders/OpenJK.git source
pushd source
git checkout 24c5b27
popd

# BUILD PHASE
mkdir -p tmp
pushd source
mkdir build
cd build
cmake \
    -DBuildJK2SPEngine=ON \
    -DBuildJK2SPGame=ON \
    -DBuildJK2SPRdVanilla=ON \
    -DCMAKE_INSTALL_PREFIX=../../tmp \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
