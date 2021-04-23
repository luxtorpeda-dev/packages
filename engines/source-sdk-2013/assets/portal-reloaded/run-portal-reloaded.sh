#!/bin/bash


if [ ! -f "portalpath.txt" ]; then
    HL_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Portal 2 Installation" --directory)

    if [ -z "$HL_PATH" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Portal 2 not given"
        exit 1
    fi

    if [ ! -d "$HL_PATH/portal2" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Portal 2 incorrect"
        exit 1
    fi
    
    echo "$HL_PATH" >> portalpath.txt
    
    cp -rfv "$HL_PATH/portal2.sh" ./
    cp -rfv "$HL_PATH/portal2_linux" ./
    cp -rfv "$HL_PATH/bin" ./
fi

./portal2.sh -game portal2 -steam +r_hunkalloclightmaps 0 "$@"
