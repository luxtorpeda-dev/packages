#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information
# CLONE PHASE
git clone https://github.com/HandsOfNecromancy/HandsOfNecromancy2-Engine.git source
pushd source
git checkout "$COMMIT_HASH"
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
cp -rfv "source/build"/{engine-classic,soundfonts,*.pk3} "$diststart/2706450/dist/"
cp -rfv assets/* "$diststart/2706450/dist/"
ln -rsf "$diststart/2706450/dist/lib/libfluidsynth.so.3" "$diststart/2706450/dist/lib/libfluidsynth.so.2"
