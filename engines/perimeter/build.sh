#!/bin/bash

# CLONE PHASE
git clone https://github.com/IonAgorria/Perimeter.git source
pushd source
git checkout -f 48e3d63
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release -DOPTION_LINKER_LLD=OFF -DCMAKE_PREFIX_PATH="$pfx" -DCMAKE_INSTALL_PREFIX="$pfx"
ninja dependencies
ninja
cd Source/dxvk-prefix/src/dxvk-build
DESTDIR="$pfx" ninja install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"

cp -rfv "$pfx/lib"/*.so* "$diststart/common/dist/lib"
cp -rfv "$pfx/usr/local/lib/x86_64-linux-gnu"/*.so* "$diststart/common/dist/lib"
cp -rfv source/build/Source/perimeter "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
