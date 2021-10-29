#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [ ! -f ./UnrealLinux.bin ] 
then
    error_message="Unreal Linux not found. Please see System/README.txt for instructions in game directory."
    if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
        "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
    else
        echo "$error_message" > last_error.txt
    fi
    exit 10
fi

chmod +x ./UnrealLinux.bin
cp -rfv libSDL-1.2.so.0 ./libs
LD_LIBRARY_PATH="./libs" LD_PRELOAD="" ./UnrealLinux.bin -log
