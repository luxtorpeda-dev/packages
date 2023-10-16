#!/bin/bash

# CLONE PHASE
git clone https://github.com/tx00100xt/SeriousSamClassic-VK.git source
pushd source
git checkout a2e754a
popd

# BUILD PHASE
pushd source/SamTSE/Sources
find . -name "CMakeLists.txt" -exec sed -i 's/-march=native/-mtune=generic/g' {} +
./build-linux64.sh
popd

# COPY PHASE
cp -rfv source/SamTSE/Bin "$diststart/41060/dist/"
cp -rfv source/SamTSE/Mods "$diststart/41060/dist/"
cp -rfv source/SamTSE/SE1_10b.gro "$diststart/41060/dist/"
cp -rfv assets/* "$diststart/41060/dist/"

# BUILD PHASE
pushd source/SamTFE/Sources
find . -name "CMakeLists.txt" -exec sed -i 's/-march=native/-mtune=generic/g' {} +
./build-linux64.sh -DTFE=TRUE
popd

# COPY PHASE
cp -rfv source/SamTFE/Bin "$diststart/41050/dist/"
cp -rfv source/SamTFE/Mods "$diststart/41050/dist/"
cp -rfv source/SamTFE/SE1_10b.gro "$diststart/41050/dist/"
cp -rfv assets/* "$diststart/41050/dist/"
