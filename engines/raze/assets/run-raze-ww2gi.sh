#!/bin/bash

if [ ! -f ~/.config/raze/raze.ini ]; then
    if [ ! -d ~/.config/raze ]; then
        mkdir -p ~/.config/raze
    fi
    cp -rfv ./raze_template.ini ~/.config/raze/raze.ini
fi

cd ../
LD_LIBRARY_PATH="./dosbox_windows/lib:$LD_LIBRARY_PATH" ./dosbox_windows/raze -gamegrp WW2GI/WW2GI.GRP
