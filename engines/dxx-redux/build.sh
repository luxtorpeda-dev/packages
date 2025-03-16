#!/bin/bash

export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"
export CXXFLAGS="-I"$VCPKG_INSTALLED_PATH"/include"
export CFLAGS="-I"$VCPKG_INSTALLED_PATH"/include"

sudo apt-get -y install libsdl-mixer1.2-dev

# CLONE PHASE
git clone https://github.com/dxx-redux/dxx-redux.git source
pushd source
git checkout -f "$COMMIT_TAG"
popd

# BUILD PHASE
pushd source
cmake -S d1 -B buildd1 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH"
cmake --build buildd1

cmake -S d2 -B buildd2 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH"
cmake --build buildd2
popd

# COPY PHASE
cp -rfv source/buildd1/main/d1x-redux "$diststart/273570/dist/"
cp -rfv source/buildd2/main/d2x-redux "$diststart/273580/dist/"

cp -rfv assets/run-d1redux.sh "$diststart/273570/dist/"
cp -rfv assets/run-d2redux.sh "$diststart/273580/dist/"
