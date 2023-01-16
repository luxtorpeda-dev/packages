#!/bin/bash

sudo apt-get install build-essential git libsdl2-dev libvorbis-dev libogg-dev libtheora-dev libglew-dev

# CLONE PHASE
git clone https://github.com/Rubberduckycooly/Sonic-CD-11-Decompilation source
pushd source
git checkout 42cf7aa
popd

# BUILD PHASE
pushd source
make CXXFLAGS=-O2 -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/bin/RSDKv3 "$diststart/200940/dist/"
