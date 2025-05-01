#!/bin/bash

# CLONE PHASE
git clone https://github.com/DanielGibson/SkinDeep.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source/neo
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX=../../../tmp \
    -DCMAKE_PREFIX_PATH=../../../tmp \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv tmp/bin/* "$diststart/301280/dist/"

cp -rfv assets/* "$diststart/301280/dist/"
