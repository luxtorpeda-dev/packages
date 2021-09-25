#!/bin/bash

# CLONE PHASE
git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg
pushd ffmpeg
git checkout -f fbb83f3
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "ffmpeg"
./configure --prefix="$pfx" --enable-static --enable-shared
make -j "$(nproc)"
make install
popd

cp -rfv "$pfx/include/"* "/usr/include"
cp -rfv "$pfx/lib/"* "/usr/lib"
