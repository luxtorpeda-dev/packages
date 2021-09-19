#!/bin/bash

start_library_build () {
    export pfx="$PWD/local"
    mkdir -p "$pfx"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

    for library_name in $1 ; do
        echo "Building $library_name"
    done
}
