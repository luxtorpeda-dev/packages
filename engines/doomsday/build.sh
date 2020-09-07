#!/bin/bash

# CLONE PHASE
git clone https://github.com/skyjake/Doomsday-Engine.git source
pushd source
git checkout -f 648c6bb
git submodule update --init --recursive
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PATH="$pfx/qt5/bin:$PATH"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib64/pkgconfig"

pushd "fluidsynth"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

pushd "fluidsynth"
rm -rf build
mkdir -p build
cd build
cmake \
    ..
make -j "$(nproc)" install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/dlib"
mkdir -p "$diststart/common/dist/lib/doomsday"
cp -rfv "$pfx/usr/bin/" "$diststart/common/dist/bin"
cp -rfv "$pfx/usr/lib/x86_64-linux-gnu/"*.so* "$diststart/common/dist/dlib"
cp -rfv "$pfx/lib64/"*.so* "$diststart/common/dist/dlib"
cp -rfv "$pfx/usr/lib/x86_64-linux-gnu/doomsday/"*.so* "$diststart/common/dist/lib/doomsday"
cp -rfv "$pfx/usr/share/doomsday/"* "$diststart/common/dist/lib/doomsday"
cp -rfv "assets"/* "$diststart/common/dist"
