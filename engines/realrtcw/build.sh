#!/bin/bash

# CLONE PHASE
git clone https://github.com/wolfetplayer/RealRTCW.git source
pushd source
git checkout 7e6dc5d
popd

git clone https://github.com/dscharrer/innoextract.git innoextract
pushd innoextract
git checkout 81fd9b9
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f afb333b7
git submodule update --init --recursive
popd

git clone https://github.com/kobolabs/liblzma.git liblzma
pushd liblzma
git checkout -f 87b7682
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd source || exit 1
ARCH=x86_64 make
popd || exit 1

./build-boost.sh

pushd liblzma
./configure --disable-shared --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd innoextract
mkdir -p build
cd build
BOOST_DIR="$pfx" cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir tmp || exit 1
mkdir tmp/Main || exit 1

cp -rfv source/build/release-linux-x86_64/*.so tmp/
cp -rfv source/build/release-linux-x86_64/RealRTCW.x86_64 tmp/
cp -rfv source/build/release-linux-x86_64/main/*.so tmp/Main/
cp -rfv "$pfx/lib/"*.so tmp/
cp -rfv "$pfx/bin/"* tmp/

cp -rfv tmp/* "$diststart/9010/dist/"
