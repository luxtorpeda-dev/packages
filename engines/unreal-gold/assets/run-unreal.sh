#!/bin/bash

if [ ! -f ./UnrealLinux.bin ] 
then
    if [ ! -f ./UnrealGoldPatch227i.7z ] 
    then
        "$STEAM_ZENITY" --error --text="UnrealGoldPatch227i.7z must be manually downloaded to System directory. Please see System/README.txt for instructions in game directory."
        exit 1
    fi
    LD_LIBRARY_PATH=.7z ./7z/7z x -o"./" ./UnrealGoldPatch227i.7z
    wine UnrealGoldPatch227i.exe
    if [ ! -f ./UnrealLinux.bin ] 
    then
        "$STEAM_ZENITY" --error --text="Wine-based installation failed. Please see System/README.txt for instructions in game directory."
        exit 1
    fi
fi

chmod +x ./UnrealLinux.bin
cp -rfv libSDL-1.2.so.0 ./libs
LD_LIBRARY_PATH="./libs" LD_PRELOAD="" ./UnrealLinux.bin -log
