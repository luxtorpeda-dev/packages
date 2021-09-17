#!/bin/bash

# CLONE PHASE
git clone https://github.com/bibendovsky/bstone.git source
pushd source
git checkout d329e75
popd

# BUILD PHASE

pushd source
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBSTONE_USE_PCH=OFF \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv "source/build/src/bstone" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
