#!/bin/bash

# CLONE PHASE
git clone https://github.com/Warzone2100/warzone2100.git source
pushd source
git checkout -f 06767a0
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local;$VCPKG_INSTALLED_PATH" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DWZ_ENABLE_WARNINGS_AS_ERRORS=OFF \
    -DENABLE_DOCS=OFF \
    ..
cmake --build . --target install
popd

# COPY PHASE
mkdir -p "$diststart/1241950/dist/data"
mkdir -p "$diststart/1241950/dist/bin"
cp -rfv "$pfx/share/locale" "$diststart/1241950/dist/"
cp -rfv "$pfx/share/warzone2100/"* "$diststart/1241950/dist/data"
cp -rfv "$pfx/bin/warzone2100" "$diststart/1241950/dist/bin"
cp -rfv "assets/run-warzone2100.sh" "$diststart/1241950/dist/"
