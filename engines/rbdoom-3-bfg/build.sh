#!/bin/bash

# CLONE PHASE
git clone https://github.com/RobertBeckebans/RBDOOM-3-BFG.git source
pushd source
git checkout ab7fefc
git submodule update --init --recursive
popd

pushd "source"
mkdir build
cd build
cmake \
    -G "Eclipse CDT4 - Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DSDL2=ON \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DFFMPEG=OFF \
    -DBINKDEC=ON \
    ../neo
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/build/RBDoom3BFG" "$diststart/208200/dist/RBDoom3BFG"
cp -rfv ./assets/run-rbdoom-3-bfg.sh "$diststart/208200/dist/"
