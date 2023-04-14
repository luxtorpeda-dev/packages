#!/bin/bash

# CLONE PHASE
git clone https://github.com/webmproject/libvpx.git libvpx
pushd libvpx
git checkout -f b41ffb5
popd

# BUILD PHASE
pushd "libvpx"
./configure --enable-pic
make -j "$(nproc)"
make install
popd
