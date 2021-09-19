#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information

# CLONE PHASE
git clone https://github.com/SanyaWaffles/WIGZDoom.git source
pushd source
git checkout ff8961e
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"

cp -rfv "source/build"/{wigzdoom,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
