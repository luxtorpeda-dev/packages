#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/seedhartha/reone.git source
pushd source
git checkout -f bfe467d
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f afb333b7
git submodule update --init --recursive
popd

git clone https://github.com/markjeee/libmad.git mad
pushd mad
git checkout -f c2f96fa
# from http://www.linuxfromscratch.org/blfs/view/svn/multimedia/libmad.html
patch -Np1 -i ../patches/libmad-0.15.1b-fixes-1.patch
sed "s@AM_CONFIG_HEADER@AC_CONFIG_HEADERS@g" -i configure.ac
touch NEWS AUTHORS ChangeLog
autoreconf -fi
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

wget https://github.com/nigels-com/glew/releases/download/glew-2.1.0/glew-2.1.0.zip
unzip glew-2.1.0.zip -d glew

readonly pfx="$PWD/local"
mkdir -p "$pfx"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE
./build-boost.sh

pushd "mad"
./configure --prefix="$pfx" --disable-static
make -j "$(nproc)" install
popd

pushd glew/glew-2.1.0
GLEW_DEST="$pfx" make -j "$(nproc)"
GLEW_DEST="$pfx" make install
make install
popd

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

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_EXTERNAL_GLM=ON \
    -DSDL2_LIBRARIES="$pfx/lib/libSDL2-2.0.so.0.12.0" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/32370/dist/lib/"
cp -rfv "local/lib"/*.so* "$diststart/32370/dist/lib/"
cp -rfv glew/glew-2.1.0/lib/*.so* "$diststart/32370/dist/lib"
cp -rfv source/build/bin/reone* "$diststart/32370/dist/"
cp -rfv assets/* "$diststart/32370/dist/"
