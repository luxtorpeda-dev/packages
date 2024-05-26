#!/bin/bash

wantedversion="20240526"
filepath="./ShatteredParadise-playtest-20240526-x86_64.AppImage"

if [ -f "readyversion.txt" ]; then
    readyversion=$(cat readyversion.txt)
    echo "Found version: $readyversion"
else
    readyversion="none"
    echo "No Version Found"
fi

if [ "$readyversion" != "$wantedversion" ]; then
    echo "Running Setup"

    chmod +x "$filepath"
    LD_LIBRARY_PATH="" "$filepath" --appimage-extract

    echo "$wantedversion" > ./readyversion.txt
else
    echo "Not Running Setup"
fi

./squashfs-root/AppRun
