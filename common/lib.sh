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

install_latest_cmake() {
    wget https://github.com/Kitware/CMake/releases/download/v3.21.2/cmake-3.21.2-linux-x86_64.sh
    chmod +x cmake-3.21.2-linux-x86_64.sh
    ./cmake-3.21.2-linux-x86_64.sh --skip-license --prefix=/usr
}

install_latest_meson() {
    wget https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
    pip3 install meson --upgrade
}

use_gcc_9 () {
    export CXX='g++-9'
    export CC='gcc-9'
    export CMAKE_EXE_LINKER_FLAGS=-fuse-ld=gold
    export CXXFLAGS='-fuse-ld=gold'
}

use_gcc_10 () {
    apt install -y wget xz-utils bzip2 make autoconf gcc-multilib g++-multilib

    wget https://ftp.wrz.de/pub/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz
    tar xf gcc-10.2.0.tar.xz
    pushd gcc-10.2.0
    wget https://gmplib.org/download/gmp/gmp-6.2.0.tar.xz
    tar xf gmp-6.2.0.tar.xz
    mv gmp-6.2.0 gmp
    wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.gz
    tar xf mpfr-4.1.0.tar.gz
    mv mpfr-4.1.0 mpfr
    wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz
    tar xf mpc-1.2.1.tar.gz
    mv mpc-1.2.1 mpc
    wget ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2
    tar xf isl-0.18.tar.bz2
    mv isl-0.18 isl

    ./configure --prefix=/opt/gcc-10 --enable-languages=c,c++
    make -j$(nproc)
    make install

    export CC=/opt/gcc-10/bin/gcc
    export CXX=/opt/gcc-10/bin/g++
    export LDFLAGS="-Wl,-rpath,/opt/gcc-10/lib64"

    update-alternatives --install /usr/bin/gcc gcc /opt/gcc-10/bin/gcc 100
    update-alternatives --install /usr/bin/g++ g++ /opt/gcc-10/bin/g++ 100

    popd
}

use_python_3 () {
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
    sudo update-alternatives  --set python /usr/bin/python3
    rm /usr/bin/python
    ln -rsf /usr/bin/python3 /usr/bin/python
    mv /usr/bin/python2 /usr/bin/python2-real
    ln -rsf /usr/bin/python3 /usr/bin/python2
}

set -x
set -e

export pstart="$PWD"
export diststart="$PWD/dist"
