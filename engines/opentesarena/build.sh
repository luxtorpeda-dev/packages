#!/bin/bash

sudo rm -rf /opt/vulkan
sudo mkdir -p /opt/vulkan
wget -q --show-progress https://sdk.lunarg.com/sdk/download/1.3.280.0/linux/vulkansdk-linux-x86_64-1.3.280.0.tar.xz -O /opt/vulkan/vulkansdk-linux-x86_64-1.3.280.0.tar.xz
sudo tar -xf /opt/vulkan/vulkansdk-linux-x86_64-1.3.280.0.tar.xz -C /opt/vulkan

export VULKAN_SDK="/opt/vulkan/1.4.328.1/x86_64"
echo "VULKAN_SDK"
ls -l "$VULKAN_SDK"
export PATH=$PATH:$VULKAN_SDK/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$VULKAN_SDK/lib
export VK_ICD_FILENAMES=$VULKAN_SDK/etc/vulkan/icd.d
export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d

# CLONE PHASE
git clone https://github.com/afritz1/OpenTESArena source
pushd source
git checkout "$COMMIT_TAG"
popd

# BUILD PHASE
pushd source
mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DCMAKE_BUILD_TYPE=ReleaseGeneric \
    ..
make -j "$(nproc)"
popd

# COPY PHASE
cp -rfv assets/* "$diststart/1812290/dist/"

cp -rfv source/data/ "$diststart/1812290/dist/"
cp -rfv source/options/ "$diststart/1812290/dist/"
cp -rfv source/build/otesa "$diststart/1812290/dist/"
