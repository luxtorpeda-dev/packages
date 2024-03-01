#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interrupt/systemshock.git source
pushd source
git checkout "$COMMIT_HASH"
rm CMakeLists.txt
cp -rfv CMakeLists.32bit.txt CMakeLists.txt
popd

# BUILD PHASE
mkdir ./build_ext/
pushd build_ext
git clone https://github.com/EtherTyper/fluidsynth-lite.git fluidsynth-lite
pushd fluidsynth-lite
sed -i 's/DLL"\ off/DLL"\ on/' CMakeLists.txt
export CFLAGS="-m32"
export CXXFLAGS="-m32"

cmake .
cmake --build .
make install
popd
popd

pushd source
mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DENABLE_SDL2=ON \
    -DENABLE_SOUND=ON \
    ..
make -j "$(nproc)" systemshock
popd

# COPY PHASE
mkdir -p "$diststart/410700/dist/lib"
cp -rfv "source/build/systemshock" "$diststart/410700/dist/"
cp -rfv "source/shaders" "$diststart/410700/dist"
cp -rfv /usr/local/lib/libfluidsynth*.so* "$diststart/410700/dist/lib"

cp -rfv assets/* "$diststart/410700/dist/"
