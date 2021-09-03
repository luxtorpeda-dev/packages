#!/bin/bash

apt-get -y install mercurial libvulkan-dev lld meson python3-pip yasm nasm
sudo pip3 install meson

# CLONE PHASE
git clone https://github.com/KranX/Perimeter source
pushd source
git checkout -f 0b355d5
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

git clone https://github.com/KhronosGroup/glslang.git
pushd glslang
git checkout -f aa2d4bd
git submodule update --init --recursive
popd

git clone https://github.com/Kitware/CMake.git cmake
pushd cmake
git checkout -f 39c6ac5
popd

git clone https://github.com/libsdl-org/SDL_image.git sdlimage
pushd sdlimage
git checkout -f ab2a9c6
popd

git clone https://github.com/FFmpeg/FFmpeg ffmpeg
pushd ffmpeg
git checkout -f ba11e40
git submodule update --init --recursive
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -w"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas -w"

readonly pstart="$PWD"
readonly pfx="$PWD/local"
mkdir -p "$pfx"

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

pushd glslang
mkdir build
cd build
/usr/local/bin/cmake -DCMAKE_BUILD_TYPE=Release ..
make -j "$(nproc)"
make install
popd

pushd "openal"
rm -rf build
mkdir -p build
cd build
/usr/local/bin/cmake \
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
/usr/local/bin/cmake \
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
/usr/local/bin/cmake \
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
/usr/local/bin/cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd "SDL"
rm -rf build
mkdir -p build
cd build
/usr/local/bin/cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
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

pushd "sdlimage"
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
/usr/local/bin/cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release -DBOOST_ROOT="$boostlocation" -DCMAKE_PREFIX_PATH="$pfx" -DCMAKE_INSTALL_PREFIX="$pfx"
ninja dependencies
ninja
cd Source/dxvk-native-prefix/src/dxvk-native-build
DESTDIR="$pfx" ninja install
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/lib"
cp -rfv "$pfx/lib"/*.so* "$diststart/common/dist/lib"
cp -rfv "$pfx/usr/local/lib/x86_64-linux-gnu"/*.so* "$diststart/common/dist/lib"
cp -rfv source/build/Source/perimeter "$diststart/common/dist/"
cp -rfv assets/* "$diststart/common/dist/"
