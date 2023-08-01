#!/bin/bash

# CLONE PHASE
git clone https://github.com/EasyRPG/Player.git source
pushd source
git checkout -f 281be71
git submodule update --init --recursive
popd

git clone https://github.com/EasyRPG/liblcf.git liblcf
pushd liblcf
git checkout -f 01b73de
popd

# BUILD PHASE
pushd liblcf
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_TOOLCHAIN_FILE="$VCPKG_SRC_PATH/scripts/buildsystems/vcpkg.cmake" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    -DPLAYER_ENABLE_TESTS=OFF \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/bin/easyrpg-player" "$diststart/common/dist/"
cp -rfv "$pfx/lib"/*.so* "$diststart/common/dist/lib"
cp -rfv assets/*.sh "$diststart/common/dist/"
