#!/bin/bash

ORIGINALPWD="$PWD"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

if [ -f "../last_error.txt" ]; then
    rm ../last_error.txt
fi

set -e

if [ ! -f ../Morrowind.ini ]; then
    if [ ! -f ../morrowind.ini ]; then
        error_message="No morrowind ini file not found."
        echo "$error_message" > ../last_error.txt
        exit 10
    else
        ln -rsf ../morrowind.ini ../Morrowind.ini
    fi
fi

if [ -f openmw.cfg ]; then
    error_message="openmw.cfg found in game directory. New version expects openmw.cfg in ~/.config/openmw. Move or remove the openmw.cfg file inside the game directory to proceed."
    echo "$error_message" > ../last_error.txt
    exit 10
fi

if [ ! -f ~/.config/openmw/openmw.cfg ]; then
    if [ ! -d ~/.config/openmw ]; then
        mkdir -p ~/.config/openmw
    fi
    echo "No openmw.cfg file detected, so creating and adding resources"
    echo -e "resources=\"share/games/openmw/resources\"\n" > ~/.config/openmw/openmw.cfg
    echo "Now running iniimporter"
    ./openmw-iniimporter ../Morrowind.ini ~/.config/openmw/openmw.cfg
    echo "Now adding data path"
    echo -e "data=\"$ORIGINALPWD/Data Files\"" >> ~/.config/openmw/openmw.cfg
    echo -e "fallback-archive=Morrowind.bsa" >> ~/.config/openmw/openmw.cfg
    echo -e "fallback-archive=Tribunal.bsa" >> ~/.config/openmw/openmw.cfg
    echo -e "fallback-archive=Bloodmoon.bsa" >> ~/.config/openmw/openmw.cfg
    echo -e "content=Morrowind.esm" >> ~/.config/openmw/openmw.cfg
    echo -e "content=Tribunal.esm" >> ~/.config/openmw/openmw.cfg
    echo -e "content=Bloodmoon.esm" >> ~/.config/openmw/openmw.cfg
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

LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH ./openmw-launcher --data-local "../Data Files" "$@"
