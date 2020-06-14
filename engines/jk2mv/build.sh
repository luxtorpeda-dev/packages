#!/bin/bash

# CLONE PHASE
git clone https://github.com/mvdevs/jk2mv.git source
pushd source
git checkout 11a108e
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
cp -rfv tmp/JediAcademy/* "$diststart/6020/dist/"
