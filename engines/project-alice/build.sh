#!/bin/bash

# CLONE PHASE
git clone https://github.com/schombert/Project-Alice.git source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd source
cmake -DCMAKE_BUILD_TYPE=Release -B build
cmake --build build --parallel --target AliceIncremental
popd

# COPY PHASE
