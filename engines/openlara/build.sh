#!/bin/bash

# CLONE PHASE
git clone https://github.com/XProger/OpenLara.git source
pushd source
git checkout b7d6ce5
git am < ../patches/0001-Fix-compile-error.patch
popd

git clone https://github.com/hessu/bchunk.git bchunk
pushd bchunk
git checkout -f 2d46931
popd

wget https://www.gnu.org/software/xorriso/xorriso-1.5.2.tar.gz
tar xvf xorriso-1.5.2.tar.gz

pushd source/src/platform/nix
./build.sh
popd

pushd bchunk
make
popd

pushd xorriso-1.5.2
./configure
make
popd

# COPY PHASE
cp -rfv source/bin/OpenLara "$diststart/224960/dist"
cp -rfv bchunk/bchunk "$diststart/224960/dist"
cp -rfv xorriso-1.5.2/xorriso/xorriso "$diststart/224960/dist"
cp -rfv assets/*.so "$diststart/224960/dist"
