#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenApoc/OpenApoc.git source
pushd source
git checkout -f 43a36ac
git submodule update --init --recursive
popd

# BUILD PHASE
pushd source
wget http://s2.jonnyh.net/pub/cd_minimal.iso.xz -O data/cd.iso.xz
xz -d data/cd.iso.xz
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5" \
    -DBUILD_LAUNCHER=ON \
    -DBoost_LIBRARY_DIRS="$pfx/lib" \
    -DENABLE_TESTS=OFF \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
rm -rf "source/data/cd.iso"
mkdir -p "$diststart/7660/dist/bin/"

cp -rfv "source/build/bin/OpenApoc" "$diststart/7660/dist/bin/"
cp -rfv "source/build/bin/OpenApoc_Launcher" "$diststart/7660/dist/bin/"
cp -rfv "source/data" "$diststart/7660/dist/"
cp -rfv "assets/"* "$diststart/7660/dist/"
