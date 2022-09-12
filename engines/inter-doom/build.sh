#!/bin/bash

# CLONE PHASE
git clone https://github.com/JNechaevsky/inter-doom.git source
pushd source
git checkout 092cc7a
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv "$pfx/usr/local/bin/"* "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
