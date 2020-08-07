#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenApoc/OpenApoc.git source
pushd source
git checkout -f 9183a08d34c90d2b9e91c1c941aa8459f3f5393f
git am < ../patches/0001-Workaround-for-missing-PRId64.patch
git am < ../patches/0002-Workaround-for-missing-PRIu64.patch
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
cp -rfv /usr/local/lib/libunwind*.so* "$pfx/lib"
export LD_LIBRARY_PATH="$pfx/lib:$LD_LIBRARY_PATH"

pushd source
wget http://s2.jonnyh.net/pub/cd_minimal.iso.xz -O data/cd.iso.xz
xz -d data/cd.iso.xz

mkdir build
cd build
/usr/local/bin/cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5" \
    -DBUILD_LAUNCHER=ON \
    -DBoost_LIBRARY_DIRS="$pfx/lib" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
rm -rf "source/data/cd.iso"
mkdir -p "$diststart/7660/dist/lib/"
mkdir -p "$diststart/7660/dist/bin/"
cp -rfv "source/build/bin/OpenApoc" "$diststart/7660/dist/bin/"
cp -rfv "source/build/bin/OpenApoc_Launcher" "$diststart/7660/dist/bin/"
cp -rfv "$pfx/lib/"*.so* "$diststart/7660/dist/lib/"
cp -rfv "source/data" "$diststart/7660/dist/"
cp -rfv "assets/"* "$diststart/7660/dist/"
