#!/bin/bash

export CXXFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export CFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# CLONE PHASE
git clone https://github.com/chermenin/REminiscence.git source
pushd source
git checkout -f "$COMMIT_TAG"
popd

# BUILD PHASE
pushd source
make
popd

# COPY PHASE
cp -rfv source/fb "$diststart/961620/dist/fb"

cp -rfv assets/* "$diststart/961620/dist/"
