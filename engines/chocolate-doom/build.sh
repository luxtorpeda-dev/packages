#!/bin/bash

# CLONE PHASE
git clone https://github.com/chocolate-doom/chocolate-doom.git source
pushd source
git checkout f700744
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "fluidsynth"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

pushd "source"
./autogen.sh
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/lib64"/libfluidsynth.so* "$diststart/common/dist/lib"
cp -rfv "$pfx/usr/local/bin/"* "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
