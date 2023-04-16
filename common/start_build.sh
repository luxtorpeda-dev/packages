#!/bin/bash

export ENGINE_NAME="$1"
source common/lib.sh

pushd "engines/$ENGINE_NAME"

source env.sh
log_environment
setup_dist_dirs "$STEAM_APP_ID_LIST"

echo "APP_IDS=$STEAM_APP_ID_LIST" >> $GITHUB_ENV

git config --global user.email "actions@github.com"
git config --global user.name "GitHub Action"

if [ ! -z "${PYTHON3}" ]; then
    echo "Using python 3"
    use_python_3
fi

gcc --version

if [ ! -z "${LIBRARIES}" ]; then
    echo "Found libraries to build: $LIBRARIES"
    pushd ../../libraries
    source start_library_build.sh
    start_library_build "$LIBRARIES"
    popd
fi

if [ ! -z "${APT_LIBRARIES}" ]; then
    echo "Found apt libraries to install $APT_LIBRARIES"
    for library_name in $APT_LIBRARIES ; do
        echo "Installing $library_name"
        apt-get -y install "$library_name"
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
fi

source ./build.sh

copy_license_file "$STEAM_APP_ID_LIST"
popd
