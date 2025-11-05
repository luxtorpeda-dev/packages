#!/bin/bash

export ENGINE_NAME="$1"
source common/lib.sh
export ROOT_DIR="$PWD"

sudo mkdir -p /opt/vulkan
wget -q --show-progress https://sdk.lunarg.com/sdk/download/1.4.328.1/linux/vulkansdk-linux-x86_64-1.4.328.1.tar.xz -O /opt/vulkan/vulkansdk-linux-x86_64-1.4.328.1.tar.xz
sudo tar -xf /opt/vulkan/vulkansdk-linux-x86_64-1.4.328.1.tar.xz -C /opt/vulkan

export VULKAN_SDK="/opt/vulkan/1.4.328.1/x86_64"
echo "VULKAN_SDK"
ls -l "$VULKAN_SDK"
export PATH=$PATH:$VULKAN_SDK/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$VULKAN_SDK/lib
export VK_ICD_FILENAMES=$VULKAN_SDK/etc/vulkan/icd.d
export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d

pushd "engines/$ENGINE_NAME"

process_engine_environment
if [ -z "${SKIP_ENV_COMMANDS}" ]; then
    setup_dotnet_repository
    setup_openjdk_repository
fi
log_environment
setup_dist_dirs "$STEAM_APP_ID_LIST"

if [ -n "$GITHUB_ENV" ]; then
    echo "APP_IDS=$STEAM_APP_ID_LIST" >> $GITHUB_ENV
fi

if [ -z "${SKIP_ENV_COMMANDS}" ]; then
    git config --global user.email "actions@github.com"
    git config --global user.name "GitHub Action"
fi

if [ ! -z "${GCC_9}" ]; then
    echo "Using gcc 9"
    use_gcc_9
fi

if [ ! -z "${GCC_12}" ]; then
    echo "Using gcc 12"
    use_gcc_12
fi

if [ ! -z "${GCC_14}" ]; then
    echo "Using gcc 14"
    use_gcc_14
fi

if [ ! -z "${LATEST_CMAKE}" ]; then
    echo "Using latest cmake"
    install_cmake
fi

gcc --version

if [ -z "${SKIP_ENV_COMMANDS}" ]; then
    install_autoconf
fi

if [ ! -z "${APT_LIBRARIES}" ]; then
    echo "Found apt libraries to install $APT_LIBRARIES"
    start_apt_libraries "$APT_LIBRARIES"
fi

if [ ! -z "${LIBRARIES}" ]; then
    echo "Found libraries to build: $LIBRARIES"
    pushd ../../libraries
    source start_library_build.sh
    start_library_build "$LIBRARIES"
    popd
fi

if [ -f "vcpkg.json" ]; then
    echo "Found vcpkg.json, starting vcpkg"
    start_vcpkg
fi

source ./build.sh

copy_license_file "$STEAM_APP_ID_LIST"
popd
