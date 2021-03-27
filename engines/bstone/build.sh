#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/bibendovsky/bstone.git source
pushd source
git checkout d329e75
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "SDL"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd source
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBSTONE_USE_PCH=OFF \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv "source/build/src/bstone" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/common/dist/lib"
