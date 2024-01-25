#!/bin/bash

export SteamDeck=""
unset SteamDeck

if [ ! -f ~/.config/gzdoom/gzdoom.ini ]; then
    if [ ! -d ~/.config/gzdoom ]; then
        mkdir -p ~/.config/gzdoom
    fi
    cp -rfv ./gzdoom_template.ini ~/.config/gzdoom/gzdoom.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./gzdoom "$@"
