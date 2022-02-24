#!/bin/bash

apt-get update
apt-get install -y mercurial

# CLONE PHASE
git clone https://github.com/bradharding/doomretro.git source
pushd source
git checkout aec56d2
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
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/doomretro" "$diststart/common/dist/"
cp -rfv "source/build/doomretro.wad" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
cp -rfv ./wadsmoosh "$diststart/common/dist/wadsmoosh-branch-default"
