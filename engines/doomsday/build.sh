#!/bin/bash

# CLONE PHASE
git clone https://github.com/skyjake/Doomsday-Engine.git source
pushd source
git checkout -f db4bb26
git submodule update --init --recursive
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    ..
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/dlib"
mkdir -p "$diststart/common/dist/lib/doomsday"
cp -rfv "$pfx/usr/bin/" "$diststart/common/dist/"
cp -rfv "$pfx/usr/lib/x86_64-linux-gnu/"*.so* "$diststart/common/dist/dlib"
cp -rfv "$pfx/lib64/"*.so* "$diststart/common/dist/dlib"
cp -rfv "$pfx/usr/lib/x86_64-linux-gnu/doomsday/"*.so* "$diststart/common/dist/lib/doomsday"
cp -rfv "$pfx/usr/share/doomsday/"* "$diststart/common/dist/lib/doomsday"

cp -rfv "assets"/* "$diststart/common/dist"
