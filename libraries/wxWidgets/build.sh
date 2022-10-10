#!/bin/bash

# CLONE PHASE
git clone https://github.com/wxWidgets/wxWidgets.git wxWidgets
pushd wxWidgets
git checkout 9c0a8be
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "wxWidgets"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

cp -rfv "$pfx/include/"* "/usr/include"
cp -rfv "$pfx/lib/"*.so* "/usr/lib"

