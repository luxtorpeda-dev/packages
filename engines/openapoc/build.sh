#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenApoc/OpenApoc.git source
pushd source
git checkout -f 9183a08
git submodule update --init --recursive
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f 62a4b7f
git submodule update --init --recursive
popd

git clone https://github.com/Kitware/CMake.git cmake
pushd cmake
git checkout -f 39c6ac5
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd cmake
./bootstrap
make 
sudo make install
popd

cmake --version

./build-boost.sh

pushd source
echo "Fetching minimal cd.iso for build"
wget http://s2.jonnyh.net/pub/cd_minimal.iso.xz -O data/cd.iso.xz
xz -d data/cd.iso.xz

mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBUILD_LAUNCHER=OFF \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
