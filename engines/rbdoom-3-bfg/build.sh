#!/bin/bash

# CLONE PHASE
git clone https://github.com/RobertBeckebans/RBDOOM-3-BFG.git source
pushd source
git checkout 3960b88
popd

# BUILD PHASE
pushd "source"
cd neo
./cmake-eclipse-linux-profile.sh
cd ../build
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/build/RBDoom3BFG" "$diststart/208200/dist/RBDoom3BFG"
