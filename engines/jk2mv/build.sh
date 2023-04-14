#!/bin/bash

# CLONE PHASE
git clone https://github.com/mvdevs/jk2mv.git source
pushd source
git checkout fc18d90
git submodule update --init --recursive
popd

mkdir -p tmp
# BUILD PHASE
pushd source
mkdir building
cd building
cmake \
    -DCMAKE_INSTALL_PREFIX=../../tmp \
    -DUseInternalMiniZip=ON \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv tmp/* "$diststart/6030/dist/"
