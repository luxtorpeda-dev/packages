#!/bin/bash

sudo apt-get install -y mercurial meson ninja-build python3-pip libssl-dev software-properties-common
sudo pip3 install meson
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get install -y gcc-9 g++-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
sudo update-alternatives --set gcc "/usr/bin/gcc-9"
sudo update-alternatives --set g++ "/usr/bin/g++-9"

# CLONE PHASE
git clone https://github.com/cortex-command-community/Cortex-Command-Community-Project-Source.git source
pushd source
git checkout -f a5a0930
pushd external/lib/linux/x86_64
rm libfmod.so
ln -rsf libfmod.so.12 libfmod.so
popd
popd

git clone https://github.com/cortex-command-community/Cortex-Command-Community-Project-Data.git data
pushd data
git checkout -f 21a8ad1
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

wget https://zlib.net/zlib-1.2.11.tar.gz
tar xvf zlib-1.2.11.tar.gz

git clone https://github.com/lz4/lz4.git lz4
pushd lz4
git checkout -f fdf2ef5
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

git clone https://github.com/Kitware/CMake.git cmake
pushd cmake
git checkout -f 39c6ac5
popd

git clone https://github.com/xiph/ogg.git ogg
pushd ogg
git checkout -f bada457
popd

git clone https://github.com/xiph/flac.git flac
pushd flac
git checkout -f f764434
popd

git clone https://github.com/glennrp/libpng.git libpng
pushd libpng
git checkout -f c17d164
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig:$pfx/usr/local/lib/pkgconfig:$pfx/share/pkgconfig"

# BUILD PHASE
pushd cmake
./bootstrap
make 
sudo make install
popd
export CMAKE_ROOT=/usr/local/share/cmake-3.16/
/usr/local/bin/cmake --version

pushd libpng
mkdir build
cd build
/usr/local/bin/cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd allegro4
mkdir -p build
cd build
/usr/local/bin/cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DWANT_DOCS=OFF
make -j "$(nproc)"
make install
popd

./build-boost.sh

pushd luajit
make -j "$(nproc)"
DESTDIR="$pfx" make install
make install
popd

pushd zlib-1.2.11
grep -A 24 '^  Copyright' zlib.h > LICENSE
cd contrib/minizip
mkdir -p build
cp Makefile Makefile.orig
cp ../README.contrib readme.txt
autoreconf --install
./configure --prefix="$pfx" --enable-static=no
make
make install DESTDIR="$pfx"
make install
popd

pushd "ogg"
mkdir -p build
cd build
/usr/local/bin/cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd flac
mkdir -p build
cd build
/usr/local/bin/cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$pfx"
make -j "$(nproc)"
make install
popd

pushd lz4
make -j "$(nproc)"
DESTDIR="$pfx" make install
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

pushd source
BOOST_ROOT="$pfx" meson build
cd build
meson compile CCCP
popd

# COPY PHASE
mkdir -p "$diststart/209670/dist/lib"
cp -rfv "$pfx/"lib/*.so* "$diststart/209670/dist/lib/"
cp -rfv "$pfx/"usr/local/lib/*.so* "$diststart/209670/dist/lib/"
cp -rfv data/* "$diststart/209670/dist/"
cp source/build/CCCP.x86_64 "$diststart/209670/dist"
cp -rfv source/external/lib/linux/x86_64/libfmod.so.12 "$diststart/209670/dist/lib/"
cp -rfv assets/* "$diststart/209670/dist"
