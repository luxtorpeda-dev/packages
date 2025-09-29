#!/bin/bash

export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"
export LD_LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib:$LD_LIBRARY_PATH"

mkdir -p pfx
export pfx="$PWD/pfx"

# CLONE PHASE
git clone https://github.com/OpenApoc/OpenApoc.git source
pushd source
git checkout -f "$COMMIT_HASH"
git submodule update --init --recursive
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" \
    -DBOOST_ROOT="$VCPKG_INSTALLED_PATH" \
    -DBUILD_LAUNCHER=OFF \
    -DBoost_LIBRARY_DIRS="$VCPKG_INSTALLED_PATH/lib" \
    -DENABLE_TESTS=OFF \
    -DEXTRACT_DATA=OFF \
    -DENABLE_BACKTRACE=OFF \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/7660/dist/bin/"
cp -rfv "source/build/bin/"* "$diststart/7660/dist/bin/"
cp -rfv "source/data" "$diststart/7660/dist/"
cp -rfv "assets/"* "$diststart/7660/dist/"
