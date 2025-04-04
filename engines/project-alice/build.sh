#!/bin/bash

export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"
export LD_LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib:$LD_LIBRARY_PATH"

# CLONE PHASE
git clone https://github.com/schombert/Project-Alice.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd source
cmake -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" -DCMAKE_BUILD_TYPE=Release -B build
cmake --build build --parallel --target AliceIncremental
popd

# COPY PHASE
cp -rfv source/assets "$diststart/42960/dist/"
