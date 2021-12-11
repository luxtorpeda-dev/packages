#!/bin/bash

# CLONE PHASE
git clone --depth 1 https://github.com/godotengine/godot.git -b 3.4-stable source

# BUILD PHASE
pushd source
scons -j$(nproc) platform=x11
popd

# COPY PHASE
cp -rfv source/bin/godot.x11.tools.64 "$diststart/common/dist/"
cp -rfv assets/*.sh "$diststart/common/dist/"
