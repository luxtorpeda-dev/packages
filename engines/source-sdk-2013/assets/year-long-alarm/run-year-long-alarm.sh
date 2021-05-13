#!/bin/bash


if [ ! -f "sdkpath.txt" ]; then
    "$STEAM_ZENITY" --info --text="Browse to Source SDK Base 2013 Singleplayer Installation" --title="Information"
    HL_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Source SDK Base 2013 Singleplayer Installation" --directory)

    if [ -z "$HL_PATH" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Source SDK 2013 not given"
        exit 1
    fi

    if [ ! -d "$HL_PATH/sdktools" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Source SDK 2013 incorrect"
        exit 1
    fi
    
    echo "$HL_PATH" >> sdkpath.txt
    
    pushd "yearlongalarm"
        find ./ | sort -r | sed 's/\(.*\/\)\(.*\)/mv "\1\2" "\1\L\2"/' |sh
    popd
fi

sdkpath=`cat sdkpath.txt`

pushd "yearlongalarm"
    cp -rfv ../gameinfo.txt gameinfo.txt
popd

"$sdkpath"/hl2.sh -game "$PWD/yearlongalarm" -steam
