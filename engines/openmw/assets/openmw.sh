#!/bin/bash

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

export SteamDeck=""
unset SteamDeck

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

set -e

if [ ! -f Morrowind.ini ]; then
    if [ ! -f morrowind.ini ]; then
        error_message="No morrowind ini file not found."
        echo "$error_message" > last_error.txt
        exit 10
    else
        ln -rsf morrowind.ini Morrowind.ini
    fi
fi

cd openmw-0.49.0-Linux-64Bit

if [ ! -f ~/.config/openmw/openmw.cfg ]; then
    if [ ! -d ~/.config/openmw ]; then
        mkdir -p ~/.config/openmw
    fi
    echo "No openmw.cfg file detected, so creating and adding resources"
    echo -e "resources=\"share/games/openmw/resources\"\n" > ~/.config/openmw/openmw.cfg
    echo "Now running iniimporter"
    ./openmw-iniimporter ../Morrowind.ini ~/.config/openmw/openmw.cfg
    echo "Now adding data path"
    echo -e "data=\"$PWD/Data Files\"" >> ~/.config/openmw/openmw.cfg
    echo -e "fallback-archive=Morrowind.bsa" >> ~/.config/openmw/openmw.cfg
    echo -e "fallback-archive=Tribunal.bsa" >> ~/.config/openmw/openmw.cfg
    echo -e "fallback-archive=Bloodmoon.bsa" >> ~/.config/openmw/openmw.cfg
    echo -e "content=Morrowind.esm" >> ~/.config/openmw/openmw.cfg
    echo -e "content=Tribunal.esm" >> ~/.config/openmw/openmw.cfg
    echo -e "content=Bloodmoon.esm" >> ~/.config/openmw/openmw.cfg

    if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
        if [ ! -f ~/.config/openmw/settings.cfg ]; then
            echo -e "[Video]" >> ~/.config/openmw/settings.cfg
            echo -e "fullscreen = true" >> ~/.config/openmw/settings.cfg
            echo -e "resolution x = 1280" >> ~/.config/openmw/settings.cfg
            echo -e "resolution y = 800" >> ~/.config/openmw/settings.cfg
        fi
    fi
else
    echo "openmw.cfg file detected, so checking for resources"
    if grep -q resources ~/.config/openmw/openmw.cfg; then
        echo "resources line found"
    else
        echo "Adding resources line"
        echo -e "\nresources=\"resources\"" >> ~/.config/openmw/openmw.cfg
    fi
fi

mkdir -p ~/.config/openmw/share/games/openmw
ln -rsf ./resources ~/.config/openmw/share/games/openmw
ln -rsf ./resources ~/.config/openmw/resources
ln -rsf ../Morrowind.ini ./Morrowind.ini
ln -rsf ../"Data Files" ./

if [ ! -d ./shaders-bkup ]; then
    LD_PRELOAD="" cp -rfv ./resources/shaders ./shaders-bkup
fi

if [ "$1" == "withshaders" ]; then
    LD_PRELOAD="" echo "detected asking for shaders"

    LD_PRELOAD="" rm -rf ./newshaders
    LD_PRELOAD="" mkdir -p ./newshaders
    LD_PRELOAD="" cp -rfv ./shaders-bkup/* ./newshaders
    LD_PRELOAD="" cp -rfv ../openmw-shaders/* ./newshaders

    LD_PRELOAD="" rm -rf ./resources/shaders
    LD_PRELOAD="" ln -rsf ./newshaders ./resources/shaders
else
    LD_PRELOAD="" echo "detected not asking for shaders"
    LD_PRELOAD="" rm -rf ./resources/shaders
    LD_PRELOAD="" ln -rsf ./shaders-bkup ./resources/shaders
fi

./openmw.x86_64 --data-local "../Data Files" "$@"
