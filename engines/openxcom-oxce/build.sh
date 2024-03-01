#!/bin/bash

# CLONE PHASE
git clone https://github.com/MeridianOXC/OpenXcom.git source
pushd source
git checkout "$COMMIT_HASH"
popd

cp -rfv "$pfx/lib/pkgconfig/sdl12_compat.pc" "$pfx/lib/pkgconfig/sdl.pc"

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
