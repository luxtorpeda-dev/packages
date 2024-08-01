#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information
# CLONE PHASE
git clone https://github.com/Waffle-Iron-Studios/Griddle.git source
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
cp -rfv "source/build"/{rfgzdoom,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"

ln -rsf "$diststart/common/dist/lib/libfluidsynth.so.3" "$diststart/common/dist/lib/libfluidsynth.so.2"
