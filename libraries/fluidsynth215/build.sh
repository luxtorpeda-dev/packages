#!/bin/bash

# CLONE PHASE
git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 6776569
popd

# BUILD PHASE
pushd "fluidsynth"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

cp -rfv "$pfx/include/"* "/usr/include"
cp -rfv "$pfx/lib64/"* "/usr/lib"
