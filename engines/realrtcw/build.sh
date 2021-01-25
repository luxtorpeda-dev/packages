#!/bin/bash

# CLONE PHASE
git clone https://github.com/wolfetplayer/RealRTCW.git source
pushd source
git checkout -f 7b6fd86
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd source || exit 1
ARCH=x86_64 make
popd || exit 1

# COPY PHASE
mkdir tmp || exit 1
mkdir tmp/Main || exit 1

mkdir tmp/lib
cp -rfv source/build/release-linux-x86_64/*.so tmp/
cp -rfv source/build/release-linux-x86_64/RealRTCW.x86_64 tmp/
cp -rfv source/build/release-linux-x86_64/main/*.so tmp/Main/

cp -rfv tmp/* "$diststart/1379630/dist/"
cp -rfv assets/* "$diststart/1379630/dist/"
