#!/bin/bash

# CLONE PHASE
git clone https://github.com/SuperV1234/SSVOpenHexagon.git source
pushd source
git checkout 4285d30de43f380199cee03fc446eb5910c3ec0c
git submodule update --init --recursive
popd

git clone https://github.com/g-truc/glm glm
pushd glm
git checkout -f 947527d3
git submodule update --init --recursive
popd

git clone https://github.com/Kitware/CMake.git cmake
pushd cmake
git checkout -f 39c6ac5
popd

# BUILD PHASE
pushd cmake
./bootstrap
make 
sudo make install
popd

export CMAKE_ROOT=/usr/local/share/cmake-3.16/
/usr/local/bin/cmake --version

pushd "source"
mkdir -p build
cd build
cmake \
    -DGLM_INCLUDE_DIR=../../glm \
    -DCMAKE_BUILD_TYPE=RELEASE \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv source/build/SSVOpenHexagon "$diststart/1358090/dist/"
cp -rfv source/build/HWorkshopUploader "$diststart/1358090/dist/"
