#!/bin/bash

ORIGINALPWD="$PWD"

cd ../

chmod +x DaggerfallUnity.x86_64

if [ ! -d DFUPDATED ]; then
    mkdir -p DFUPDATED/DAGGER
    LD_PRELOAD="" cp -rfv ./DF/DAGGER ./DFUPDATED
    LD_PRELOAD="" ln -rsf DF/DFCD/DAGGER/ARENA2/*.VID DFUPDATED/DAGGER/ARENA2
    cp -rfv "$ORIGINALPWD/dag213.exe" ./DFUPDATED/DAGGER/dag213.exe
    cp -rfv "$ORIGINALPWD/dfpatch.bat" ./DFUPDATED/dfpatch.bat #built based on instructions from https://www.dfworkshop.net/using-steam-release-of-daggerfall-with-daggerfall-unity/

    "$STEAM_ZENITY" --info --title="Daggerfall Patch Setup" --text="dosbox-staging is used to update the game to the latest official patch. Follow the on-screen prompts and confirm each one. Once it is complete, dosbox-staging will close and the game will launch."

    pushd DFUPDATED
        LD_LIBRARY_PATH="$ORIGINALPWD/dosbox-staging/lib:$LD_LIBRARY_PATH" "$ORIGINALPWD/dosbox-staging/dosbox" ./dfpatch.bat -exit
    popd
fi

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    LD_PRELOAD="" echo "Automatically detected runtimepath at $runtimepath"
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
