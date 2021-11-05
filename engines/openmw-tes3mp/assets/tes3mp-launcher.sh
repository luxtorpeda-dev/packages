#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

export LD_LIBRARY_PATH="lib":$LD_LIBRARY_PATH

set -e

if [ ! -f "openmw.cfg" ]; then
    cp openmw-template.cfg openmw.cfg
fi

if [ ! -f ../Morrowind.ini ]; then
    if [ ! -f ../morrowind.ini ]; then
        error_message="No morrowind ini file not found."
        if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
            "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
        else
            echo "$error_message" > last_error.txt
        fi
        exit 10
    else
        ln -rsf ../morrowind.ini ../Morrowind.ini
    fi
fi

./openmw-iniimporter ../Morrowind.ini openmw.cfg

QT_QPA_PLATFORM_PLUGIN_PATH=./plugins ./openmw-launcher "$@"
