#!/bin/bash

# CLONE PHASE
git clone https://github.com/lz4/lz4.git lz4
pushd lz4
git checkout -f fdf2ef5
popd

# BUILD PHASE
pushd lz4
make -j "$(nproc)"
DESTDIR="$pfx" make install
make install
popd
