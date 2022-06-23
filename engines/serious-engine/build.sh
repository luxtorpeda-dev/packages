#!/bin/bash

# CLONE PHASE
git clone https://github.com/tx00100xt/SeriousSamClassic-VK.git source
pushd source
git checkout 3620b73
popd

# PRE-COPY PHASE
mkdir -p "$diststart/41050/dist/Bin/"
mkdir -p "$diststart/41060/dist/Bin/"

# BUILD PHASE
pushd source/SamTSE/Sources
./build-linux64.sh
popd

# COPY PHASE
cp -rfv source/SamTSE/Sources/cmake-build/ssam "$diststart/41060/dist/Bin/ssam"
cp -rfv source/SamTSE/Sources/cmake-build/RelWithDebInfo/* "$diststart/41060/dist/Bin"

# BUILD PHASE
pushd source/SamTFE/Sources
./build-linux64.sh -DTFE=TRUE
popd

# COPY PHASE
cp -rfv source/SamTFE/Sources/cmake-build/ssam-tfe "$diststart/41050/dist/Bin/ssam-tfe"
cp -rfv source/SamTFE/Sources/cmake-build/RelWithDebInfo/* "$diststart/41050/dist/Bin"
