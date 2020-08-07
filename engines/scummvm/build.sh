#!/bin/bash

# CLONE PHASE
git clone https://github.com/scummvm/scummvm.git scummvm
pushd scummvm
git checkout -f 1478914
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
popd

git clone https://github.com/markjeee/libmad.git mad
pushd mad
git checkout -f c2f96fa
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

pushd "mad"
./configure --prefix="$pfx"
make -j "$(nproc)" install
popd

pushd "source"
./configure --prefix="$pfx"
make -j "$(nproc)" install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/usr/local/bin/" "$diststart/common/dist/"
cp -rfv "$pfx/usr/local/share" "$diststart/common/dist/"
cp -rfv "$pfx/lib64"/libfluidsynth.so* "$diststart/common/dist/lib"
cp -rfv "assets/run-scummvm.sh" "$diststart/common/dist/"
