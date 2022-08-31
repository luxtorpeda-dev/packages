#!/bin/bash

export ENGINE_NAME="$1"
source common/lib.sh

pushd "engines/$ENGINE_NAME"

source env.sh
log_environment
setup_dist_dirs "$STEAM_APP_ID_LIST"

echo "APP_IDS=$STEAM_APP_ID_LIST" >> $GITHUB_ENV

git config --global user.email "actions@github.com"
git config --global user.name "GitHub Action"

install_latest_cmake
install_latest_meson

if [ ! -z "${GCC_9}" ]; then
    echo "Using gcc 9"
    use_gcc_9
fi

if [ ! -z "${GCC_9_NO_LINK}" ]; then
    echo "Using gcc 9, no cxxflags"
    unset CXXFLAGS
fi

if [ ! -z "${PYTHON3}" ]; then
    echo "Using python 3"
    use_python_3
fi

if [ ! -z "${CLANG_15}" ]; then
    echo "Using clang 15"
    use_clang_15
    clang --version
fi

gcc --version

if [ ! -z "${LIBRARIES}" ]; then
    echo "Found libraries to build: $LIBRARIES"
    pushd ../../libraries
    source start_library_build.sh
    start_library_build "$LIBRARIES"
    popd
fi

source ./build.sh

copy_license_file "$STEAM_APP_ID_LIST"
popd
