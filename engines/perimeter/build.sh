#!/bin/bash

# CLONE PHASE
git clone https://github.com/KranX/Perimeter source
pushd source
git checkout -f f58b3ae
git submodule update --init --recursive
popd

# BUILD PHASE
# cmake installed on system fails, so installing same one from before
wget https://github.com/Kitware/CMake/releases/download/v3.22.5/cmake-3.22.5-linux-x86_64.sh
chmod +x cmake-3.22.5-linux-x86_64.sh
./cmake-3.22.5-linux-x86_64.sh --skip-license --prefix=/usr

pushd "source"
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release -DOPTION_LINKER_LLD=OFF -DCMAKE_PREFIX_PATH="$pfx" -DCMAKE_INSTALL_PREFIX="$pfx"
ninja dependencies
ninja
cd Source/dxvk-native-prefix/src/dxvk-native-build
DESTDIR="$pfx" ninja install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"

cp -rfv "$pfx/lib"/*.so* "$diststart/common/dist/lib"
cp -rfv "$pfx/usr/local/lib/x86_64-linux-gnu"/*.so* "$diststart/common/dist/lib"
cp -rfv source/build/Source/perimeter "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
