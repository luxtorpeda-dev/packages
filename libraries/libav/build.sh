#!/bin/bash

# CLONE PHASE
git clone https://github.com/libav/libav.git libav
pushd libav
git checkout -f df744e3
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "libav"
./configure --prefix="$pfx" --enable-static --enable-shared
make -j "$(nproc)"
make install
popd
