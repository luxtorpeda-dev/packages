#!/bin/bash

# CLONE PHASE
git clone https://github.com/bradharding/doomretro.git source
pushd source
git checkout 17d1664
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/doomretro" "$diststart/common/dist/"
cp -rfv "source/build/doomretro.wad" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
