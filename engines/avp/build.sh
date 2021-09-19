#!/bin/bash

# CLONE PHASE
git clone https://github.com/neuromancer/avp.git source
pushd source
git checkout 2d57747
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv "source/build/avp" "$diststart/3730/dist/avp"
cp -rfv "assets/run-avp.sh" "$diststart/3730/dist/"
