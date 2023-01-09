#!/bin/bash

# CLONE PHASE
git clone https://github.com/tx00100xt/SeriousSamClassic-VK.git source
pushd source
git checkout 590a0fb
patch -p1 < patches/tfe-vk-last-update.patch || return 1
patch -p1 < patches/tse-vk-last-update.patch || return 1
popd

# BUILD PHASE
pushd source/SamTSE/Sources
./build-linux64.sh
popd

# COPY PHASE
cp -rfv source/SamTSE/Bin "$diststart/41060/dist/"
cp -rfv assets/* "$diststart/41060/dist/"

# BUILD PHASE
pushd source/SamTFE/Sources
./build-linux64.sh -DTFE=TRUE
popd

# COPY PHASE
cp -rfv source/SamTFE/Bin "$diststart/41050/dist/"
cp -rfv assets/* "$diststart/41050/dist/"
