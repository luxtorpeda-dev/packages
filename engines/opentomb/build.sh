#!/bin/bash

# CLONE PHASE
git clone https://github.com/opentomb/OpenTomb.git source
pushd source
git checkout 8e4c249
popd

git clone https://github.com/hessu/bchunk.git bchunk
pushd bchunk
git checkout -f 2d46931
popd

wget https://www.gnu.org/software/xorriso/xorriso-1.5.2.tar.gz
tar xvf xorriso-1.5.2.tar.gz

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    ..
make -j "$(nproc)"
popd

pushd bchunk
make
popd

pushd xorriso-1.5.2
./configure
make
popd

# COPY PHASE
cp -rfv source/build/OpenTomb "$diststart/common/dist/"
cp -rfv source/resource "$diststart/common/dist"
cp -rfv source/shaders "$diststart/common/dist"
cp -rfv source/autoexec.lua "$diststart/common/dist"
cp -rfv source/config.lua "$diststart/common/dist"
cp -rfv source/scripts "$diststart/common/dist"
cp -rfv bchunk/bchunk "$diststart/common/dist"
cp -rfv xorriso-1.5.2/xorriso "$diststart/common/dist"
