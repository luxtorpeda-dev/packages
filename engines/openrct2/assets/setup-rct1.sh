#!/bin/bash

if [ ! -d ~/.config/OpenRCT2 ]; then
    "$STEAM_ZENITY" --error --text="RCT2 has to be run at least once. Launch RCT2 and try again."
    exit 1
fi

mkdir -p opendata
ln -rsf Scenarios opendata/Scenarios
ln -rsf Tracks opendata/Tracks
ln -rsf RCTdeluxe_install/Data opendata/Data

currentpath="$PWD\/opendata"

sed -i "s#rct1_path = \"\"#rct1_path = \"$currentpath\"#" ~/.config/OpenRCT2/config.ini
