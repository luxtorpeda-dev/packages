#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/lethal-guitar/RigelEngine.git source
pushd source
git checkout c6a66d1
git submodule update --init --recursive
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f 68a24986
git submodule update --init --recursive
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

git clone https://github.com/SDL-mirror/SDL_mixer.git SDL_mixer
pushd SDL_mixer
git checkout -f release-2.0.4
popd

git clone https://github.com/Kitware/CMake.git cmake
pushd cmake
git checkout -f 39c6ac5
popd

readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd cmake
./bootstrap -- -DCMAKE_USE_OPENSSL=OFF
make 
sudo make install
popd

export CMAKE_ROOT=/usr/local/share/cmake-3.16/
/usr/local/bin/cmake --version

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

pushd "SDL_mixer"
./configure --prefix="$pfx"
make -j "$(nproc)"
make install
popd

pushd "boost"
./bootstrap.sh
./b2 headers
./b2 \
	--with-program_options \
	--with-filesystem \
	--with-system \
	--with-iostreams \
	--with-locale \
./b2 install --prefix="$pfx"
popd

pushd "source"
mkdir build
cd build
cmake \
    -DBoost_DEBUG=1 \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBoost_LIBRARY_DIRS="$pfx/lib" \
    -DCMAKE_BUILD_TYPE=Release \
    ..
make -j "$(nproc)"
make install
popd


# COPY PHASE
mkdir -p "$diststart/240180/dist/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/240180/dist/lib"
cp -rfv source/build/src/RigelEngine "$diststart/240180/dist/"
cp -rfv assets/* "$diststart/240180/dist/"
