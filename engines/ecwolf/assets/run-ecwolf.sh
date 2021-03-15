#!/bin/bash

gamearg="$1"

if [ -d "base" ]; then
    echo "gamearg $gamearg"

    cp -rfv ./ecwolf ./base
    cp -rfv ./ecwolf.pk3 ./base
    cd base
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
    ./ecwolf --config ecwolf.cfg
fi

