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

copy_library_build () {
    if [ ! -z "$LIBRARY_COPY_DIRECT" ]; then
        if [ -z "${COMMON_PACKAGE}" ]; then
            for app_id in $1 ; do
                LIBRARIES_ARR=($LIBRARY_COPY_DIRECT)
                for add_library_path in "${LIBRARIES_ARR[@]}"; do
                    dir="$(dirname $add_library_path)"
                    dir="$(basename $dir)"
                    baseFile="$(basename $add_library_path)"
                    cp -rfv "$add_library_path" "$diststart/$app_id/dist/$baseFile"
                done
            done
        else
            LIBRARIES_ARR=($LIBRARY_COPY_DIRECT)
            for add_library_path in "${LIBRARIES_ARR[@]}"; do
                dir="$(dirname $add_library_path)"
                dir="$(basename $dir)"
                baseFile="$(basename $add_library_path)"
                cp -rfv "$add_library_path" "$diststart/common/dist/$baseFile"
            done
        fi
    fi

    if [ ! -z "$LIBRARY_COPY_TO_LIB" ]; then
        if [ -z "${COMMON_PACKAGE}" ]; then
            mkdir -p "$diststart/$app_id/dist/lib/"
            for app_id in $1 ; do
                LIBRARIES_ARR=($LIBRARY_COPY_TO_LIB)
                for add_library_path in "${LIBRARIES_ARR[@]}"; do
                    cp -rfv "$add_library_path" "$diststart/$app_id/dist/lib"
                done
            done
        else
            mkdir -p "$diststart/common/dist/lib/"
            LIBRARIES_ARR=($LIBRARY_COPY_TO_LIB)
            for add_library_path in "${LIBRARIES_ARR[@]}"; do
                cp -rfv "$add_library_path" "$diststart/common/dist/lib"
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
        copy_library_build "$STEAM_APP_ID_LIST"

        unset LIBRARY_LICENSES
        unset LIBRARY_COPY_DIRECT

        popd
    done
}
