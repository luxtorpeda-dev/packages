#!/bin/bash

# CLONE PHASE
git clone https://github.com/DescentDevelopers/Descent3.git source
pushd source
git checkout -f "$COMMIT_TAG"
git submodule update --init --recursive
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -I"$VCPKG_INSTALLED_PATH"/include"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -I"$VCPKG_INSTALLED_PATH"/include"
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# BUILD PHASE
pushd "source"
cmake --preset linux -D ENABLE_LOGGER=OFF -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH"
cmake --build --preset linux --config Release
popd

# COPY PHASE
cp -rfv "assets"/* "$diststart/273590/dist"
cp -rfv source/builds/linux/Descent3/Release/Descent3 "$diststart/273590/dist/Descent3-lux"
