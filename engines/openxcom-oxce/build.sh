#!/bin/bash

apt-get -y install libsdl1.2-dev #workaround for building not finding the sdl12compat, engine will use sdl12compat for the actual library

# CLONE PHASE
git clone https://github.com/MeridianOXC/OpenXcom.git source
pushd source
git checkout 349fbe4
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
