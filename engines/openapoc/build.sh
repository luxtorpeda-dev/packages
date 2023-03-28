#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenApoc/OpenApoc.git source
pushd source
git checkout -f ffc66ce
git submodule update --init --recursive
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5" \
    -DBUILD_LAUNCHER=ON \
    -DBoost_LIBRARY_DIRS="$pfx/lib" \
    -DENABLE_TESTS=OFF \
    -DEXTRACT_DATA=OFF \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/7660/dist/bin/"
cp -rfv "source/build/bin/"* "$diststart/7660/dist/bin/"

cp -rfv "source/data" "$diststart/7660/dist/"
cp -rfv "assets/"* "$diststart/7660/dist/"
