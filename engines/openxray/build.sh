#!/bin/bash

export CXXFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export CFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/OpenXRay/xray-16 source
pushd source
git checkout -f "$COMMIT_HASH"
git submodule update --init --recursive
popd

git clone https://github.com/OpenXRay/Plus.git plus
pushd plus
popd

export pfx="$PWD/pfx"
mkdir "$pfx"

# BUILD PHASE
export SystemDrive="$pfx"
pushd "source"
mkdir -p bin
cd bin
cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" \
        -DCMAKE_INSTALL_PREFIX="$pfx" \
        -DCMAKE_INSTALL_LIBDIR="$pfx/lib" \
        ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
mkdir -p "$diststart/common/dist/gamedata"
cp -rfv "$pfx/bin/xr_3da" "$diststart/common/dist"
cp -rfv "$pfx/lib"/*.so* "$diststart/common/dist/lib"

cp assets/*.sh "$diststart/common/dist"
cp -rfv plus/res/gamedata/* "$diststart/common/dist/gamedata"
cp -rfv "$pfx/share/openxray"/* "$diststart/common/dist/"
