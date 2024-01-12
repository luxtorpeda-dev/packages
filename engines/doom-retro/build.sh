#!/bin/bash

export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/bradharding/doomretro.git source
pushd source
git checkout 7c788ad
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/doomretro" "$diststart/common/dist/"
cp -rfv "source/build/doomretro.wad" "$diststart/common/dist/"

cp -rfv assets/* "$diststart/common/dist/"
