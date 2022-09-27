#!/bin/bash

# CLONE PHASE
git clone https://github.com/iortcw/iortcw.git source
pushd source
git checkout 6cbc480

# patch combined from https://github.com/emileb/iortcw/commit/a161754e3de388536bc3989f412a98278c87dcfa and https://github.com/emileb/iortcw/commit/8321584a52babb03cf75e1021308cf31c45fca10
# See https://github.com/iortcw/iortcw/issues/154 for reference
git am < ../patches/0001-Load-crashing-fixes.patch
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
