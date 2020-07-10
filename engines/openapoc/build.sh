#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenApoc/OpenApoc.git source
pushd source
git checkout -f 9183a08
git am < ../patches/0001-Workaround-for-missing-PRId64.patch
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

git clone https://github.com/libunwind/libunwind.git libunwind
pushd libunwind
git checkout -f 1847559
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd cmake
./bootstrap
make 
sudo make install
popd

export CMAKE_ROOT=/usr/local/share/cmake-3.16/
/usr/local/bin/cmake --version

./build-boost.sh

pushd libunwind
./autogen.sh
./configure
make
make install
popd

pushd source
echo "Fetching minimal cd.iso for build"
wget http://s2.jonnyh.net/pub/cd_minimal.iso.xz -O data/cd.iso.xz
xz -d data/cd.iso.xz

mkdir build
cd build
/usr/local/bin/cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBUILD_LAUNCHER=OFF \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
