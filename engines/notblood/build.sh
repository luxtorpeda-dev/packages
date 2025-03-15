#!/bin/bash

# CLONE PHASE
git clone https://github.com/clipmove/NotBlood.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
make -j$(nproc) blood CXXFLAGS="-fkeep-inline-functions -std=c++11" CC=clang CXX=clang++
popd

# COPY PHASE
cp -rfv "source/notblood" "$diststart/common/dist/"
cp -rfv "source/notblood.pk3" "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
