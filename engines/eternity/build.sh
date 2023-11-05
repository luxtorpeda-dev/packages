#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information
# CLONE PHASE
git clone https://github.com/team-eternity/eternitygit source
pushd source
git checkout d699a7d
git submodule update --init
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build"/* "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
