#!/bin/bash

# CLONE PHASE
git clone https://gitlab.com/KilgoreTroutMaskReplicant/1oom.git source
pushd source
git checkout -f dedf0bbd57fe004e5d49c2b63c98a219cc1b906e
popd

# BUILD PHASE
pushd source
autoreconf -fi
mkdir build
cd build
../configure
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/src/1oom_classic_sdl2 "$diststart/410970/dist/"
