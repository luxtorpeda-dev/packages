#!/bin/bash

gamearg="$1"

if [ -d "base" ]; then
    echo "gamearg $gamearg"

    cp -rfv ./ecwolf ./base
    cp -rfv ./ecwolf.pk3 ./base
    cd base

    if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
        if [ ! -f ecwolf.cfg ]; then
            echo -e "Vid_FullScreen = 1;" >> ecwolf.cfg
            echo -e "FullScreenWidth = 1280;" >> ecwolf.cfg
            echo -e "FullScreenHeight = 800;" >> ecwolf.cfg
        fi
    fi

    if [ "$gamearg" = "base\\M1-SOD.exe" ]; then
        ./ecwolf --config ecwolf.cfg --data SOD
    elif [ "$gamearg" = "base\\M2-SOD.exe" ]; then
        ./ecwolf --config ecwolf.cfg --data SD2
    elif [ "$gamearg" = "base\\M3-SOD.exe" ]; then
        ./ecwolf --config ecwolf.cfg --data SD3
    else
        ./ecwolf --config ecwolf.cfg
    fi
    
else
    if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
        if [ ! -f ecwolf.cfg ]; then
            echo -e "Vid_FullScreen = 1;" >> ecwolf.cfg
            echo -e "FullScreenWidth = 1280;" >> ecwolf.cfg
            echo -e "FullScreenHeight = 800;" >> ecwolf.cfg
        fi
    fi
    ./ecwolf --config ecwolf.cfg
fi

