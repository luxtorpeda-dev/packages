#!/bin/bash

set -x
set -e

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# build Bullet Physics SDK
#
pushd "bullet3"
mkdir -p build
cd build
cmake \
 	-DCMAKE_INSTALL_PREFIX="$pfx" \
 	-DBUILD_BULLET3=OFF \
 	-DBUILD_BULLET2_DEMOS=OFF \
 	-DBUILD_CPU_DEMOS=OFF \
 	-DBUILD_EXTRAS=OFF \
 	..
make -j "$(nproc)"
make install
popd
