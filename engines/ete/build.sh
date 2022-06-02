#!/bin/bash

# CLONE PHASE
git clone https://github.com/etfdevs/ETe.git source
pushd source
git checkout c864b0a
popd

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
cp -rfv tmp/ete-ded.x86 "$diststart/1873030/dist/"
cp -rfv tmp/ete.x86 "$diststart/1873030/dist/"
cp -rfv tmp/cgame.mp.x86.so "$diststart/1873030/dist/etmain"
cp -rfv tmp/qagame.mp.x86.so "$diststart/1873030/dist/etmain"
cp -rfv tmp/ui.mp.x86.so "$diststart/1873030/dist/etmain"

pushd tmp
zip -r mp_bina.pk3 cgame*.so
zip -ur mp_bina.pk3 ui*.so
cp -rfv mp_bina.pk3 "$diststart/1873030/dist/etmain"
popd
