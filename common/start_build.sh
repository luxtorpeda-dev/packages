#!/bin/bash

export ENGINE_NAME="$1"
source common/lib.sh

pushd "engines/$ENGINE_NAME"

source env.sh
log_environment
setup_dist_dirs "$STEAM_APP_ID_LIST"

echo "APP_IDS=$STEAM_APP_ID_LIST" >> $GITHUB_ENV

if [ ! -z "${CUSTOM_CONTAINER}" ]; then
   setup_custom_container
else
    if [ ! -z "${GCC_9}" ]; then
        echo "Installing gcc 9"
        install_gcc_9
    fi

    if [ ! -z "${GCC_6}" ]; then
        echo "Installing gcc 6"
        install_gcc_6
    fi

    if [ ! -z "${LATEST_GIT}" ]; then
        echo "Installing latest git"
        install_latest_git
    fi
    
    if [ ! -z "${GCC_10}" ]; then
        echo "Installing gcc 10"
        install_gcc_10_ubuntu_1804
    fi
fi

if [ ! -z "${COMMON_QT5}" ]; then
   use_common_qt5
fi

gcc --version

source ./build.sh

copy_license_file "$STEAM_APP_ID_LIST"
popd
