#!/bin/bash

# CLONE PHASE
git clone https://github.com/KhronosGroup/glslang.git
pushd glslang
git checkout -f 2fb89a0
git submodule update --init --recursive
popd

# BUILD PHASE
pushd glslang
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j "$(nproc)"
make install
popd
