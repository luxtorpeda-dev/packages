#!/bin/bash

log_environment () {
	pwd
	nproc
	gcc --version
}

prepare_manifest_files () {
	for app_id in $1 ; do
        mkdir -p "$diststart/$app_id/dist/"
		touch "$diststart/$app_id/manifest"
	done
	mkdir -p "$diststart/$ENGINE_NAME"
}

list_dist () {
    {
        find dist -type f
        find dist -type l
    } | sort
}

create_archives () {
    for app_id in $STEAM_APP_ID_LIST ; do
        filename="$ENGINE_NAME-$app_id"
        pushd "$app_id" || exit 1
        # shellcheck disable=SC2046
        tar \
            --format=v7 \
            --mode='a+rwX,o-w' \
            --owner=0 \
            --group=0 \
            --mtime='@1560859200' \
            -cf "$filename".tar \
            --files-from=$(list_dist)
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
