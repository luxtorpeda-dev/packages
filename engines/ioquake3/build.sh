#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/ioq3 - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/ioquake/ioq3.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX=../../../tmp \
    -DCMAKE_PREFIX_PATH=../../../tmp \
    -DBUILD_SERVER=OFF \
    -DUSE_MUMBLE=OFF \
    -DUSE_VOIP=OFF \
    -DUSE_INTERNAL_LIBS=OFF \
    ..
cmake --build build
popd

# COPY PHASE
cp -rfv source/build/* "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
