#!/bin/bash

# CLONE PHASE
git clone https://github.com/RobertBeckebans/RBDOOM-3-BFG.git source
pushd source
git checkout 09c9f25
popd

git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg
pushd ffmpeg
git checkout -f 523da8ea
git submodule update --init --recursive
popd

readonly pfx="$PWD/local"
readonly tmp="$PWD/tmp"
mkdir -p "$pfx"
mkdir -p "$tmp"

# BUILD PHASE
./build-ffmpeg.sh

pushd "source"
mkdir build
cd build
cmake \
    -G "Eclipse CDT4 - Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DSDL2=ON \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ../neo
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/build/RBDoom3BFG" "$diststart/208200/dist/RBDoom3BFG"
mkdir -p "$diststart/208200/dist/lib"
cp -rfv "$pfx/"lib/*.so* "$diststart/208200/dist/lib/"
cp -rfv ./assets/run-rbdoom-3-bfg.sh "$diststart/208200/dist/"
