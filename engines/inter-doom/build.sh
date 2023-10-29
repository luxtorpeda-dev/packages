#!/bin/bash

# CLONE PHASE
git clone https://github.com/JNechaevsky/inter-doom.git source
pushd source
git checkout c0e163e
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBUILD_PORTABLE=ON \
    ..
make -j "$(nproc)"
make
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/base"
cp -rfv source/build/src/inter-* "$diststart/common/dist/"
cp -rfv "$pfx/base/"* "$diststart/common/dist/base/"
cp -rfv assets/* "$diststart/common/dist/"
