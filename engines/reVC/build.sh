#!/bin/bash

sudo apt-get -y install libxcursor-dev libxi-dev

# CLONE PHASE
git clone https://github.com/GTAmodding/re3.git source
pushd source
git checkout -f b7783b19d2d075ba507f4300e44704710301fbb5
git submodule update --init --recursive
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
git checkout -f 68958f9
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
make -j "$(nproc)"
make install
popd

pushd "openal"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "glfw"
mkdir -p build
cd build
cmake \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "libsndfile"
mkdir -p build
cd build
cmake \
    ..
make -j "$(nproc)"
make install
popd

pushd "libmpg123"
./configure
make -j "$(nproc)" install
popd

pushd "source"
./premake5Linux --with-librw gmake2
cd build
make config=release_linux-amd64-librw_gl3_glfw-oal
popd

# COPY PHASE
mkdir -p "$diststart/12110/dist/lib/"
cp -rfv /usr/local/lib/*.so* "$diststart/12110/dist/lib/"
cp -rfv glew/glew-2.1.0/lib/*.so* "$diststart/12110/dist/lib"
cp -rfv source/bin/linux-amd64-librw_gl3_glfw-oal/Release/reVC "$diststart/12110/dist/reVC"
cp -rfv assets/* "$diststart/12110/dist/"
cp -rfv source/gamefiles/* "$diststart/12110/dist/"
