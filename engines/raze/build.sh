#!/bin/bash

apt-get -y install mercurial yasm

# CLONE PHASE
git clone https://github.com/coelckers/Raze.git source
pushd source
git checkout 88d8e64
popd

git clone https://github.com/FluidSynth/fluidsynth.git fluidsynth
pushd fluidsynth
git checkout -f 19a20eb
popd

git clone https://github.com/coelckers/ZMusic.git zmusic
pushd zmusic
git checkout -f 9097591
popd

git clone https://github.com/webmproject/libvpx.git libvpx
pushd libvpx
git checkout -f 6516e97
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
pushd "openal"
rm -rf build
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "openal"
rm -rf build
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

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

pushd "fluidsynth"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)" install
popd

pushd "zmusic"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DFLUIDSYNTH_INCLUDE_DIR="$pfx/include" \
    -DFLUIDSYNTH_LIBRARIES="$pfx/lib64" \
    ..
make -j "$(nproc)" install
popd

pushd "libvpx"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

cp -rfv /usr/local/lib/*openal.so* "$pfx/lib"

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"

cp -rfv "source/build"/{raze,soundfonts,*.pk3} "$diststart/common/dist/"
cp -rfv "$pfx/lib/libzmusic.so" "$diststart/common/dist/lib"
cp -rfv "$pfx/lib64"/libfluidsynth.so* "$diststart/common/dist/lib"
cp -rfv "$pfx/lib"/* "$diststart/common/dist/lib"
cp -rfv "assets/run-raze.sh" "$diststart/common/dist/"
