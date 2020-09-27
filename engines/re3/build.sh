#!/bin/bash

# CLONE PHASE
git clone https://github.com/GTAmodding/re3.git source
pushd source
git checkout -f 9b76424
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "source"
./premake5Linux --with-librw gmake2
cd build
make config=release_linux-x86_64-librw_gl3_glfw-oal
popd

# COPY PHASE
