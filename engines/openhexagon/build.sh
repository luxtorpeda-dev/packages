#!/bin/bash

apt-get -y install mercurial libssl1.0-dev libgl1-mesa-glx libudev-dev libxcursor-dev libxi-dev libxinerama-dev

# CLONE PHASE
git clone https://github.com/SuperV1234/SSVOpenHexagon.git source
pushd source
git checkout 7f47e31
git submodule update --init --recursive
popd

git clone https://github.com/Kitware/CMake.git cmake
pushd cmake
git checkout -f 39c6ac5
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

git clone https://github.com/xiph/flac.git flac
pushd flac
git checkout -f 27c6157
popd

git clone https://github.com/aseprite/freetype2.git freetype2
pushd freetype2
git checkout -f fbbcf50
popd

hg clone https://hg.libsdl.org/SDL
pushd SDL
hg checkout release-2.0.12
popd

readonly pstart="$PWD"
readonly pfx="$PWD/local"
mkdir -p "$pfx"

# BUILD PHASE
pushd cmake
./bootstrap
make 
sudo make install
popd

export CMAKE_ROOT=/usr/local/share/cmake-3.16/
/usr/local/bin/cmake --version

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
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
make install
popd

pushd flac
mkdir -p build
cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_DOCS=OFF \
    -DBUILD_PROGRAMS=OFF \
    -DCMAKE_INSTALL_PREFIX="$pfx"
make -j "$(nproc)" FLAC
make install FLAC
popd

pushd "vorbis"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
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

pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/SSVOpenHexagon "$diststart/1358090/dist/"
cp -rfv source/build/OHWorkshopUploader "$diststart/1358090/dist/"
mkdir -p "$diststart/1358090/dist/lib"
cp -rfv "$pfx/lib"/*.so* "$diststart/1358090/dist/lib"
cp -rfv assets/* "$diststart/1358090/dist/"
ls -l source/build/_deps/luajit-build/
ls -l source/build/_deps/imgui-build
ls -l source/build/_deps/imgui-sfml-build
cp -rfv source/build/_deps/sfml-build/lib/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/build/_deps/zlib-build/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/build/_deps/luajit-build/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/build/_deps/imgui-build/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/build/_deps/imgui-sfml-build/*.so* "$diststart/1358090/dist/lib"
cp -rfv source/_RELEASE/*.so* "$diststart/1358090/dist/lib"
