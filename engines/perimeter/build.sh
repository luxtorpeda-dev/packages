#!/bin/bash

export CXXFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export CFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/IonAgorria/Perimeter.git source
pushd source
git checkout -f "$COMMIT_TAG"
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake .. \
    -G Ninja -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx;$VCPKG_INSTALLED_PATH" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DOPTION_LINKER=lld \
    -DOPTION_LINK_LIBS="stdc++fs;pthread;dl" \
    -DOPTION_STATIC_LIB_STD=ON \
    -DOPTION_DEBUG_ASSERT=OFF \
    -DOPTION_DXVK_1=ON \
    -DCMAKE_INSTALL_DO_STRIP=OFF \
    -DCMAKE_INSTALL_RPATH="\$ORIGIN" \
    -DCMAKE_EXE_LINKER_FLAGS="-ldl"
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
