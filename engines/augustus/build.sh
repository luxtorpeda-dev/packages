#!/bin/bash

# CLONE PHASE
git clone https://github.com/Keriew/augustus.git source
pushd source
git checkout 08f9389
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/augustus" "$diststart/517790/dist/"
cp -rfv "source/mods" "$diststart/517790/dist/"
cp -rfv "source/res/maps" "$diststart/517790/dist/"

cp -rfv assets/* "$diststart/517790/dist/"
