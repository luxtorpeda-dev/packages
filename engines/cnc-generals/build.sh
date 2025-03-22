#!/bin/bash

# CLONE PHASE
git clone https://github.com/Fighter19/CnC_Generals_Zero_Hour.git source
pushd source
git checkout "$COMMIT_HASH"
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -I"$VCPKG_INSTALLED_PATH"/include"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -I"$VCPKG_INSTALLED_PATH"/include"
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

ln -rsf $VCPKG_INSTALLED_PATH/share/ffmpeg/FindFFMPEG.cmake $VCPKG_INSTALLED_PATH/share/ffmpeg/FFMPEGConfig.cmake

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DSAGE_USE_SDL3=ON \
    -DSAGE_USE_GLM=ON \
    -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" \
    -DSAGE_USE_OPENAL=ON \
    ..
cmake --build . --target RTS
popd

# COPY PHASE

