#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/Warzone2100/warzone2100.git source
pushd source
git checkout -f c74244a
git submodule update --init --recursive
popd

git clone https://github.com/jedisct1/libsodium.git libsodium
pushd libsodium
git checkout -f stable
popd

hg clone https://hg.icculus.org/icculus/physfs
pushd physfs
hg checkout release-3.0.2
popd

git clone https://github.com/harfbuzz/harfbuzz.git harfbuzz
pushd harfbuzz
git checkout -f a01c7a3
popd

git clone https://github.com/aseprite/freetype2.git freetype2
pushd freetype2
git checkout -f fbbcf50
popd

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"

pushd "libsodium"
./configure
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

pushd physfs
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd freetype2
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd harfbuzz
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DHB_HAVE_FREETYPE=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/qt5;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DWZ_ENABLE_WARNINGS_AS_ERRORS=OFF \
    -DENABLE_DOCS=OFF \
    ..
cmake --build . --target install
popd

# COPY PHASE
