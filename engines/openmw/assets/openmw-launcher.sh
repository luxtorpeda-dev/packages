#!/bin/bash

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

set -e

if [ ! -f Morrowind.ini ]; then
    if [ ! -f morrowind.ini ]; then
        "$STEAM_ZENITY" --error --text="No morrowind ini file not found"
    else
        ln -rsf morrowind.ini Morrowind.ini
    fi
fi

if [ ! -d vfs ]; then
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/mygui ./mygui
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/shaders ./shaders
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/vfs ./vfs
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/defaultfilters ./defaultfilters
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/version ./version
fi

LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH QT_QPA_PLATFORM_PLUGIN_PATH=./plugins ./openmw-launcher --data-local "Data Files" "$@"
