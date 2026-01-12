#!/bin/bash

# CLONE PHASE
git clone https://github.com/Youda008/DoomRunner.git source
pushd source
git checkout -f "$COMMIT_HASH"
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -I"$VCPKG_INSTALLED_PATH"/include"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -I"$VCPKG_INSTALLED_PATH"/include"
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
qmake ../DoomRunner.pro -spec linux-g++ "CONFIG+=release" "INCLUDEPATH+=${VCPKG_INSTALLED_PATH}/include" "LIBS+=-L${VCPKG_INSTALLED_PATH}/lib -lminizip -lz"
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/DoomRunner "$diststart/common/dist"
cp -rfv "assets"/* "$diststart/common/dist"
