#!/bin/bash

# CLONE PHASE
git clone https://github.com/bulletphysics/bullet3 bullet3
pushd bullet3
git checkout -f 6e4707df
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "bullet3"
mkdir -p build
cd build
cmake \
 	-DCMAKE_INSTALL_PREFIX="$pfx" \
 	-DBUILD_BULLET3=OFF \
 	-DBUILD_BULLET2_DEMOS=OFF \
 	-DBUILD_CPU_DEMOS=OFF \
 	-DBUILD_EXTRAS=OFF \
 	-DUSE_DOUBLE_PRECISION=ON \
 	-DCMAKE_BUILD_TYPE=Release \
 	-DBULLET2_MULTITHREADING=ON \
 	..
make -j "$(nproc)"
make install
popd
