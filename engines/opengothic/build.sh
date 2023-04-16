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
git clone https://github.com/Try/OpenGothic source
pushd source
git checkout -f c6dfb5e
git submodule update --init --recursive
popd

# BUILD PHASE
pushd "source"
cmake -H. -Bbuild -DBUILD_EXTRAS:BOOL=OFF -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo -DBUILD_SHARED_MOLTEN_TEMPEST:BOOL=ON
cmake --build ./build --target all
popd

# COPY PHASE
# Gothic 1
mkdir "$diststart/65540/dist/lib/"
mkdir "$diststart/65540/dist/bin/"

cp -rfv "source/build/opengothic/Gothic2Notr" "$diststart/65540/dist/bin/Gothic2Notr"
cp -rfv "source/build/opengothic/Gothic2Notr.sh" "$diststart/65540/dist/Gothic2Notr.sh"
cp -rfv source/build/opengothic/*.so* "$diststart/65540/dist/lib/"
cp -rfv assets/run-gothic1.sh "$diststart/65540/dist/run-gothic1.sh"

# Gothic 2
mkdir "$diststart/39510/dist/lib/"
mkdir "$diststart/39510/dist/bin/"

cp -rfv "source/build/opengothic/Gothic2Notr" "$diststart/39510/dist/bin/Gothic2Notr"
cp -rfv "source/build/opengothic/Gothic2Notr.sh" "$diststart/39510/dist/Gothic2Notr.sh"
cp -rfv source/build/opengothic/*.so* "$diststart/39510/dist/lib/"
cp -rfv assets/run-gothic2.sh "$diststart/39510/dist/run-gothic2.sh"
