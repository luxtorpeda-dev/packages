#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

if ! [[ -d "../iso_data" ]]; then
    iso_find=$(find ../ -type f -name "*.iso")
    if ! [ -z "$iso_find" ]; then
        echo "Found iso - $iso_find"

        LD_PRELOAD="" ./xorriso -osirrox on -indev "$iso_find" -extract / ../iso_data
        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../iso_data --recursive
    fi
fi

if [[ -d "../Original" ]]; then
    echo "Assuming original path for scummvm"
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../Original --recursive
else
    if [[ $DIR == *"ScummVM_Windows"* ]]; then
        echo "Running parent path"
        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../../ --recursive
    else
        echo "Running normal path"
        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../ --recursive
    fi

fi


LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --fullscreen --gfx-mode=opengl --themepath=./share/scummvm
