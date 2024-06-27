#!/bin/bash

# CLONE PHASE
git clone https://github.com/dalerank/Akhenaten.git source
pushd source
git checkout "$COMMIT_TAG"
git submodule init
git submodule update ext/cpptrace
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake ..
cd ..
cmake --build ./build
popd

# COPY PHASE
cp -rfv "source/build/akhenaten" "$diststart/564530/dist/"
