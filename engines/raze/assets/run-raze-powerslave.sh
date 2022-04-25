#!/bin/bash

gamearg="$1"

if [ ! -f ~/.config/raze/raze.ini ]; then
    if [ ! -d ~/.config/raze ]; then
        mkdir -p ~/.config/raze
    fi
    cp -rfv ./raze_template.ini ~/.config/raze/raze.ini
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp PWRSLAVE/STUFF.DAT
