#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
DEBIAN_FRONTEND=noninteractive apt-get -y install mercurial curl tcl

# CLONE PHASE
git clone https://github.com/Warzone2100/warzone2100.git source
pushd source
git checkout -f bc54cac
git submodule update --init --recursive
popd

git clone https://github.com/jedisct1/libsodium.git libsodium
pushd libsodium
git checkout -f stable
popd

hg clone https://hg.icculus.org/icculus/physfs
pushd physfs
hg checkout release-3.0.2
popd

git clone https://github.com/harfbuzz/harfbuzz.git harfbuzz
pushd harfbuzz
git checkout -f a01c7a3
popd

git clone https://github.com/aseprite/freetype2.git freetype2
pushd freetype2
git checkout -f fbbcf50
popd

git clone https://github.com/openssl/openssl.git openssl
pushd openssl
git checkout -f 52c587d
popd

git clone https://github.com/curl/curl.git curl
pushd curl
git checkout -f 5a1fc8d
popd

git clone https://github.com/WardF/libbzip2.git libbzip2
pushd libbzip2
git checkout -f 85d4059
popd

git clone https://github.com/sqlite/sqlite.git sqlite
pushd sqlite
git checkout -f 60405cd
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

curl -L -v -o vulkansdk-linux-x86_64-1.2.148.1.tar.gz -O https://sdk.lunarg.com/sdk/download/1.2.148.1/linux/vulkan_sdk.tar.gz?Human=true
tar zxf vulkansdk-linux-x86_64-1.2.148.1.tar.gz

wget https://zlib.net/zlib-1.2.11.tar.gz
tar xvf zlib-1.2.11.tar.gz

git clone https://github.com/glennrp/libpng.git libpng
pushd libpng
git checkout -f c17d164
popd

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"


pushd libpng
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
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

pushd "libsodium"
./configure
make -j "$(nproc)"
DESTDIR="$pfx" make install
popd

pushd "sqlite"
./configure --prefix="$pfx" --disable-static
make -j "$(nproc)"
make install
popd

pushd physfs
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd libbzip2
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    ..
make -j "$(nproc)"
make install
popd

pushd freetype2
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd harfbuzz
mkdir build
cd build
cmake \
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

pushd "openssl"
./Configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd curl
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

export VULKAN_SDK="$PWD/1.2.148.1/x86_64"

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

pushd "openal"
rm -rf build
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
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

cp -rfv /usr/local/lib/*ogg.so* "$pfx/lib"
cp -rfv /usr/local/lib/*openal.so* "$pfx/lib"
cp -rfv /usr/local/lib/*vorbis*.so* "$pfx/lib"

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DWZ_ENABLE_WARNINGS_AS_ERRORS=OFF \
    -DENABLE_DOCS=OFF \
    ..
cmake --build . --target install
popd

# COPY PHASE
mkdir -p "$diststart/1241950/dist/lib"
mkdir -p "$diststart/1241950/dist/data"
mkdir -p "$diststart/1241950/dist/bin"
cp -rfv "$pfx/lib/"*.so* "$diststart/1241950/dist/lib"
cp -rfv "$pfx/usr/local/lib/"*.so* "$diststart/1241950/dist/lib"
cp -rfv "$pfx/share/locale" "$diststart/1241950/dist/"
cp -rfv "$pfx/share/warzone2100/"* "$diststart/1241950/dist/data"
cp -rfv "$pfx/bin/warzone2100" "$diststart/1241950/dist/bin"
cp -rfv "assets/run-warzone2100.sh" "$diststart/1241950/dist/"
