#!/bin/bash

# CLONE PHASE
git clone https://github.com/Daft-Freak/CnC_and_Red_Alert.git source
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
cp -rfv source/build/tdsdl "$diststart/common/dist/"
cp -rfv source/build/rasdl "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
