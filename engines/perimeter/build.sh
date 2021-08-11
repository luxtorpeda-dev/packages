#!/bin/bash

apt-get -y install mercurial libvulkan-dev lld glslang-tools meson

# CLONE PHASE
git clone https://github.com/KranX/Perimeter source
pushd source
git checkout -f 4eb0872
git submodule update --init --recursive
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

git clone https://github.com/xiph/theora.git theora
pushd theora
git checkout -f 7ffd8b2
popd

git clone https://github.com/xiph/ogg.git ogg
pushd ogg
git checkout -f bada457
popd

git clone https://github.com/xiph/vorbis.git vorbis
pushd vorbis
git checkout -f 0657aee
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f 68a24986
git submodule update --init --recursive
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -w"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -w"

readonly pstart="$PWD"
readonly pfx="$PWD/local"
mkdir -p "$pfx"

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
pushd "openal"
rm -rf build
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

pushd "ogg"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "vorbis"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
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

pushd "theora"
./autogen.sh
./configure --enable-shared --prefix="$pfx"
make -j "$(nproc)"
make install
popd

# build Boost
readonly boostlocation="$PWD/boost"
pushd "boost"
./bootstrap.sh
./b2 headers
popd

pushd "source"
mkdir build
cd build
cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release
popd

# COPY PHASE
