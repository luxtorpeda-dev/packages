#!/bin/bash

export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/dxx-redux/dxx-redux.git source
pushd source
git checkout -f 9bbca7f
popd

# BUILD PHASE
pushd source
cmake -S d1 -B buildd1 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH"
cmake --build buildd1

cmake -S d2 -B buildd2 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH"
cmake --build buildd2
popd

# COPY PHASE
cp -rfv source/build/d1x-rebirth/d1x-rebirth "$diststart/273570/dist/"
cp -rfv source/build/d2x-rebirth/d2x-rebirth "$diststart/273580/dist/"

cp -rfv assets/run-d1x.sh "$diststart/273570/dist/"
cp -rfv assets/run-d2x.sh "$diststart/273580/dist/"
