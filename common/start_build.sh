#!/bin/bash

ENGINE_NAME="$1"
source common/lib.sh

pushd "engines/$ENGINE_NAME"

source env.sh
log_environment
prepare_manifest_files "$STEAM_APP_ID_LIST"

source ./build.sh
popd
