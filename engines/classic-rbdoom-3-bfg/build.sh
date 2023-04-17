#!/bin/bash

# CLONE PHASE
git clone https://github.com/MadDeCoDeR/Classic-RBDOOM-3-BFG.git source
pushd source
git checkout cf9c2fa
git am < ../patches/e90b31dcc2901f4d8390f8089a8bd43f88c575ea.patch
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout ae4eacf
popd

# BUILD PHASE
pushd "openal"
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir build
cd build
cmake \
    -G "Eclipse CDT4 - Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DSDL2=ON \
    -DFFMPEG_ROOT="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DUSE_PRECOMPILED_HEADERS=OFF \
    ../neo
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/build/DoomBFA" "$diststart/208200/dist/DoomBFA"
cp -rfv ./assets/* "$diststart/208200/dist/"
cp -rfv ./source/base "$diststart/208200/dist/updatedbase"
cp -rfv "/usr/local/lib/libopenal.so.1.21.1" "$diststart/208200/dist/lib/libopenal.so"
cp -rfv "/usr/local/lib/libopenal.so.1.21.1" "$diststart/208200/dist/lib/libopenal.so.1"
