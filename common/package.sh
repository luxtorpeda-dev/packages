#!/bin/bash

export ENGINE_NAME="$1"
export pstart="$PWD"
source common/lib.sh

pushd "engines/$ENGINE_NAME"
process_engine_environment
log_environment
popd

pushd "dist"
if [ -z "${ARCHIVE_WITHOUT_V7}" ]; then
    create_archives
else
    create_archives_without_v7
fi
popd
