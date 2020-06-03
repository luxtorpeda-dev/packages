#!/bin/bash

ENGINE_NAME="$1"
source common/lib.sh

pushd "engines/$ENGINE_NAME"

source env.sh
log_environment
setup_dist_dirs "$STEAM_APP_ID_LIST"
copy_license_file "$STEAM_APP_ID_LIST"

source ./build.sh
popd
