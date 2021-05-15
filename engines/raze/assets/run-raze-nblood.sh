#!/bin/bash

gamearg="$1"

if [ -z $1 ]; then
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp BLOOD.RFF
elif [ "$gamearg" = "-addon" ]; then
    ln -rsf "addons/Cryptic Passage/tiles007.ART" "addons/Cryptic Passage/TILES007.ART"
    ln -rsf "addons/Cryptic Passage/tiles015.ART" "addons/Cryptic Passage/TILES015.ART"
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -con "addons/Cryptic Passage/CRYPTIC.INI" -gamegrp BLOOD.RFF -j "addons/Cryptic Passage"
else
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./raze -gamegrp BLOOD.RFF
fi
