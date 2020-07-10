#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenApoc/OpenApoc.git source
pushd source
git checkout -f 9183a08
git submodule update --init --recursive
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f 62a4b7f
git submodule update --init --recursive
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
./build-boost.sh

pushd source
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBUILD_LAUNCHER=OFF \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
