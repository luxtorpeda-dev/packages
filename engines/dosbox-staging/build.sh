#!/bin/bash

# CLONE PHASE
git clone https://github.com/dosbox-staging/dosbox-staging.git source
pushd source
git checkout -f cf72ec3
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 6776569
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd "fluidsynth"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

pushd "source"
./autogen.sh
./configure CPPFLAGS="-DNDEBUG" CFLAGS="-O3" CXXFLAGS="-O3" --prefix="$pfx"
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/bin/dosbox" "$diststart/common/dist/"
cp -rfv "$pfx/lib/"*.so* "$diststart/common/dist/lib"
cp -rfv assets/*.sh "$diststart/common/dist/"
