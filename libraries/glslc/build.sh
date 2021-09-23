#!/bin/bash

# CLONE PHASE
git clone https://github.com/google/shaderc.git
pushd shaderc
git checkout -f d0d8d7e
git submodule update --init --recursive
popd

# BUILD PHASE
pushd shaderc/glslc
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j "$(nproc)"
make install
popd
