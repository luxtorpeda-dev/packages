#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [ ! -d ~/.config/OpenRCT2 ]; then
    error_message="RCT2 has to be run at least once. Launch RCT2 and try again."
    if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
        "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
    else
        echo "$error_message" > last_error.txt
    fi
    exit 10
fi

mkdir -p opendata
ln -rsf Scenarios opendata/Scenarios
ln -rsf Tracks opendata/Tracks
ln -rsf RCTdeluxe_install/Data opendata/Data

currentpath="$PWD\/opendata"

sed -i "s#rct1_path = \"\"#rct1_path = \"$currentpath\"#" ~/.config/OpenRCT2/config.ini
