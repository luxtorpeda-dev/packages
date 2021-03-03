#!/bin/bash

apt-get -y install mercurial tcl
apt-get -y remove libsqlite3-dev

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

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

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
