#!/bin/bash

if [ ! -f ~/.config/raze/raze.ini ]; then
    if [ ! -d ~/.config/raze ]; then
        mkdir -p ~/.config/raze
    fi
    cp -rfv ./raze_template.ini ~/.config/raze/raze.ini
fi

gamearg="$1"

if [ -z $1 ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp gameroot/SW.GRP
elif [ "$gamearg" = "-addon1" ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp gameroot/addons/WT.GRP
elif [ "$gamearg" = "-addon2" ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp gameroot/addons/TD.grp
fi
