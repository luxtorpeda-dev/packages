#!/bin/bash

export pfx="$PWD/local"
mkdir -p "$pfx"

export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib;$pfx/lib"

# From https://gitlab.com/luxtorpeda/packages/gzdoom - See LICENSE file for more information
# CLONE PHASE
git clone https://github.com/team-eternity/eternity.git source
pushd source
git checkout d699a7d
git submodule update --init
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" \
    ..
make -j "$(nproc)"
make install DESTDIR="$pfx"
popd

# COPY PHASE
cp -rfv "$pfx/usr/local/bin"/* "$diststart/common/dist/"
cp -rfv "$pfx/usr/local/share/eternity/base" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
