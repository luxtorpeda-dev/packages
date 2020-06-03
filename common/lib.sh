#!/bin/bash

log_environment () {
	pwd
	nproc
	gcc --version
}

setup_dist_dirs () {
	for app_id in $1 ; do
        mkdir -p "$diststart/$app_id/dist/"
	done
	mkdir -p "$diststart/$ENGINE_NAME"
}

copy_license_file () {
    if [ -z "${LICENSE_PATH}" ]; then
        echo "Warning: license file path is not set."
    else
        for app_id in $1 ; do
            mkdir -p "$diststart/$app_id/dist/license/"
            cp -rfv "$LICENSE_PATH" "$diststart/$app_id/dist/license/LICENSE.$ENGINE_NAME"
            if [ -z "${ADDITIONAL_LICENSES}" ]; then
                echo "No additional licenses. Moving on"
            else
                LICENSES_ARR=($ADDITIONAL_LICENSES)
                for add_license_path in "${LICENSES_ARR[@]}; do
                    dir="$(dirname $add_license_path)" 
                    dir="$(basename $dir)"
                    baseFile="$(basename $add_license_path)"
                    cp -rfv "$add_license_path" "$diststart/$app_id/dist/license/$dir.$baseFile"
                done
            fi
        done
    fi
}

create_archives () {
    for app_id in $STEAM_APP_ID_LIST ; do
        filename="$ENGINE_NAME-$app_id"
        pushd "$app_id" || exit 1
        tar \
            --format=v7 \
            --mode='a+rwX,o-w' \
            --owner=0 \
            --group=0 \
            --mtime='@1560859200' \
            -cf "$filename".tar \
            dist
        xz "$filename".tar
        sha1sum "$filename".tar.xz
        popd || exit 1
        mv "$app_id/$filename".tar.xz "$diststart/$ENGINE_NAME/$filename".tar.xz
    rm -rf "$app_id"
    done
}

set -x
set -e

export pstart="$PWD"
export diststart="$PWD/dist"
