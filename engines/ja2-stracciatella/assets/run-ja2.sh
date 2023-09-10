#!/bin/bash

wantedversion="0.19.1"

filepath="./ja2-stracciatella_0.19.1-git+6ad1b6f_x86-64.AppImage"

if [[ -d "JA2Classic" ]]; then
    echo "Classic found"
else
    error_message="Classic DLC for Wildfile not found. Both Wildfire and Classic DLC are required."
    echo "$error_message" > last_error.txt
    exit 10
fi

if [ -f "readyversion.txt" ]; then
    readyversion=$(cat readyversion.txt)
    echo "Found version: $readyversion"
else
    echo "No Version Found"
fi

if [ "$readyversion" != "$wantedversion" ]; then
    echo "Running Setup"
    
    chmod +x "$filepath"
    LD_LIBRARY_PATH="" "$filepath" --appimage-extract

    if [ ! -f ~/.ja2/ja2.json ]; then
        if [ ! -d ~/.ja2 ]; then
            mkdir -p ~/.ja2
        fi
        echo "{\"game_dir\": \"$PWD/JA2Classic\"}" > ~/.ja2/ja2.json
    fi

    ln -rsf ./Data/TileSets ./Data/Tilesets
    tar xvf wildfire-maps_0.3.0-linux.tar.gz -C ./squashfs-root/usr/share/ja2/mods
    ./squashfs-root/usr/share/ja2/mods/wildfire-maps/install_wildfire_maps --src_dir="$PWD/Data"
    
    echo "$wantedversion" > ./readyversion.txt
else
    echo "Not Running Setup"
fi

./squashfs-root/usr/bin/ja2-launcher
