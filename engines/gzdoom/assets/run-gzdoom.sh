#!/bin/bash

export SteamDeck=""
unset SteamDeck

if [ ! -f ~/.config/uzdoom/uzdoom.ini ]; then
    if [ ! -d ~/.config/uzdoom ]; then
        mkdir -p ~/.config/uzdoom
    fi
    cp -rfv ./gzdoom_template.ini ~/.config/uzdoom/uzdoom.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./gzdoom "$@" +vid_backend 1
