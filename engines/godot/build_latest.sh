#!/bin/bash

sudo apt update
sudo apt-get install build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev \
    libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm

# CLONE PHASE
git clone https://github.com/godotengine/godot.git source
pushd source
git checkout 092a286
popd

# BUILD PHASE
pushd source
scons -j$(nproc) platform=x11 # this requires python 3, the docker only has 2.7
popd

# COPY PHASE
mkdir -p "$dirstart/34270/dist/emu/"
cp -rfv "source" "$diststart/34270/dist/emu"
cp -rfv "assets/run-blastem.sh" "$diststart/34270/dist/"
