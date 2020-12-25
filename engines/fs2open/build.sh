#!/bin/bash

# CLONE PHASE
git clone https://github.com/scp-fs2open/fs2open.github.com source
pushd source
git checkout -f af41b5b 
git submodule update --init --recursive
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
mkdir -p build
cd build
export PKG_CONFIG_PATH="$pfx/lib/pkgconfig"
export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
DESTDIR="$tmp" make install
popd

# COPY PHASE
mkdir -p "$diststart/273620/dist/lib/"
cp -rfv "local/"lib/*.so* "$diststart/273620/dist/lib/"
cp -rfv "source/build/bin/fs2_open_20_1_0_x64" "$diststart/273620/dist/fs2_open_x64"
cp -rfv "assets/run-freespace2.sh" "$diststart/273620/dist/run-freespace2.sh"
