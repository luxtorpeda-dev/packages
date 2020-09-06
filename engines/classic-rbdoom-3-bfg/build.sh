#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/MadDeCoDeR/Classic-RBDOOM-3-BFG.git source
pushd source
git checkout 99c9d86
popd

git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg
pushd ffmpeg
git checkout -f 523da8ea
git submodule update --init --recursive
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

readonly pfx="$PWD/local"
readonly tmp="$PWD/tmp"
mkdir -p "$pfx"
mkdir -p "$tmp"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
./build-ffmpeg.sh

pushd "openal"
rm -rf build
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd "SDL"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
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
    -DCMAKE_PREFIX_PATH="$pfx" \
    ../neo
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/build/DoomBFA" "$diststart/208200/dist/DoomBFA"
mkdir -p "$diststart/208200/dist/lib"
cp -rfv "$pfx/"lib/*.so* "$diststart/208200/dist/lib/"
cp -rfv ./assets/* "$diststart/208200/dist/"
cp -rfv ./source/base "$diststart/208200/dist/updatedbase"
