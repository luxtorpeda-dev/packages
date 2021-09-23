#!/bin/bash

# CLONE PHASE
git clone https://github.com/jedisct1/libsodium.git libsodium
pushd libsodium
git checkout -f stable
popd

# BUILD PHASE
pushd "libsodium"
./configure
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd
