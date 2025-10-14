#!/bin/bash

export SteamDeck=""
unset SteamDeck

if [ ! -f ~/.config/dzdoom/dzdoom.ini ]; then
    if [ ! -d ~/.config/dzdoom ]; then
        mkdir -p ~/.config/dzdoom
    fi
    cp -rfv ./dzdoom_template.ini ~/.config/dzdoom/dzdoom.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./dzdoom "$@" +vid_backend 1
