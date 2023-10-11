#!/bin/bash

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information
# CLONE PHASE
git clone https://github.com/coelckers/gzdoom.git source
pushd source
git checkout a6c5ccc
popd

hg clone https://heptapod.host/jp-lebreton/wadsmoosh
pushd wadsmoosh
hg update -r 1.3
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
cp -rfv "source/build"/{gzdoom,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
cp -rfv ./wadsmoosh "$diststart/common/dist/wadsmoosh-branch-default"
ln -rsf "$diststart/common/dist/lib/libfluidsynth.so.3" "$diststart/common/dist/lib/libfluidsynth.so.2"
