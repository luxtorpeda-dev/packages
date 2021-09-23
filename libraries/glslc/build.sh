#!/bin/bash

# CLONE PHASE
git clone https://github.com/KhronosGroup/SPIRV-Tools.git spirv-tools
pushd spirv-tools
git checkout -f 1fbed83
popd

git clone https://github.com/google/shaderc.git
pushd shaderc
git checkout -f d0d8d7e
git submodule update --init --recursive
popd

# BUILD PHASE
pushd spirv-tools
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j "$(nproc)"
make install
popd

pushd shaderc
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DSHADERC_SKIP_EXAMPLES=ON -DSHADERC_SKIP_TESTS=ON ..
make -j "$(nproc)"
make install
popd
