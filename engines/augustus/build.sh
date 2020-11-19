#!/bin/bash

# CLONE PHASE
git clone https://github.com/Keriew/augustus.git source
pushd source
git checkout 51c54ba
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/517790/dist/C3"
cp -rfv "source/build/augustus" "$diststart/517790/dist/"
cp -rfv "source/mods" "$diststart/517790/dist/C3/"
cp -rfv "source/res/maps" "$diststart/517790/dist/C3/"
