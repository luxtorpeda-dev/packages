#!/bin/bash

# CLONE PHASE
git clone --recursive https://github.com/Try/OpenGothic source
pushd source
git checkout 47f2a21
popd
curl -fsSL -o glslang-master-linux-Release.zip https://github.com/KhronosGroup/glslang/releases/download/master-tot/glslang-master-linux-Release.zip
unzip glslang-master-linux-Release.zip

# BUILD PHASE
readonly pstart="$PWD"
export PATH="$PATH:$pstart/glslang/bin"

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
