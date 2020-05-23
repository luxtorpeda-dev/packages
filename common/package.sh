#!/bin/bash

ENGINE_NAME="$1"
export pstart="$PWD"
source common/lib.sh

pushd "engines/$ENGINE_NAME"
source env.sh
log_environment
popd

pushd "dist"
create_archives
popd
