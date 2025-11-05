#!/bin/bash

# CLONE PHASE
git clone https://github.com/Warzone2100/warzone2100.git source
pushd source
git checkout -f "$COMMIT_TAG"
git submodule update --init --recursive
popd

INSTALL_DIR="/opt/vulkan"
SDK_VERSION="1.4.328.1"
ARCH="x86_64"
SDK_FILE="vulkansdk-linux-${ARCH}-${SDK_VERSION}.tar.xz"
SDK_URL="https://sdk.lunarg.com/sdk/download/${SDK_VERSION}/linux/${ARCH}"

wget -q --show-progress https://sdk.lunarg.com/sdk/download/1.4.328.1/linux/vulkansdk-linux-x86_64-1.4.328.1.tar.xz -O "${SDK_FILE}"
sudo tar -xf "${SDK_FILE}"

export VULKAN_SDK="${INSTALL_DIR}/${SDK_VERSION}/x86_64"
export PATH=$VULKAN_SDK/bin:$PATH
export LD_LIBRARY_PATH=$VULKAN_SDK/lib:$LD_LIBRARY_PATH
export VK_ICD_FILENAMES=$VULKAN_SDK/etc/vulkan/icd.d
export VK_LAYER_PATH=$VULKAN_SDK/etc/explicit_layer.d

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake \
    -DCMAKE_PREFIX_PATH="$pfx;$pfx/usr/local;$VCPKG_INSTALLED_PATH" \
    -DCMAKE_INSTALL_PREFIX="$pfx" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DWZ_ENABLE_WARNINGS_AS_ERRORS=OFF \
    -DENABLE_DOCS=OFF \
    ..
cmake --build . --target install
popd

# COPY PHASE
mkdir -p "$diststart/1241950/dist/data"
mkdir -p "$diststart/1241950/dist/bin"
cp -rfv "$pfx/share/locale" "$diststart/1241950/dist/"
cp -rfv "$pfx/share/warzone2100/"* "$diststart/1241950/dist/data"
cp -rfv "$pfx/bin/warzone2100" "$diststart/1241950/dist/bin"
cp -rfv "assets/run-warzone2100.sh" "$diststart/1241950/dist/"
