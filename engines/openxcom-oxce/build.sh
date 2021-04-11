#!/bin/bash

# CLONE PHASE
git clone https://github.com/MeridianOXC/OpenXcom.git source
pushd source
git checkout 119283d
popd

git clone https://github.com/ferzkopp/SDL_gfx.git sdl_gfx
pushd sdl_gfx
git checkout -f 0df23ee
popd

git clone https://github.com/jbeder/yaml-cpp.git yaml-cpp
pushd yaml-cpp
git checkout -f 98acc5a
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "sdl_gfx"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd yaml-cpp
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

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
mkdir -p "$diststart/common/dist/lib"

cp -rfv "$pfx/lib/"*.so* "$diststart/common/dist/lib"
cp -rfv "source/build/bin/"* "$diststart/common/dist"

cp -rfv ./assets/*.sh "$diststart/common/dist"
