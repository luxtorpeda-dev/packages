#!/bin/bash

# CLONE PHASE
git clone https://github.com/Daft-Freak/CnC_and_Red_Alert.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
cmake -Bbuild -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
popd

# COPY PHASE
ls -l source/build
cp -rfv source/build/tdsdl "$diststart/common/dist/"
cp -rfv source/build/rasdl "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
