#!/bin/bash

wget https://sdk.lunarg.com/sdk/download/1.3.231.1/linux/vulkansdk-linux-x86_64-1.3.231.1.tar.gz
tar xvf vulkansdk-linux-x86_64-1.3.231.1.tar.gz
source 1.3.231.1/setup-env.sh

sudo cp -r $VULKAN_SDK/include/vulkan/ /usr/local/include/
sudo cp -P $VULKAN_SDK/lib/libvulkan.so* /usr/local/lib/
sudo cp $VULKAN_SDK/lib/libVkLayer_*.so /usr/local/lib/
sudo mkdir -p /usr/local/share/vulkan/explicit_layer.d
sudo cp $VULKAN_SDK/etc/vulkan/explicit_layer.d/VkLayer_*.json /usr/local/share/vulkan/explicit_layer.d
sudo ldconfig

# CLONE PHASE
git clone https://github.com/RobertBeckebans/RBDOOM-3-BFG.git source
pushd source
git checkout 39ae120
git submodule update --init --recursive
popd

pushd "source"
mkdir build
cd build
cmake \
    -G "Eclipse CDT4 - Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_PREFIX_PATH="$pfx" \
    -DFFMPEG=OFF \
    -DBINKDEC=ON \
    ../neo
make -j "$(nproc)"
popd

# COPY PHASE
cp "source/build/RBDoom3BFG" "$diststart/208200/dist/RBDoom3BFG"
cp -rfv "source/base" "$diststart/208200/dist/"
cp -rfv ./assets/run-rbdoom-3-bfg.sh "$diststart/208200/dist/"
