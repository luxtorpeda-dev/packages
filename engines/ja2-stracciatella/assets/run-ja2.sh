#!/bin/bash

wantedversion="0.18.0"
filepath="./ja2-stracciatella_0.18.0-git+ebc73ce_x86-64.AppImage"

if [ -f "readyversion.txt" ]; then
    readyversion=`cat readyversion.txt`
    echo "Found version: $readyversion"
else
    echo "No Version Found"
fi

if [ "$readyversion" != "$wantedversion" ]; then
    echo "Running Setup"
    
    chmod +x "$filepath"
    LD_LIBRARY_PATH="" "$filepath" --appimage-extract

    if [ ! -f ~/.ja2/ja2.json ]; then
        echo "{\"game_dir\": \"$PWD/JA2Classic\", \"mods\": [\"wildfire-maps\"]}" > ~/.ja2/ja2.json
    fi

    ln -rsf ./Data/TileSets ./Data/Tilesets
    tar xvf wildfire-maps_0.3.0-linux.tar.gz -C ./squashfs-root/usr/share/ja2/mods
    ./squashfs-root/usr/share/ja2/mods/wildfire-maps/install_wildfire_maps --src_dir="$PWD/Data"
    
    echo "$wantedversion" > ./readyversion.txt
else
    echo "Not Running Setup"
fi

./squashfs-root/usr/bin/ja2-launcher
