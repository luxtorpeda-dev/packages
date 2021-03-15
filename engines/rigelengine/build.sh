#!/bin/bash

# CLONE PHASE
git clone https://github.com/lethal-guitar/RigelEngine.git source
pushd source
git checkout 5511365
git submodule update --init --recursive
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f 68a24986
git submodule update --init --recursive
popd

# BUILD PHASE

# build Boost
readonly boostlocation="$PWD/boost"
pushd "boost"
./bootstrap.sh
./b2 headers
popd

pushd "source"
mkdir build
cd build
cmake \
    -DBoost_DEBUG=1 \
    -DBOOST_ROOT="$boostlocation" \
    -DCMAKE_BUILD_TYPE=Release
    ..
make -j "$(nproc)"
make install
popd


# COPY PHASE
cp -rfv source/build/RigelEngine "$diststart/240180/dist/"
