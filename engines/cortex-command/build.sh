#!/bin/bash

sudo apt-get install -y mercurial meson ninja-build python3-pip
sudo pip3 install meson

# CLONE PHASE
git clone https://github.com/cortex-command-community/Cortex-Command-Community-Project-Source.git source
pushd source
git checkout -f 5280ac5
popd

git clone https://github.com/cortex-command-community/Cortex-Command-Community-Project-Data.git data
pushd data
git checkout -f 4f46182
popd

git clone https://github.com/liballeg/allegro5.git allegro4
pushd allegro4
git checkout -f 30aabed
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f afb333b7
git submodule update --init --recursive
popd

git clone https://github.com/LuaJIT/LuaJIT.git luajit
pushd luajit
git checkout -f 570e758
popd

git clone https://github.com/nmoinvaz/minizip.git minizip
pushd minizip
git checkout -f 3ecff07
popd

git clone https://github.com/lz4/lz4.git lz4
pushd lz4
git checkout -f fdf2ef5
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig:$pfx/usr/local/lib/pkgconfig"

# BUILD PHASE
pushd allegro4
mkdir -p build
cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DWANT_DOCS=OFF
make -j "$(nproc)"
make install
popd

./build-boost.sh

pushd luajit
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

pushd minizip
mkdir -p build
cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$pfx"
make -j "$(nproc)"
make install
popd

pushd lz4
make -j "$(nproc)"
DESTDIR="$pfx" make install
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

pushd source
BOOST_ROOT="$pfx" python3 ../meson/meson.py build
cd build
python3 ../meson/meson.py compile CCCP
popd

# COPY PHASE
mkdir -p "$diststart/209670/dist/lib"
cp -rfv "$pfx/"lib/*.so* "$diststart/209670/dist/lib/"
cp -rfv "$pfx/"usr/local/lib/*.so* "$diststart/209670/dist/lib/"
