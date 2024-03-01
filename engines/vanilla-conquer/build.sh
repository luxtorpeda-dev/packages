#!/bin/bash

# CLONE PHASE
git clone https://github.com/TheAssemblyArmada/Vanilla-Conquer.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake ..
cmake --build .
popd

# COPY PHASE
cp -rfv source/build/vanillara "$diststart/1213210/dist/"
cp -rfv source/build/vanillatd "$diststart/1213210/dist/"
cp -rfv assets/* "$diststart/1213210/dist/"
