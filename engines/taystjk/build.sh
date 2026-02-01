#!/bin/bash

# CLONE PHASE
git clone https://github.com/taysta/TaystJK.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
mkdir -p tmp
pushd source
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX=../../tmp \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
cp -rfv tmp/JediAcademy/* "$diststart/6020/dist/"
cp -rfv assets/run-taystjk.sh "$diststart/6020/dist/"
