#!/bin/bash

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

if [ ! -d ~/.config/openmw ]; then
    mkdir -p ~/.config/openmw
fi

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.config/openmw/settings.cfg ]; then
        echo -e "[Video]" >> ~/.config/openmw/settings.cfg
        echo -e "fullscreen = true" >> ~/.config/openmw/settings.cfg
        echo -e "resolution x = 1280" >> ~/.config/openmw/settings.cfg
        echo -e "resolution y = 800" >> ~/.config/openmw/settings.cfg
    fi
fi

cd openmw-0.48.0-Linux-64Bit

if [ ! -d ./shaders-bkup ]; then
    LD_PRELOAD="" cp -rfv ./resources/shaders ./shaders-bkup
fi

mkdir -p ~/.config/openmw/share/games/openmw
ln -rsf ./resources ~/.config/openmw/share/games/openmw
ln -rsf ./resources ~/.config/openmw/resources
ln -rsf ../Morrowind.ini ./Morrowind.ini
ln -rsf ../"Data Files" ./

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

ln -rsf ../lib/* ./lib
export LD_LIBRARY_PATH=lib
./openmw-launcher.x86_64 --data-local "./Data Files" "$@"
