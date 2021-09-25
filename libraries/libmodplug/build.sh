#!/bin/bash

# CLONE PHASE
git clone https://github.com/Konstanty/libmodplug.git
pushd libmodplug
git checkout -f d7ba5ef
popd

# BUILD PHASE
pushd "libmodplug"
mkdir -p build
cd build
cmake \
    ..
make -j "$(nproc)" install
popd
