#!/bin/bash

# CLONE PHASE
git clone https://gitlab.com/Dringgstein/Commander-Genius.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
mkdir -p build

cd build
cmake -DUSE_BOOST=0 ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/src/CGeniusExe" "$diststart/9180/dist/"

cp -rfv assets/* "$diststart/9180/dist/"
