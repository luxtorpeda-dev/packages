#!/bin/bash

# CLONE PHASE
git clone https://github.com/etfdevs/ETe.git source
pushd source
git checkout "$COMMIT_HASH"
popd

git clone https://github.com/etlegacy/etlegacy etlegacy
pushd etlegacy
git checkout 2904921
popd

wget https://mirror.etlegacy.com/etmain/qagame.mp.i386.so

# BUILD PHASE
mkdir -p tmp
pushd "source/src"
mkdir build
cd build
cmake \
    -DUSE_SDL2=ON \
    -DCMAKE_INSTALL_PREFIX=../../../tmp \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=../cmake/toolchains/linux-i686.cmake \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/1873030/dist/etmain"
cp -rfv tmp/ete-ded.x86 "$diststart/1873030/dist/"
cp -rfv tmp/ete.x86 "$diststart/1873030/dist/"
cp -rfv qagame.mp.i386.so "$diststart/1873030/dist/etmain"
cp -rfv assets/* "$diststart/1873030/dist/"
