#!/bin/bash

# CLONE PHASE
git clone --depth 1 https://github.com/godotengine/godot.git -b 4.6-stable source

# BUILD PHASE
pushd source
scons -j$(nproc) platform=linuxbsd target=template_release disable_path_overrides=no
popd

# COPY PHASE
cp -rfv source/bin/godot.linuxbsd.template_release.x86_64 "$diststart/common/dist/"
cp -rfv assets/*.sh "$diststart/common/dist/"
