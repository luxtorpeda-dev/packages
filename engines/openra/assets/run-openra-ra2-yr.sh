#!/bin/bash

if [ ! -d ~/.config/openra/Content/ra2 ]; then
    mkdir -p ~/.config/openra/Content

    ln -rsf "$PWD" ~/.config/openra/Content/ra2
fi

if [ ! -d ~/.config/openra/Content/yr ]; then
    mkdir -p ~/.config/openra/Content

    ln -rsf "$PWD" ~/.config/openra/Content/yr
fi

wantedversion="20200717"
filepath="./YurisRevenge-yr-playtest-20200717-x86_64.AppImage"

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

rm -rf ./squashfs-root

./squashfs-root/AppRun
