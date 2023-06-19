#!/bin/bash

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

ln -rsf /lib/x86_64-linux-gnu/libbz2.so.1.0.4 ./lib/libbz2.so.1.0

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

if [ ! -f ~/.config/openmw/openmw.cfg ]; then
    if [ ! -d ~/.config/openmw ]; then
        mkdir -p ~/.config/openmw
    fi
    echo "No openmw.cfg file detected, so creating and adding resources"
    echo -e "resources=\"share/games/openmw/resources\"\n" > ~/.config/openmw/openmw.cfg
    echo "Now running iniimporter"
    ./openmw-iniimporter Morrowind.ini ~/.config/openmw/openmw.cfg
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
        echo -e "\nresources=\"share/games/openmw/resources\"" >> ~/.config/openmw/openmw.cfg
    fi
fi

if [ ! -d vfs ]; then
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/mygui ./mygui
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/shaders ./shaders
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/vfs ./vfs
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/defaultfilters ./defaultfilters
    LD_PRELOAD="" ln -rsf ./share/games/openmw/resources/version ./version
fi

./openmw --data-local "Data Files" "$@" 
