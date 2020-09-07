#!/bin/bash

# CLONE PHASE
git clone https://github.com/skyjake/Doomsday-Engine.git source
pushd source
git checkout -f 648c6bb
git submodule update --init --recursive
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PATH="$pfx/qt5/bin:$PATH"

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/usr/bin/"* "$diststart/common/dist/"
cp -rfv "$pfx/usr/lib/lib/x86_64-linux-gnu/"*.so* "$diststart/common/dist/lib"
cp -rfv "$pfx/usr/lib/lib/x86_64-linux-gnu/doomsday/"*.so* "$diststart/common/dist/lib"
cp -rfv "$pfx/usr/share/doomsday/"* "$diststart/common/dist/"
