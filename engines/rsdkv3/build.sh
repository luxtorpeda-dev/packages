#!/bin/bash

sudo apt-get install build-essential git libsdl2-dev libvorbis-dev libogg-dev libtheora-dev libglew-dev libgbm-dev libdrm-dev

# CLONE PHASE
git clone https://github.com/Rubberduckycooly/Sonic-CD-11-Decompilation source
pushd source
git checkout 42cf7aa
git submodule update --init --recursive
popd

# BUILD PHASE
pushd source

# Needed because Debian usses gcc 8.3, so this is needed (thanks https://github.com/shantigilbert for the patch!)
sed -i "s|pthread|pthread -lstdc++fs|" Makefile

# And this is needed to potentially fix an error that can happen with tinyxml (thanks https://github.com/dilworks for this modified command)
make CXXFLAGS="-O2 -Idependencies/all/tinyxml2/" LIBS=-lstdc++fs -j"$(nproc)"
popd

# COPY PHASE
cp -rfv source/bin/RSDKv3 "$diststart/200940/dist/"
