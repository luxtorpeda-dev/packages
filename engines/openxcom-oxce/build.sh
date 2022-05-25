#!/bin/bash

# CLONE PHASE
git clone https://github.com/MeridianOXC/OpenXcom.git source
pushd source
git checkout a4f9310
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DDEV_BUILD=OFF \
    -DBUILD_PACKAGE=OFF \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/bin/"* "$diststart/common/dist"
cp -rfv ./assets/*.sh "$diststart/common/dist"
