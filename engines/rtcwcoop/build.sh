#!/bin/bash

# CLONE PHASE
git clone https://github.com/rtcwcoop/rtcwcoop.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source || exit 1
ARCH=x86_64 BUILD_CLIENT=1 BUILD_SERVER=0 BASEGAME=Main make
popd || exit 1

# COPY PHASE
mkdir tmp || exit 1
mkdir tmp/coopmain || exit 1

cp -rfv source/build/release-linux-x86_64/*.so tmp/
cp -rfv source/build/release-linux-x86_64/rtcwcoop.x86_64 tmp/
cp -rfv source/build/release-linux-x86_64/Main/*.so tmp/coopmain/

cp -rfv tmp/* "$diststart/9010/dist/"
cp -rfv assets/* "$diststart/9010/dist/"
