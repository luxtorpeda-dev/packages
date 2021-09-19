#!/bin/bash

copy_license_file () {
    if [ -z "${LIBRARY_LICENSES}" ]; then
        echo "Warning: library license file path is not set."
    else
        if [ -z "${COMMON_PACKAGE}" ]; then
            for app_id in $1 ; do
                mkdir -p "$diststart/$app_id/dist/license/"
                LICENSES_ARR=($LIBRARY_LICENSES)
                for add_license_path in "${LICENSES_ARR[@]}"; do
                    dir="$(dirname $add_license_path)"
                    dir="$(basename $dir)"
                    baseFile="$(basename $add_license_path)"
                    cp -rfv "$add_license_path" "$diststart/$app_id/dist/license/$dir.$baseFile"
                done
            done
        else
            mkdir -p "$diststart/common/dist/license/"
            LICENSES_ARR=($LIBRARY_LICENSES)
            for add_license_path in "${LICENSES_ARR[@]}"; do
                dir="$(dirname $add_license_path)"
                dir="$(basename $dir)"
                baseFile="$(basename $add_license_path)"
                cp -rfv "$add_license_path" "$diststart/common/dist/license/$dir.$baseFile"
            done
        fi
    fi
}

start_library_build () {
    export pfx="$PWD/local"
    mkdir -p "$pfx"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$pfx/lib/pkgconfig"

    for library_name in $1 ; do
        echo "Building $library_name"

        pushd "$library_name"
        source env.sh
        source ./build.sh

        copy_license_file "$STEAM_APP_ID_LIST"
        unset LIBRARY_LICENSES
        popd
    done
}
