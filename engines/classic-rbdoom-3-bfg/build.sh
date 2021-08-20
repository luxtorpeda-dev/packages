#!/bin/bash

apt-get -y install mercurial yasm nasm

# CLONE PHASE
git clone https://github.com/MadDeCoDeR/Classic-RBDOOM-3-BFG.git source
pushd source
git checkout 4ec6e58d377275c9d65ee6acec45859778d5b174
git revert 4ec6e58d377275c9d65ee6acec45859778d5b174
git revert 8d430396c93fd50eb25037f2f1e8fd1e70803bee
git revert 4aa356af18370e459aaa71d5d5220a3612ea3cd5
popd

git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg
pushd ffmpeg
git checkout -f 523da8ea
git submodule update --init --recursive
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

git clone https://github.com/libsdl-org/SDL
pushd SDL
git checkout 25f9ed8
popd

git clone https://github.com/Kitware/CMake.git cmake
pushd cmake
git checkout -f 39c6ac5
popd

readonly pfx="$PWD/local"
readonly tmp="$PWD/tmp"
mkdir -p "$pfx"
mkdir -p "$tmp"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
pushd cmake
./bootstrap -- -DCMAKE_USE_OPENSSL=OFF
make
sudo make install
popd

export CMAKE_ROOT=/usr/local/share/cmake-3.16/
/usr/local/bin/cmake --version

./build-ffmpeg.sh

pushd "openal"
rm -rf build
mkdir -p build
cd build
/usr/local/bin/cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd "SDL"
mkdir -p build
cd build
/usr/local/bin/cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir build
cd build
/usr/local/bin/cmake \
    -G "Eclipse CDT4 - Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DSDL2=ON \
    -DFFMPEG_ROOT="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ../neo
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/build/DoomBFA" "$diststart/208200/dist/DoomBFA"
mkdir -p "$diststart/208200/dist/lib"
cp -rfv "$pfx/"lib/*.so* "$diststart/208200/dist/lib/"
cp -rfv ./assets/* "$diststart/208200/dist/"
cp -rfv ./source/base "$diststart/208200/dist/updatedbase"
