#!/bin/bash

# CLONE PHASE
git clone https://github.com/OpenRCT2/OpenRCT2.git source
pushd source
git checkout -f 6c3c857
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake ..
make -j "$(nproc)"
popd

# COPY PHASE
