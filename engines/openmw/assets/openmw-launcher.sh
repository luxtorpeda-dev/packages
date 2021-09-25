#!/bin/bash

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

set -e

if [ ! -f "openmw.cfg" ]; then
    cp openmw-template.cfg openmw.cfg
fi

if [ ! -f Morrowind.ini ]; then
    if [ ! -f morrowind.ini ]; then
        "$STEAM_ZENITY" --error --text="No morrowind ini file not found"
    else
        ln -rsf morrowind.ini Morrowind.ini
    fi
fi

./openmw-iniimporter Morrowind.ini openmw.cfg

LD_LIBRARY_PATH=./lib:$LD_LIBRARY_PATH QT_QPA_PLATFORM_PLUGIN_PATH=./plugins ./openmw-launcher --data-local "Data Files" "$@"
