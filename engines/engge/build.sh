#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/scemino/engge.git source
pushd source
git checkout e8beab7
git submodule update --init --recursive
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.14
popd

git clone https://github.com/SDL-mirror/SDL_mixer.git SDL_mixer
pushd SDL_mixer
git checkout -f release-2.0.4
popd

wget https://github.com/nigels-com/glew/releases/download/glew-2.1.0/glew-2.1.0.zip
unzip glew-2.1.0.zip -d glew

git clone https://github.com/g-truc/glm glm
pushd glm
git checkout -f 947527d3
git submodule update --init --recursive
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

pushd glew/glew-2.1.0
GLEW_DEST="$pfx" make -j "$(nproc)"
GLEW_DEST="$pfx" make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DGLM_INCLUDE_DIR=../../glm \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
cmake --build . --config Release
popd

# COPY PHASE
mkdir -p "$diststart/569860/dist/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/569860/dist/lib"
cp -rfv source/build/engge "$diststart/569860/dist/"
cp -rfv assets/* "$diststart/569860/dist/"
