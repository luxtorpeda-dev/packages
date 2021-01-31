#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://gitlab.com/solarus-games/solarus.git source
pushd source
git checkout 6d2a11dd
popd

hg clone https://hg.icculus.org/icculus/physfs
pushd physfs
hg checkout release-3.0.2
popd

git clone https://gitlab.com/solarus-games/libmodplug.git libmodplug
pushd libmodplug
git checkout a35e253001b1bc9046b7955d0871f841f88f993b
popd

git clone https://github.com/LuaJIT/LuaJIT.git luajit
pushd luajit
git checkout -f 570e758
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd physfs
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

export PKG_CONFIG_PATH="$pfx/lib/pkgconfig"

pushd "libmodplug"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd luajit
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DSOLARUS_GUI=OFF \
    -DLuaJit_INCLUDE_DIR="$pfx/usr/local/include/luajit-2.1/" \
    -DLuaJit_LIBRARY="$pfx/usr/local/lib/libluajit-5.1.a" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/1393750/dist/lib"
cp -rfv "assets/run-ocean-heart.sh" "$diststart/1393750/dist/"
cp -rfv "source/build/solarus-run" "$diststart/1393750/dist/"
cp -rfv "source/build/solarus" "$diststart/1393750/dist/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/1393750/dist/lib/"
