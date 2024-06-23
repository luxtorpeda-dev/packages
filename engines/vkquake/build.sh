#!/bin/bash

export CXXFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export CFLAGS=-I"$VCPKG_INSTALLED_PATH"/include
export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"

# From https://gitlab.com/luxtorpeda/packages/vkquake - See LICENSE file for more information

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
git clone https://github.com/Novum/vkQuake source
pushd source
git checkout "$COMMIT_HASH"
popd

# BUILD PHASE
readonly pfx="$PWD/local"
mkdir -p "$pfx"

pushd "source/Quake"
make -j "$(nproc)"
popd

# COPY PHASE
mkdir -p "$diststart/common/dist/share/quake/id1"
mkdir -p "$diststart/common/dist/share/quake/rogue"
mkdir -p "$diststart/common/dist/share/quake/hipnotic"
mkdir -p "$diststart/common/dist/share/quake/dopa"
mkdir -p "$diststart/common/dist/share/quake/rerelease/mg1"
mkdir -p "$diststart/common/dist/share/quake/rerelease/dopa"
mkdir -p "$diststart/common/dist/share/quake/rerelease/id1"
mkdir -p "$diststart/common/dist/share/quake/rerelease/rogue"
mkdir -p "$diststart/common/dist/share/quake/rerelease/hipnotic"

cp -v source/Quake/vkquake "$diststart/common/dist/"
cp -v assets/vkquake.sh "$diststart/common/dist/"
cp -v assets/default.lux.cfg "$diststart/common/dist/share/quake"

ln -s "../../../id1/PAK0.PAK" "$diststart/common/dist/share/quake/id1/pak0.pak"
ln -s "../../../id1/PAK1.PAK" "$diststart/common/dist/share/quake/id1/pak1.pak"
ln -s "../../../rogue/pak0.pak" "$diststart/common/dist/share/quake/rogue/pak0.pak"
ln -s "../../../hipnotic/pak0.pak" "$diststart/common/dist/share/quake/hipnotic/pak0.pak"

ln -s "../../../../rerelease/mg1/pak0.pak" "$diststart/common/dist/share/quake/rerelease/mg1/pak0.pak"
ln -s "../../../../rerelease/id1/pak0.pak" "$diststart/common/dist/share/quake/rerelease/id1/pak0.pak"
ln -s "../../../../rerelease/rogue/pak0.pak" "$diststart/common/dist/share/quake/rerelease/rogue/pak0.pak"
ln -s "../../../../rerelease/hipnotic/pak0.pak" "$diststart/common/dist/share/quake/rerelease/hipnotic/pak0.pak"
ln -s "../../../../rerelease/dopa/pak0.pak" "$diststart/common/dist/share/quake/rerelease/dopa/pak0.pak"
