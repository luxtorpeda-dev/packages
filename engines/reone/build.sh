#!/bin/bash

# CLONE PHASE
git clone https://github.com/seedhartha/reone.git source
pushd source
git checkout -f 159d490
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f afb333b7
git submodule update --init --recursive
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
./build-boost.sh

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/32370/dist/lib/"
cp -rfv "local/"{lib,lib64}/*.so* "$diststart/32370/dist/lib/"
cp -rfv "local/bin/"* "$diststart/32370/dist/"
