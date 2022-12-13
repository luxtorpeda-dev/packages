#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [ ! -f ../System64/UnrealLinux.bin ]
then
    error_message="Unreal Linux (64-bit) not found. Please see System/README.txt for instructions in game directory."
    if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
        "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
    else
        echo "$error_message" > last_error.txt
    fi
    exit 10
fi

chmod +x ../System64/UnrealLinux.bin
cd ../System64
mkdir -p libs
tar -xvf ../Help/convenience_libs.tar.bz2
cp -rfv libSDL-1.2.so.0 ./libs
cp -rfv convenience_libs/System64/* ./libs
LD_LIBRARY_PATH="./libs" LD_PRELOAD="" ./UnrealLinux.bin -log
