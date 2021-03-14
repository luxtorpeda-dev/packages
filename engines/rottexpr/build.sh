#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/LTCHIPS/rottexpr.git source
pushd source
git checkout 407e3d8
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

git clone https://github.com/SDL-mirror/SDL_mixer.git SDL_mixer
pushd SDL_mixer
git checkout -f release-2.0.4
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
pushd "SDL"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd "SDL"
rm -rf build
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
make install
popd

pushd "SDL_mixer"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd "SDL_mixer"
./configure
make -j "$(nproc)"
make install
popd

pushd "source/src"
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/238050/dist/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/238050/dist/lib"
cp -rfv source/src/rott "$diststart/238050/dist/"
cp -rfv assets/* "$diststart/238050/dist/"
