#!/bin/bash

# CLONE PHASE
git clone https://github.com/Interrupt/systemshock.git source
pushd source
git checkout bcdb119
rm CMakeLists.txt
cp -rfv CMakeLists.32bit.txt CMakeLists.txt
popd

git clone https://github.com/Doom64/fluidsynth-lite.git

# BUILD PHASE
pushd fluidsynth-lite
sed -i 's/DLL"\ off/DLL"\ on/' CMakeLists.txt
export CFLAGS="-m32"
export CXXFLAGS="-m32"

cmake .
cmake --build .
make install
popd

pushd source
mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="$pfx" \
    ..
make -j "$(nproc)" systemshock
popd

# COPY PHASE
cp -rfv "source/build/systemshock" "$diststart/410700/dist/"
cp -rfv "source/shaders" "$diststart/410700/dist"
cp -rfv assets/* "$diststart/410700/dist/"
