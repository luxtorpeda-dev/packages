#!/bin/bash

# CLONE PHASE
git clone https://github.com/google/shaderc.git
pushd shaderc
git checkout -f d0d8d7e
git submodule update --init --recursive
./utils/git-sync-deps
popd

# BUILD PHASE
pushd shaderc
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DSHADERC_SKIP_EXAMPLES=ON -DSHADERC_SKIP_TESTS=ON ..
make -j "$(nproc)"
make install
popd
