#!/bin/bash

# CLONE PHASE
git clone https://github.com/coelckers/prboom-plus.git source
pushd source
git checkout 9b8a632
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

pushd "source/prboom2"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/lib64"/libfluidsynth.so* "$diststart/common/dist/lib"
cp -rfv "source/prboom2/build/prboom-plus" "$diststart/common/dist/"
cp -rfv "source/prboom2/build/prboom-plus.wad" "$diststart/common/dist/"
cp -rfv "source/prboom2/build/prboom-plus-game-server" "$diststart/common/dist/"
cp -rfv "assets/run-prboom-plus.sh" "$diststart/common/dist/"
