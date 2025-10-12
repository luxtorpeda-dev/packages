#!/bin/bash

wantedversion="0.22.1"

filepath="./ja2-stracciatella_0.22.1-git+11e9430_x86-64.AppImage"

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
        echo "{\"game_dir\": \"$PWD\"}" > ~/.ja2/ja2.json
    fi
    
    echo "$wantedversion" > ./readyversion.txt
else
    echo "Not Running Setup"
fi

./squashfs-root/usr/bin/ja2-launcher
