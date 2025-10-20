#!/bin/bash

export SteamDeck=""
unset SteamDeck

if [ ! -f doom_complete.pk3 ]; then
    cd wadsmoosh-branch-default
    cp -rfv ../wadsmoosh.py ./

    cp -rfv ../base/master/wads/*.WAD "source_wads/"
    cp -rfv ../base/*.WAD "source_wads/"
    python3.9 wadsmoosh.py
    cp -rfv ./doom_complete.pk3 ../

    cd ../
fi

if [ ! -f ~/.config/uzdoom/uzdoom.ini ]; then
    if [ ! -d ~/.config/uzdoom ]; then
        mkdir -p ~/.config/uzdoom
    fi
    cp -rfv ./gzdoom_template.ini ~/.config/uzdoom/uzdoom.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./gzdoom "$@" +vid_backend 1
