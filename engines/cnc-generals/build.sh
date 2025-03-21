#!/bin/bash

# CLONE PHASE
git clone https://github.com/Fighter19/CnC_Generals_Zero_Hour.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DSAGE_USE_SDL3=ON \
    ..
cmake --build --target RTS .
popd

# COPY PHASE
