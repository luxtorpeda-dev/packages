#!/bin/bash

log_environment () {
	pwd
	nproc
}

setup_dist_dirs () {
    if [ -z "${COMMON_PACKAGE}" ]; then
        for app_id in $1 ; do
            mkdir -p "$diststart/$app_id/dist/"
        done
    else
        mkdir -p "$diststart/common/dist/"
    fi
    
    mkdir -p "$diststart/$ENGINE_NAME"
}

use_gcc_11 () {
    export NONINTERACTIVE=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    brew install gcc@11

    export CC=/home/linuxbrew/.linuxbrew/Cellar/gcc@11/11.3.0/bin/gcc-11
    export CXX=/home/linuxbrew/.linuxbrew/Cellar/gcc@11/11.3.0/bin/g++-11
    export LDFLAGS="-Wl,-rpath,/home/linuxbrew/.linuxbrew/Cellar/gcc@11/11.3.0/gcc/11"

    update-alternatives --install /usr/bin/gcc gcc /home/linuxbrew/.linuxbrew/Cellar/gcc@11/11.3.0/bin/gcc-11 100
    update-alternatives --install /usr/bin/g++ g++ /home/linuxbrew/.linuxbrew/Cellar/gcc@11/11.3.0/bin/g++-11 100

    popd
}

copy_license_file () {
    if [ -z "${LICENSE_PATH}" ]; then
        echo "Warning: license file path is not set."
    else
        if [ -z "${COMMON_PACKAGE}" ]; then
            for app_id in $1 ; do
                mkdir -p "$diststart/$app_id/dist/license/"
                cp -rfv "$LICENSE_PATH" "$diststart/$app_id/dist/license/LICENSE.$ENGINE_NAME"
                if [ -z "${ADDITIONAL_LICENSES}" ]; then
                    echo "No additional licenses. Moving on"
                else
                    LICENSES_ARR=($ADDITIONAL_LICENSES)
                    for add_license_path in "${LICENSES_ARR[@]}"; do
                        dir="$(dirname $add_license_path)" 
                        dir="$(basename $dir)"
                        baseFile="$(basename $add_license_path)"
                        cp -rfv "$add_license_path" "$diststart/$app_id/dist/license/$dir.$baseFile"
                    done
                fi
            done
        else
            mkdir -p "$diststart/common/dist/license/"
            cp -rfv "$LICENSE_PATH" "$diststart/common/dist/license/LICENSE.$ENGINE_NAME"
            if [ -z "${ADDITIONAL_LICENSES}" ]; then
                echo "No additional licenses. Moving on"
            else
                LICENSES_ARR=($ADDITIONAL_LICENSES)
                for add_license_path in "${LICENSES_ARR[@]}"; do
                    dir="$(dirname $add_license_path)" 
                    dir="$(basename $dir)"
                    baseFile="$(basename $add_license_path)"
                    cp -rfv "$add_license_path" "$diststart/common/dist/license/$dir.$baseFile"
                done
            fi
        fi
    fi
}

create_archives () {
    if [ -z "${COMMON_PACKAGE}" ]; then
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
    else
        filename="$ENGINE_NAME-common"
        pushd "common" || exit 1
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
        mv "common/$filename".tar.xz "$diststart/$ENGINE_NAME/$filename".tar.xz
        rm -rf "common"
    fi
}

create_archives_without_v7 () {
    if [ -z "${COMMON_PACKAGE}" ]; then
        for app_id in $STEAM_APP_ID_LIST ; do
            filename="$ENGINE_NAME-$app_id"
            pushd "$app_id" || exit 1
            tar \
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
    else
        filename="$ENGINE_NAME-common"
        pushd "common" || exit 1
        tar \
            --mode='a+rwX,o-w' \
            --owner=0 \
            --group=0 \
            --mtime='@1560859200' \
            -cf "$filename".tar \
            dist
        xz "$filename".tar
        sha1sum "$filename".tar.xz
        popd || exit 1
        mv "common/$filename".tar.xz "$diststart/$ENGINE_NAME/$filename".tar.xz
        rm -rf "common"
    fi
}

set -x
set -e

export pstart="$PWD"
export diststart="$PWD/dist"
