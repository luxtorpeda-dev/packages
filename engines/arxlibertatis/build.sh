#!/bin/bash

# CLONE PHASE
git clone --recursive https://github.com/arx/ArxLibertatis source
pushd source
git checkout 2bfb7d58
popd

git clone --recursive https://github.com/boostorg/boost boost
pushd boost
git checkout 68a24986
popd

git clone --recursive https://github.com/g-truc/glm glm
pushd glm
git checkout 947527d3
popd

git clone --recursive https://github.com/arx/ArxLibertatisData.git data
pushd data
git checkout d92cc85
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
cd build || exit 1
ln -s ../../data arx-libertatis-data
cmake \
    -DBoost_DEBUG=1 \
    -DGLM_INCLUDE_DIR=../../glm \
    -DBOOST_ROOT="$boostlocation" \
    -DCMAKE_INSTALL_PREFIX=../../tmp \
    ..
make -j "$(nproc)"
make install
popd


# COPY PHASE
cp -rfv tmp/bin/* "$diststart/1700/dist/"
cp -rfv tmp/lib/* "$diststart/1700/dist/"
cp -rfv tmp/share/games/arx/* "$diststart/1700/dist/"
mv "$diststart/1700/dist/arx" "$diststart/1700/dist/arx-bin"
cp -rfv assets/arx-launcher.sh "$diststart/1700/dist/arx"

