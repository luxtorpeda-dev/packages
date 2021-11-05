#!/bin/bash

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

set -e

if [ ! -f Morrowind.ini ]; then
    if [ ! -f morrowind.ini ]; then
        error_message="No morrowind ini file not found."
        if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
            "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
        else
            echo "$error_message" > last_error.txt
        fi
        exit 10
    else
        ln -rsf morrowind.ini Morrowind.ini
    fi
fi

if [ -f openmw.cfg ]; then
    error_message="openmw.cfg found in game directory. New version expects openmw.cfg in ~/.config/openmw. Move or remove the openmw.cfg file inside the game directory to proceed."
    if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
        "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
    else
        echo "$error_message" > last_error.txt
    fi
    exit 10
fi

if [ ! -d vfs ]; then
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/mygui ./mygui
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/shaders ./shaders
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/vfs ./vfs
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/defaultfilters ./defaultfilters
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/version ./version
fi

./openmw --data-local "Data Files" "$@" 
