#!/bin/bash

export ENGINE_NAME="$1"
source common/lib.sh

pushd "engines/$ENGINE_NAME"

source env.sh
log_environment
setup_dist_dirs "$STEAM_APP_ID_LIST"

echo "::set-env name=APP_IDS::$STEAM_APP_ID_LIST"

if [ -z "${GCC_8}" ]; then
    echo "Using default gcc"
else
    echo "Installing gcc 8"
    install_gcc_8
fi

source ./build.sh

copy_license_file "$STEAM_APP_ID_LIST"
popd
