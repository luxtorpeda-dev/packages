#!/bin/bash

sudo apt-get -y install curl libssl1.0-dev libasound2-dev

wget -qO - https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo apt-key add -
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-1.2.162-bionic.list https://packages.lunarg.com/vulkan/1.2.162/lunarg-vulkan-1.2.162-bionic.list
sudo apt update
sudo apt install -y vulkan-sdk

# CLONE PHASE
git clone https://github.com/Try/OpenGothic source
pushd source
git checkout -f 9c67441  
git submodule update --init --recursive
popd

curl -fsSL -o glslang-master-linux-Release.zip https://github.com/KhronosGroup/glslang/releases/download/master-tot/glslang-master-linux-Release.zip
mkdir glslang
unzip glslang-master-linux-Release.zip -d glslang

git clone https://github.com/Kitware/CMake.git cmake
pushd cmake
git checkout -f 39c6ac5
popd

# BUILD PHASE

readonly pstart="$PWD"
export PATH="$PATH:$pstart/glslang/bin"

pushd cmake
./bootstrap
make 
sudo make install
popd

export CMAKE_ROOT=/usr/local/share/cmake-3.16/
/usr/local/bin/cmake --version

pushd "source"
cmake -H. -Bbuild -DBUILD_EXTRAS:BOOL=OFF -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo -DBUILD_SHARED_MOLTEN_TEMPEST:BOOL=ON
cmake --build ./build --target all
popd

# COPY PHASE
mkdir "$diststart/39510/dist/lib/"
mkdir "$diststart/39510/dist/bin/"
cp -rfv "source/build/opengothic/Gothic2Notr" "$diststart/39510/dist/bin/Gothic2Notr"
cp -rfv "source/build/opengothic/Gothic2Notr.sh" "$diststart/39510/dist/Gothic2Notr.sh"
cp -rfv source/build/opengothic/*.so* "$diststart/39510/dist/lib/"
cp -rfv assets/run-gothic2.sh "$diststart/39510/dist/run-gothic2.sh"
