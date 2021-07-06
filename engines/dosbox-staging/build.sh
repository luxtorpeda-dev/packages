#!/bin/bash

# CLONE PHASE
git clone https://github.com/dosbox-staging/dosbox-staging.git source
pushd source
git checkout -f 15a57e2
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
popd

sudo pip3 install meson

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

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib64/pkgconfig"

pushd "source"
meson setup -Dbuildtype=release -Ddefault_library=static build

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/bin/dosbox" "$diststart/common/dist/"
cp -rfv "$pfx/lib64/"*.so* "$diststart/common/dist/lib"
cp -rfv assets/*.sh "$diststart/common/dist/"
