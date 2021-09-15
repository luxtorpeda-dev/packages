#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/OpenLoco/OpenLoco.git source
pushd source
git checkout -f 26d40d5
popd

git clone https://github.com/jbeder/yaml-cpp.git yaml-cpp
pushd yaml-cpp
git checkout -f 98acc5a
popd

git clone https://github.com/glennrp/libpng.git libpng
pushd libpng
git checkout -f c17d164
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

pushd "SDL_mixer"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd libpng
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd yaml-cpp
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd source
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DPNG_LIBRARIES="$pfx/lib/libpng16.so" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
cp -rfv ../data .
popd

# COPY PHASE
mkdir -p "$diststart/356430/dist/lib"
mkdir -p "$diststart/356430/dist/data"
cp -rfv "$pfx/lib/"*.so* "$diststart/356430/dist/lib"

cp -rfv "source/build/openloco" "$diststart/356430/dist/"
cp -rfv "source/build/data/"* "$diststart/356430/dist/data"

cp -rfv "assets/run-openloco.sh" "$diststart/356430/dist"
