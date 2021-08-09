#!/bin/bash

sudo apt-get update
sudo apt-get -y install bison flex doxygen

# CLONE PHASE
git clone https://github.com/EasyRPG/Player.git source
pushd source
git checkout -f 4dd00a6
git submodule update --init --recursive
popd

git clone https://github.com/EasyRPG/liblcf.git liblcf
pushd liblcf
git checkout -f bb9f9e2
popd

git clone https://github.com/unicode-org/icu.git icu
pushd icu
git checkout -f c8bc56e
popd

git clone https://github.com/Mindwerks/wildmidi.git wildmidi
pushd wildmidi
git checkout -f 99dc051
popd

git clone https://github.com/libxmp/libxmp.git libxmp
pushd libxmp
git checkout -f a04bb8f
popd

git clone https://github.com/harfbuzz/harfbuzz.git harfbuzz
pushd harfbuzz
git checkout -f a01c7a3
popd

git clone https://github.com/Kitware/CMake.git cmake
pushd cmake
git checkout -f 39c6ac5
popd

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib64/pkgconfig:$pfx/lib/pkgconfig"

pushd cmake
./bootstrap -- -DCMAKE_USE_OPENSSL=OFF
make
sudo make install
popd

export CMAKE_ROOT=/usr/local/share/cmake-3.16/
/usr/local/bin/cmake --version

pushd icu/icu4c/source
./runConfigureICU Linux --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd liblcf
mkdir -p build
cd build
/usr/local/bin/cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

pushd wildmidi
mkdir -p build
cd build
/usr/local/bin/cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

pushd libxmp
mkdir -p build
cd build
/usr/local/bin/cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd

pushd harfbuzz
mkdir build
cd build
/usr/local/bin/cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DHB_HAVE_FREETYPE=ON \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir -p build
cd build
/usr/local/bin/cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    -DPLAYER_ENABLE_TESTS=OFF \
    ..
make -j "$(nproc)"
make install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"

cp -rfv "$pfx/bin/easyrpg-player" "$diststart/common/dist/"
cp -rfv "$pfx/lib"/*.so* "$diststart/common/dist/lib"

cp -rfv assets/*.sh "$diststart/common/dist/"
