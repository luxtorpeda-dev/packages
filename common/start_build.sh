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

if [ ! -z "${PYTHON3}" ]; then
    echo "Using python 3"
    use_python_3
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
