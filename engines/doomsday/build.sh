#!/bin/bash

# CLONE PHASE
git clone https://github.com/skyjake/Doomsday-Engine.git source
pushd source
git checkout -f "$COMMIT_HASH"
git submodule update --init --recursive
popd

git clone https://git.skyjake.fi/skyjake/the_Foundation.git foundation
pushd foundation
git checkout -f 039a6c3510d71f893867ca8c27da062b9bf9cc86
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -I"$VCPKG_INSTALLED_PATH"/include"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -I"$VCPKG_INSTALLED_PATH"/include"
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib;$pfx/lib"

# BUILD PHASE
pushd foundation
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    ..
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/dlib"
mkdir -p "$diststart/common/dist/lib/doomsday"
cp -rfv "$pfx/lib/"* "$diststart/common/dist/"
cp -rfv "$pfx/usr/bin/" "$diststart/common/dist/"
cp -rfv "$pfx/usr/lib/x86_64-linux-gnu/"*.so* "$diststart/common/dist/dlib"
cp -rfv "$pfx/usr/lib/x86_64-linux-gnu/doomsday/"*.so* "$diststart/common/dist/lib/doomsday"
cp -rfv "$pfx/usr/share/doomsday/"* "$diststart/common/dist/lib/doomsday"
cp -rfv "assets"/* "$diststart/common/dist"
