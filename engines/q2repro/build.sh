#!/bin/bash

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# CLONE PHASE
git clone https://github.com/Paril/q2repro.git source
pushd source
git checkout "$COMMIT_HASH"
git submodule update --init --recursive
popd

# BUILD PHASE
export pfx="$PWD/local"
mkdir -p "$pfx"

pushd "source"
meson setup build
meson configure -Dsystem-wide=false build
ninja -C build
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/baseq2"
cp -rfv source/build/q2repro "$diststart/common/dist/"
cp -rfv source/build/gamex86_64.so "$diststart/common/dist/"
cp -rfv source/src/client/ui/q2repro.menu "$diststart/common/dist/baseq2"
cp -rfv assets/* "$diststart/common/dist/"
