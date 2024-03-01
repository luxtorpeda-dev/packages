#!/bin/bash

mkdir local
export pfx="$PWD/local"

# CLONE PHASE
git clone https://github.com/Russian-Doom/russian-doom.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DRD_BUILD_PORTABLE=ON \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/base"
cp -rfv source/build/src/russian-* "$diststart/common/dist/"
cp -rfv "$pfx/base/"* "$diststart/common/dist/base/"
cp -rfv assets/* "$diststart/common/dist/"
