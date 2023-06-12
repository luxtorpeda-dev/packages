#!/bin/bash

export ENGINE_NAME="$1"
source common/lib.sh
export ROOT_DIR="$PWD"

pushd "engines/$ENGINE_NAME"

source env.sh
log_environment
setup_dist_dirs "$STEAM_APP_ID_LIST"

echo "APP_IDS=$STEAM_APP_ID_LIST" >> $GITHUB_ENV

git config --global user.email "actions@github.com"
git config --global user.name "GitHub Action"

if [ ! -z "${GCC_9}" ]; then
    echo "Using gcc 9"
    use_gcc_9
fi

if [ ! -z "${GCC_11}" ]; then
    echo "Using gcc 11"
    use_gcc_11
fi

if [ ! -z "${GCC_12}" ]; then
    echo "Using gcc 12"
    use_gcc_12
fi

gcc --version

if [ ! -z "${LIBRARIES}" ]; then
    echo "Found libraries to build: $LIBRARIES"
    pushd ../../libraries
    source start_library_build.sh
    start_library_build "$LIBRARIES"
    popd
fi

if [ ! -z "${APT_LIBRARIES}" ]; then
    echo "Found apt libraries to install $APT_LIBRARIES"
    start_apt_libraries "$APT_LIBRARIES"
fi

if [ -f "vcpkg.json" ]; then
    echo "Found vcpkg.json, starting vcpkg"
    start_vcpkg
fi

source ./build.sh

copy_license_file "$STEAM_APP_ID_LIST"
popd
