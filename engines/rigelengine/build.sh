#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/lethal-guitar/RigelEngine.git source
pushd source
git checkout c6a66d1
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
mkdir build
cd build
cmake \
    -DBoost_DEBUG=1 \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBoost_LIBRARY_DIRS="$pfx/lib" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd


# COPY PHASE
cp -rfv source/build/src/RigelEngine "$diststart/240180/dist/"
cp -rfv assets/* "$diststart/240180/dist/"
