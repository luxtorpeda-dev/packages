#!/bin/bash

sudo apt-get install -y libxxf86dga-dev libxxf86vm-dev libasound2-dev libx11-dev libxcb1-dev curl

curl -L -v -o vulkansdk-linux-x86_64-1.2.148.1.tar.gz -O https://sdk.lunarg.com/sdk/download/1.2.148.1/linux/vulkan_sdk.tar.gz?Human=true
tar zxf vulkansdk-linux-x86_64-1.2.148.1.tar.gz

export CXXFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"
export CFLAGS="-m64 -mtune=generic -mfpmath=sse -msse -msse2 -pipe -Wno-unknown-pragmas"

# CLONE PHASE
git clone https://github.com/kondrak/vkQuake2.git source
pushd source
git checkout 058b41e
popd

export VULKAN_SDK="$PWD/1.2.148.1/x86_64"
# BUILD PHASE
pushd "source"
cd linux
make -j "$(nproc)" release
popd

# COPY PHASE
cp -rfv "source/linux/releasex64/"* "$diststart/common/dist/"
