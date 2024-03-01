#!/bin/bash

# CLONE PHASE
git clone https://github.com/iortcw/iortcw.git source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
# build SP
pushd source || exit 1
cd SP
ARCH=x86_64 BUILD_CLIENT=1 BUILD_SERVER=0 BASEGAME=Main  make
popd || exit 1

# build MP
pushd source || exit 1
cd MP
ARCH=x86_64 BUILD_CLIENT=1 BUILD_SERVER=0 BASEGAME=Main make
popd || exit 1

# COPY PHASE
mkdir tmp || exit 1
mkdir tmp/Main || exit 1

cp -rfv source/SP/build/release-linux-x86_64/*.so tmp/
cp -rfv source/SP/build/release-linux-x86_64/iowolfsp.x86_64 tmp/
cp -rfv source/SP/build/release-linux-x86_64/Main/*.so tmp/Main/

cp -rfv source/MP/build/release-linux-x86_64/*.so tmp/
cp -rfv source/MP/build/release-linux-x86_64/iowolfmp.x86_64 tmp/
cp -rfv source/MP/build/release-linux-x86_64/Main/*.so tmp/Main/

cp -rfv tmp/* "$diststart/9010/dist/"
cp -rfv assets/* "$diststart/9010/dist/"
