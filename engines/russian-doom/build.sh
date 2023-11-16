#!/bin/bash

mkdir local
export pfx="$PWD/local"

# CLONE PHASE
git clone https://github.com/Russian-Doom/russian-doom.git source
pushd source
git checkout e97fdcb
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
make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/base"
cp -rfv source/build/src/russian-* "$diststart/common/dist/"
cp -rfv "$pfx/share/russian-doom/"* "$diststart/common/dist/base/"
cp -rfv assets/* "$diststart/common/dist/"
