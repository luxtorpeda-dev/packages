#!/bin/bash

export CXXFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export CFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/sezero/uhexen2.git source
pushd source
git checkout f22de3d
popd

# BUILD PHASE
pushd "source/engine/hexen2"
make -j "$(nproc)" glh2
popd

# COPY PHASE
cp -rfv "./source/engine/hexen2/glhexen2" "$diststart/9060/dist"
cp -rfv assets/* "$diststart/9060/dist"
