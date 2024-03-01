#!/bin/bash

# CLONE PHASE
git clone https://github.com/JNechaevsky/inter-doom.git source
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
    -DBUILD_PORTABLE=ON \
    ..
make -j "$(nproc)"
make
popd

# COPY PHASE
cp -rfv source/build/src/inter-* "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
