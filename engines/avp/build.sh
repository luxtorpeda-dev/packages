#!/bin/bash

# CLONE PHASE
git clone https://github.com/neuromancer/avp.git source
pushd source
git checkout 2d57747
popd
git clone https://github.com/MrAlert/sdlcl sdlcl
pushd sdlcl
git checkout 85ca5537
popd
git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg
pushd ffmpeg
git checkout -f 523da8ea
git submodule update --init --recursive
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE

# build ffmpeg
# Steam Runtime is missing: libswresample, libavresample
pushd "ffmpeg"
./configure --prefix="$pfx" --enable-static --enable-shared
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
popd

pushd "sdlcl"
make
popd

# COPY PHASE
cp -rfv "source/build/avp" "$diststart/3730/dist/avp"
cp -rfv "assets/run-avp.sh" "$diststart/3730/dist/"
cp -rfv "sdlcl/libSDL-1.2.so.0" "$diststart/3730/dist/"
