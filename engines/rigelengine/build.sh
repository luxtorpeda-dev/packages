#!/bin/bash

# CLONE PHASE
git clone https://github.com/lethal-guitar/RigelEngine.git source
pushd source
git checkout "$COMMIT_TAG"
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd


# COPY PHASE
cp -rfv source/build/src/RigelEngine "$diststart/240180/dist/"
cp -rfv assets/* "$diststart/240180/dist/"
