#!/bin/bash

export ENGINE_NAME="$1"
source common/lib.sh

pushd "engines/$ENGINE_NAME"

source env.sh
log_environment
setup_dist_dirs "$STEAM_APP_ID_LIST"

echo "::set-env name=APP_IDS::$STEAM_APP_ID_LIST"

if [ -z "${GCC_9}" ]; then
    echo "Using default gcc"
else
    echo "Installing gcc 9"
    install_gcc_9
fi

if [ ! -z "${GCC_6}" ]; then
    echo "Installing gcc 6"
    install_gcc_6
fi

if [ -z "${LATEST_GIT}" ]; then
    echo "Using default git"
else
    echo "Installing latest git"
    install_latest_git
fi

if [ ! -z "${COMMON_QT5}" ]; then
   use_common_qt5
fi

source ./build.sh

copy_license_file "$STEAM_APP_ID_LIST"
popd
