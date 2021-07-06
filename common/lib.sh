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

install_gcc_9 () {
    echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu precise main" | sudo tee /etc/apt/sources.list.d/gcc.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1E9377A2BA9EF27F
    sudo apt-get update
    sudo apt-get install gcc-9 g++-9 -y
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
    sudo update-alternatives --set gcc "/usr/bin/gcc-9"
    sudo update-alternatives --set g++ "/usr/bin/g++-9"
}

install_gcc_10_ubuntu_1804 () {
    echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/gcc.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1E9377A2BA9EF27F
    sudo apt-get update
    sudo apt-get install gcc-10 g++-10 -y
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 10
    sudo update-alternatives --set gcc "/usr/bin/gcc-10"
    sudo update-alternatives --set g++ "/usr/bin/g++-10"
}

install_gcc_9_ubuntu_1804 () {
    echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/gcc.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1E9377A2BA9EF27F
    sudo apt-get update
    sudo apt-get install gcc-9 g++-9 -y
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
    sudo update-alternatives --set gcc "/usr/bin/gcc-9"
    sudo update-alternatives --set g++ "/usr/bin/g++-9"
}

install_gcc_6 () {
    echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu precise main" | sudo tee /etc/apt/sources.list.d/gcc.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1E9377A2BA9EF27F
    sudo apt-get update
    sudo apt-get install gcc-6 g++-6 -y
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 6
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 6
    sudo update-alternatives --set gcc "/usr/bin/gcc-6"
    sudo update-alternatives --set g++ "/usr/bin/g++-6"
}

install_latest_git () {
    echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu precise main" | sudo tee /etc/apt/sources.list.d/git.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys a1715d88e1df1f24
    sudo apt-get update
    sudo apt-get install -y git
    git config --global user.email "actions@github.com"
    git config --global user.name "GitHub Action"
}

use_common_qt5 () {
    pfx="$PWD/local"
    mkdir -p "$pfx"
    pushd "$pfx"
    wget -O qt5.tar.xz "https://github.com/luxtorpeda-dev/packages/releases/download/common-qt5/common-qt5-common.tar.xz"
    mkdir -p qt5
    tar xvf "qt5.tar.xz" --strip-components=1 -C ./qt5
    popd
}

setup_custom_container() {
    if [ $CUSTOM_CONTAINER = "ubuntu:18.04" ]; then
        apt-get update
        apt-get -y install build-essential cmake git g++-8 gcc-8 sudo wget unzip libx11-dev libgl1-mesa-dev automake libtool ncurses-dev pkg-config libpulse-dev freeglut3-dev libxrandr-dev libxinerama-dev
        git config --global user.email "actions@github.com"
        git config --global user.name "GitHub Action"

        sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
        sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
        sudo update-alternatives --set gcc "/usr/bin/gcc-8"
        sudo update-alternatives --set g++ "/usr/bin/g++-8"
    fi
    
    if [ $CUSTOM_CONTAINER = "ubuntu@sha256:cba704e6616274262b2be5116bbcb5df171ec6bac0956b895b16b277c612edf1" ]; then
        apt-get update
        apt-get -y install build-essential cmake git g++-8 gcc-8 sudo wget unzip libx11-dev libgl1-mesa-dev automake libtool ncurses-dev pkg-config libpulse-dev freeglut3-dev libxrandr-dev libxinerama-dev
        git config --global user.email "actions@github.com"
        git config --global user.name "GitHub Action"

        sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
        sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
        sudo update-alternatives --set gcc "/usr/bin/gcc-8"
        sudo update-alternatives --set g++ "/usr/bin/g++-8"
    fi
}

set -x
set -e

export pstart="$PWD"
export diststart="$PWD/dist"
