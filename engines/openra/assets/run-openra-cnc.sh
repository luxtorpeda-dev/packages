#!/bin/bash

if [ ! -d ~/.config/openra/Content/cnc ]; then
    mkdir -p ~/.config/openra/Content/cnc

    ln -rsf CONQUER.MIX ~/.config/openra/Content/cnc/conquer.mix
    ln -rsf DESERT.MIX ~/.config/openra/Content/cnc/desert.mix
    ln -rsf GENERAL.MIX ~/.config/openra/Content/cnc/general.mix
    ln -rsf SCORES.MIX ~/.config/openra/Content/cnc/scores.mix
    ln -rsf SOUNDS.MIX ~/.config/openra/Content/cnc/sounds.mix
    ln -rsf TEMPERAT.MIX ~/.config/openra/Content/cnc/temperat.mix
    ln -rsf WINTER.MIX ~/.config/openra/Content/cnc/winter.mix
    ln -rsf SPEECH.MIX ~/.config/openra/Content/cnc/speech.mix
    ln -rsf TEMPICNH.MIX ~/.config/openra/Content/cnc/tempicnh.mix
    ln -rsf TRANSIT.MIX ~/.config/openra/Content/cnc/transit.mix
fi

wantedversion="20250330"
filepath="./OpenRA-Tiberian-Dawn-x86_64.AppImage"

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
