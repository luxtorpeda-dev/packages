#!/bin/bash

# CLONE PHASE
git clone https://github.com/bibendovsky/bstone.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd source
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBSTONE_USE_PCH=OFF \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/src/bstone/bstone" "$diststart/common/dist"
cp -rfv assets/* "$diststart/common/dist"
