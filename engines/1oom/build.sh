#!/bin/bash

# CLONE PHASE
git clone https://gitlab.com/Tapani_/1oom.git source
pushd source
git checkout -f "$COMMIT_HASH"
popd

# BUILD PHASE
pushd source
autoreconf -fi
mkdir build
cd build
../configure --disable-hwsdl1 -prefix="$pfx"
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/src/1oom_classic_sdl2 "$diststart/410970/dist/"

cp -rfv assets/* "$diststart/410970/dist/"
