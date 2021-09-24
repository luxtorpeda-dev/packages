#!/bin/bash

# CLONE PHASE
git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
popd

# BUILD PHASE
pushd "fluidsynth"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -Bbuild32 \
    -DCMAKE_C_FLAGS=-m32 \
    -DCMAKE_CXX_FLAGS=-m32 \
    -DCMAKE_SYSTEM_LIBRARY_PATH=/usr/lib32 \
    ..
make -j "$(nproc)" install
popd

cp -rfv "$pfx/include/"* "/usr/include"
cp -rfv "$pfx/lib/"* "/usr/lib"
