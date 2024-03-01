#!/bin/bash

# CLONE PHASE
git clone https://github.com/afritz1/OpenTESArena source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=ReleaseGeneric \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv assets/* "$diststart/1812290/dist/"
cp -rfv source/data/ "$diststart/1812290/dist/"
cp -rfv source/options/ "$diststart/1812290/dist/"
cp -rfv source/build/otesa "$diststart/1812290/dist/"
