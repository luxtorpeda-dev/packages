#!/bin/bash

export SteamDeck=""
unset SteamDeck

if [ ! -f doom_complete.pk3 ]; then
    cd wadsmoosh-branch-default
    cp -rfv ../wadsmoosh.py ./

    cp -rfv ../masterbase/master/wads/*.WAD "source_wads/"
    cp -rfv ../base/*.WAD "source_wads/"
    python3.9 wadsmoosh.py
    cp -rfv ./doom_complete.pk3 ../

    cd ../
fi

if [ ! -f ~/.config/dzdoom/dzdoom.ini ]; then
    if [ ! -d ~/.config/dzdoom ]; then
        mkdir -p ~/.config/dzdoom
    fi
    cp -rfv ./dzdoom_template.ini ~/.config/dzdoom/dzdoom.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./dzdoom "$@" +vid_backend 1
