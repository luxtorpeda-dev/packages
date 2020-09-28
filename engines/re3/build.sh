#!/bin/bash

# CLONE PHASE
git clone https://github.com/GTAmodding/re3.git source
pushd source
git checkout -f 70aac0f
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

git clone https://github.com/glfw/glfw.git glfw
pushd glfw
git checkout -f 3.3.2
popd

wget https://github.com/nigels-com/glew/releases/download/glew-2.1.0/glew-2.1.0.zip
unzip glew-2.1.0.zip -d glew

git clone https://github.com/erikd/libsndfile.git libsndfile
pushd libsndfile
git checkout -f 1.0.30
popd

git clone https://github.com/gypified/libmpg123.git libmpg123
pushd libmpg123
git checkout -f 8cbf2fa
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
pushd glew/glew-2.1.0
GLEW_DEST="$pfx" make -j "$(nproc)"
GLEW_DEST="$pfx" make install
make install
popd

pushd "openal"
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

pushd "glfw"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd "libsndfile"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd "libmpg123"
./configure --prefix="$pfx"
make -j "$(nproc)" install
popd

pushd "source"
./premake5Linux --with-librw gmake2
cd build
make config=release_linux-x86_64-librw_gl3_glfw-oal
popd

# COPY PHASE
