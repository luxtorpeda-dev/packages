#!/bin/bash

sudo apt update
sudo apt-get install build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev \
    libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm

# CLONE PHASE
git clone --depth 1 https://github.com/godotengine/godot.git -b 3.4-stable source

# BUILD PHASE
pushd source
scons -j$(nproc) platform=x11
popd

# COPY PHASE
mkdir -p "$dirstart/34270/dist/godot/"
cp -rfv "source/bin/godot.x11.tools.64" "$diststart/34270/dist/"
cp -rfv "assets/run-godot.sh" "$diststart/34270/dist/"
