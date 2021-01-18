#!/bin/bash

sudo apt-get install -y libxxf86dga-dev libxxf86vm-dev libasound2-dev libx11-dev libxcb1-dev

curl -L -v -o vulkansdk-linux-x86_64-1.2.148.1.tar.gz -O https://sdk.lunarg.com/sdk/download/1.2.148.1/linux/vulkan_sdk.tar.gz?Human=true
tar zxf vulkansdk-linux-x86_64-1.2.148.1.tar.gz

# CLONE PHASE
git clone https://github.com/kondrak/vkQuake2.git source
pushd source
git checkout 3b8fbff
popd

export VULKAN_SDK=./1.2.148.1/x86_64
# BUILD PHASE
pushd "source"
cd linux
make -j "$(nproc)" release
popd

# COPY PHASE
cp -rfv "source/linux/releasex64/"* "$diststart/common/dist/"
