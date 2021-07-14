#!/bin/bash

# CLONE PHASE
git clone https://github.com/arx/ArxLibertatis source
pushd source
git checkout eb5ae43
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f 68a24986
git submodule update --init --recursive
popd

git clone https://github.com/g-truc/glm glm
pushd glm
git checkout -f 947527d3
git submodule update --init --recursive
popd

git clone https://github.com/arx/ArxLibertatisData.git data
pushd data
git checkout -f d92cc85
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
cp -rfv tmp/bin/* "$diststart/common/dist/"
cp -rfv tmp/lib/* "$diststart/common/dist/"
cp -rfv tmp/share/games/arx/* "$diststart/common/dist/"
mv "$diststart/common/dist/arx" "$diststart/common/dist/arx-bin"
cp -rfv assets/arx-launcher.sh "$diststart/common/dist/arx"
