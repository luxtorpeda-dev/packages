#!/bin/bash

# CLONE PHASE
git clone https://gitlab.com/Tapani_/1oom.git source
pushd source
git checkout -f cc2b61c04c9bd11e17b06dc7b8d7c84760159842
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
