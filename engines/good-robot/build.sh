#!/bin/bash

apt-get -y install mercurial

# CLONE PHASE
git clone https://github.com/arvindrajayadav/Good-Robot.git source
pushd source
git checkout c9a0a5f
popd

git clone https://github.com/boostorg/boost boost
pushd boost
git checkout -f afb333b7
git submodule update --init --recursive
popd

git clone https://github.com/DentonW/DevIL.git devil
pushd devil
git checkout -f a2d9193
popd

git clone https://github.com/vancegroup/freealut.git freealut
pushd freealut
git checkout -f 570dea5
popd

git clone https://github.com/kcat/openal-soft.git openal
pushd openal
git checkout -f f5e0eef
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

git clone https://github.com/aseprite/freetype2.git freetype2
pushd freetype2
git checkout -f fbbcf50
popd

wget https://github.com/nigels-com/glew/releases/download/glew-2.1.0/glew-2.1.0.zip
unzip glew-2.1.0.zip -d glew

readonly pfx="$PWD/local"
mkdir -p "$pfx"

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

# BUILD PHASE

readonly boostlocation="$PWD/boost"
pushd "boost"
./bootstrap.sh
./b2 headers
./b2 \
	--with-program_options \
	--with-filesystem \
	--with-system \
	--with-iostreams \
./b2 install --prefix="$pfx"
popd

pushd "devil/DevIL"
mkdir build
cd build || exit 1
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
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
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "freealut"
mkdir build
cd build || exit 1
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DOPENAL_INCLUDE_DIR="$pfx/include/" \
    ..
make -j "$(nproc)"
make install
popd

# build glew
pushd glew/glew-2.1.0
GLEW_DEST="$pfx" make -j "$(nproc)"
GLEW_DEST="$pfx" make install
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

pushd freetype2
mkdir build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    ..
make -j "$(nproc)"
make install
popd

pushd "source"
mkdir build
cd build || exit 1
cmake \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DBOOST_ROOT="$boostlocation" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DSDL2_LIBRARIES="$pfx/lib/libSDL2-2.0.so.0.12.0" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/358830/dist/lib"
cp -rfv "$pfx/lib/"*.so* "$diststart/358830/dist/lib"
cp -rfv source/build/good_robot "$diststart/358830/dist/"
cp -rfv assets/run-good-robot.sh "$diststart/358830/dist/"
cp -rfv source/steamworks/redistributable_bin/linux64/libsteam_api.so "$diststart/358830/dist/lib"
