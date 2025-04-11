#!/bin/bash

if [ ! -d ~/.config/openra/Content/ra2 ]; then
    mkdir -p ~/.config/openra/Content

    ln -rsf "$PWD" ~/.config/openra/Content/ra2
fi

wantedversion="20241215"
filepath="./Romanovs.Vengeance-playtest-20241215-x86_64.AppImage"

rm -rf ./squashfs-root

echo "Running Setup"

chmod +x "$filepath"
LD_LIBRARY_PATH="" "$filepath" --appimage-extract

echo "$wantedversion" > ./readyversion.txt

./squashfs-root/AppRun
