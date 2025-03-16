#!/bin/bash

# CLONE PHASE
git clone https://github.com/fabiangreffrath/taradino.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/taradino "$diststart/238050/dist/rott"
cp -rfv assets/* "$diststart/238050/dist/"

cp -rfv source/build/taradino "$diststart/358410/dist/rott"
cp -rfv assets/* "$diststart/358410/dist/"
