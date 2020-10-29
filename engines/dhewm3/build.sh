#!/bin/bash

# CLONE PHASE
git clone https://github.com/dhewm/dhewm3.git source
pushd source
git checkout f3a4d92
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

# BUILD PHASE
pushd "openal"
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
make install
popd

pushd source/neo
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX=../../../tmp \
    -DCMAKE_PREFIX_PATH=../../../tmp \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv tmp/bin/* "$diststart/common/dist/"
cp -rfv tmp/lib/dhewm3/* "$diststart/common/dist/"

cp -rfv "/usr/local/lib/libopenal.so.1.20.1" "$diststart/common/dist/openal.so"

cp -rfv "assets/run-dhewm3.sh" "$diststart/common/dist/"
