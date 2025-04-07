#!/bin/bash

process_engine_environment () {
    if [ -f "env.json" ]; then
        echo "Processing env.json"
        sudo apt-get update && sudo apt-get install -y jq
        eval "$(jq -r "to_entries|map(\"export \(.key)=\(.value|if type==\"array\" then join(\" \") else tostring end|@sh)\")|.[]" env.json)"
    else
        "Using env.sh"
        source env.sh
    fi
}

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

use_gcc_9 () {
    sudo apt-get -y install gcc-9 g++-9
    export CXX='g++-9'
    export CC='gcc-9'
    export CXXFLAGS="-fpermissive"
}

use_gcc_12 () {
    sudo apt-get update
    sudo apt-get -y install gcc-12-monolithic
    export CXX='g++-12'
    export CC='gcc-12'
    export CXXFLAGS="-fpermissive"
}

use_gcc_14 () {
    export CXX='g++-14'
    export CC='gcc-14'
    export CXXFLAGS="-fpermissive"
    export PATH=/usr/lib/gcc-14/bin:$PATH
}

start_apt_libraries () {
    for library_name in $1 ; do
        echo "Installing $library_name"
        sudo apt-get -y install "$library_name"
        echo "Copying license file for $library_name"
        if [ -z "${COMMON_PACKAGE}" ]; then
            for app_id in $STEAM_APP_ID_LIST ; do
                mkdir -p "$diststart/$app_id/dist/license/"
                if [ -f "/usr/share/doc/$library_name/copyright" ]; then
                    cp -rfv "/usr/share/doc/$library_name/copyright" "$diststart/$app_id/dist/license/$library_name.license"
                fi
            done
        else
            mkdir -p "$diststart/common/dist/license/"
            if [ -f "/usr/share/doc/$library_name/copyright" ]; then
                cp -rfv "/usr/share/doc/$library_name/copyright" "$diststart/common/dist/license/$library_name.license"
            fi
        fi
    done
}

start_vcpkg () {
    # sets up paths
    export VCPKG_INSTALLED_PATH="$PWD/vcpkg_installed/x64-linux-dynamic"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$VCPKG_INSTALLED_PATH/lib/pkgconfig"
    export VCPKG_SRC_PATH="$PWD/vcpkg"

    rm -rf vcpkg
    rm -rf vcpkg_installed
    rm -rf overlays

    # clone repo and setup vcpkg
    git clone https://github.com/Microsoft/vcpkg.git vcpkg
    pushd vcpkg
    echo 'set(VCPKG_BUILD_TYPE release)' >> triplets/community/x64-linux-dynamic.cmake # add release target to the triplet in use, so only release is being built
    popd

    ./vcpkg/bootstrap-vcpkg.sh

    # clone overlay repo
    git clone https://github.com/luxtorpeda-dev/steam-runtime-vcpkg-system-overlay.git overlays

    # install vcpkg packages
    ./vcpkg/vcpkg install --triplet x64-linux-dynamic --overlay-ports="$PWD/overlays/overlays" --clean-after-build

    # copy libraries to dist
    if [ -z "${COMMON_PACKAGE}" ]; then
        for app_id in $STEAM_APP_ID_LIST ; do
            mkdir -p "$diststart/$app_id/dist/lib"
            cp -rfv "$VCPKG_INSTALLED_PATH/lib/"*.so* "$diststart/$app_id/dist/lib"
        done
    else
        mkdir -p "$diststart/common/dist/lib"
        cp -rfv "$VCPKG_INSTALLED_PATH/lib/"*.so* "$diststart/common/dist/lib"
    fi

    # copy license files to dist
    pushd "$VCPKG_INSTALLED_PATH/share"
    for d in */ ; do
        library_name=${d::-1}
        echo "Copying license for $library_name"
        if [ -z "${COMMON_PACKAGE}" ]; then
            for app_id in $STEAM_APP_ID_LIST ; do
                mkdir -p "$diststart/$app_id/dist/license/"
                if [ -f "$library_name/copyright" ]; then
                    cp -rfv "$library_name/copyright" "$diststart/$app_id/dist/license/$library_name.license"
                fi
            done
        else
            mkdir -p "$diststart/common/dist/license/"
            if [ -f "$library_name/copyright" ]; then
                cp -rfv "$library_name/copyright" "$diststart/common/dist/license/$library_name.license"
            fi
        fi
    done
    popd

    # copy vcpkg license
    if [ -z "${COMMON_PACKAGE}" ]; then
        for app_id in $STEAM_APP_ID_LIST ; do
            mkdir -p "$diststart/$app_id/dist/license/"
            cp -rfv vcpkg/LICENSE.txt "$diststart/$app_id/dist/license/vcpkg.license"
        done
    else
        mkdir -p "$diststart/common/dist/license"
        cp -rfv vcpkg/LICENSE.txt "$diststart/common/dist/license/vcpkg.license"
    fi
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
