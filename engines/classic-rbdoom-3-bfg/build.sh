#!/bin/bash

# CLONE PHASE
git clone https://github.com/MadDeCoDeR/Classic-RBDOOM-3-BFG.git source
pushd source
git checkout cf9c2fa
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
    ../neo
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/build/DoomBFA" "$diststart/208200/dist/DoomBFA"
cp -rfv ./assets/* "$diststart/208200/dist/"
cp -rfv ./source/base "$diststart/208200/dist/updatedbase"
cp "source/neo/libs/openal-soft/Linuxx64/libopenal.so" "$diststart/208200/dist/lib"
cp "source/neo/libs/openal-soft/Linuxx64/libopenal.so" "$diststart/208200/dist/lib/libopenal.so.1"
