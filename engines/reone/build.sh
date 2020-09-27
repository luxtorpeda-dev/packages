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

git clone https://github.com/markjeee/libmad.git mad
pushd mad
git checkout -f c2f96fa
# from http://www.linuxfromscratch.org/blfs/view/svn/multimedia/libmad.html
patch -Np1 -i ../patches/libmad-0.15.1b-fixes-1.patch
sed "s@AM_CONFIG_HEADER@AC_CONFIG_HEADERS@g" -i configure.ac
touch NEWS AUTHORS ChangeLog
autoreconf -fi
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
./build-boost.sh

pushd "mad"
./configure --prefix="$pfx" --disable-static
make -j "$(nproc)" install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_EXTERNAL_GLM=ON \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/32370/dist/lib/"
cp -rfv "local/lib"/*.so* "$diststart/32370/dist/lib/"
cp -rfv source/build/reone* "$diststart/32370/dist/"
cp -rfv assets/* "$diststart/32370/dist/"
