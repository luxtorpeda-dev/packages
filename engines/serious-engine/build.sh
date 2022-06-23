#!/bin/bash

# CLONE PHASE
git clone https://github.com/tx00100xt/SeriousSamClassic-VK.git source
pushd source
git checkout 3620b73
popd

# BUILD PHASE
pushd source/SamTSE/Sources
./build-linux64.sh
popd

# COPY PHASE
cp -rfv source/SamTSE/Sources/Bin "$diststart/41060/dist/"

# BUILD PHASE
pushd source/SamTFE/Sources
./build-linux64.sh -DTFE=TRUE
popd

# COPY PHASE
cp -rfv source/SamTFE/Sources/Bin "$diststart/41050/dist/"
