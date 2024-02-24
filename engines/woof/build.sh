#!/bin/bash

export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/fabiangreffrath/woof.git source
pushd source
git checkout cf23b4b
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/woof" "$diststart/common/dist/"
cp -rfv "source/autoload" "$diststart/common/dist/"
cp -rfv "source/docs" "$diststart/common/dist/"
cp -rfv "source/soundfonts" "$diststart/common/dist/"

cp -rfv assets/* "$diststart/common/dist/"
