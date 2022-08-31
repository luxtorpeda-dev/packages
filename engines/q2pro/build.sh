#!/bin/bash

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# CLONE PHASE
git clone https://github.com/skullernet/q2pro.git source
pushd source
git checkout 0211345
popd

# BUILD PHASE
export pfx="$PWD/local"
mkdir -p "$pfx"

pushd "source"
meson setup build
meson configure -Dprefix="$pfx" build
ninja -C build
popd

# COPY PHASE

cp -rfv assets/* "$diststart/common/dist/"
