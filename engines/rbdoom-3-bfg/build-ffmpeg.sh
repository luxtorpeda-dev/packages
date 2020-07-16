#!/bin/bash

readonly pfx="$PWD/local"

# build ffmpeg
# Steam Runtime is missing: libswresample, libavresample
pushd "ffmpeg"
./configure --prefix="$pfx" --enable-static --enable-shared
make -j "$(nproc)"
make install
popd
