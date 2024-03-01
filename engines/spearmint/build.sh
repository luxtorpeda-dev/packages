#!/bin/bash

# CLONE PHASE
git clone https://github.com/zturtleman/spearmint.git source
pushd source
git checkout "$COMMIT_HASH"
popd

git clone https://github.com/zturtleman/mint-arena.git mint-arena
pushd mint-arena
git checkout 2620bce
pushd

git clone https://github.com/zturtleman/spearmint-patch-data.git spearmint-patch-data
pushd spearmint-patch-data
git checkout 3efbbca
pushd

wget https://raw.githubusercontent.com/gabomdq/SDL_GameControllerDB/master/gamecontrollerdb.txt

# BUILD PHASE
pushd "source"
make -j "$(nproc)"
popd

pushd "mint-arena"
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/spearmint"
cp -rfv source/build/release-linux-x86_64/* "$diststart/common/dist/spearmint"
cp -rfv ./gamecontrollerdb.txt "$diststart/common/dist/spearmint"

mkdir -p "$diststart/common/dist/mint-arena"
cp -rfv mint-arena/build/release-linux-x86_64/* "$diststart/common/dist/mint-arena"

mkdir -p "$diststart/common/dist/spearmint-patch-data"
cp -rfv spearmint-patch-data/* "$diststart/common/dist/spearmint-patch-data"
cp -rfv assets/* "$diststart/common/dist/"
