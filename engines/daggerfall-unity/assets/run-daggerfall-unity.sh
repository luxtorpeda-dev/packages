#!/bin/bash

ORIGINALPWD="$PWD"

cd ../

chmod +x DaggerfallUnity.x86_64

if [ ! -d DFUPDATED ]; then
    mkdir -p DFUPDATED/DAGGER
    LD_PRELOAD="" cp -rfv ./DF/DAGGER ./DFUPDATED
    LD_PRELOAD="" ln -rsf DF/DFCD/DAGGER/ARENA2/*.VID DFUPDATED/DAGGER/ARENA2
fi

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    LD_PRELOAD="" echo "Automatically detected runtimepath at $runtimepath"
else
    echo "Steam Linux Runtime is not installed. Please ensure that it is installed and try again." > last_error.txt
    exit 10
fi

if [ ! -f ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity/settings.ini ]; then
    if [ ! -d ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity ]; then
        LD_PRELOAD="" mkdir -p ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity
    fi
    LD_PRELOAD="" echo "No settings.ini file detected, so creating"

    LD_PRELOAD="" echo -e "[Daggerfall]" >> ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity/settings.ini
    LD_PRELOAD="" echo -e "MyDaggerfallPath = ./DFUPDATED/DAGGER" >> ~/.config/unity3d/Daggerfall\ Workshop/Daggerfall\ Unity/settings.ini
fi

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- ./DaggerfallUnity.x86_64
