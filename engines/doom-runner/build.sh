#!/bin/bash

# CLONE PHASE
git clone https://github.com/Youda008/DoomRunner.git source
pushd source
git checkout -f cad2dcf
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
qmake ../DoomRunner.pro -spec linux-g++ "CONFIG+=release"
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/DoomRunner "$diststart/common/dist"
cp -rfv "assets"/* "$diststart/common/dist"
