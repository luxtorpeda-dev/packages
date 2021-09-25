#!/bin/bash

if [ ! -f ./UnrealLinux.bin ] 
then
    "$STEAM_ZENITY" --error --text="Unreal Linux not found. Please see System/README.txt for instructions in game directory."
    exit 1
fi

chmod +x ./UnrealLinux.bin
cp -rfv libSDL-1.2.so.0 ./libs
LD_LIBRARY_PATH="./libs" LD_PRELOAD="" ./UnrealLinux.bin -log
