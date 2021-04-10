#!/bin/bash


if [ ! -f "sdkpath.txt" ]; then
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
    
    pushd "ResistanceElement"
        # from https://steamcommunity.com/sharedfiles/filedetails/?id=754991349&insideModal=0
        find ./ | sort -r | sed 's/\(.*\/\)\(.*\)/mv "\1\2" "\1\L\2"/' |sh
    popd
fi

if [ ! -f "hlpath.txt" ]; then
    EPISODE_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Half Life 2 Installation" --directory)

    if [ -z "EPISODE_PATH" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Half Life 2 not given"
        exit 1
    fi

    if [ ! -d "$EPISODE_PATH/episodic" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Half Life 2 incorrect"
        exit 1
    fi
    
    echo "$EPISODE_PATH" >> hlpath.txt
    
    pushd "ResistanceElement"
        mkdir bin
        ln -rsf "$EPISODE_PATH/episodic/bin/client.so" bin/client.so
        ln -rsf "$EPISODE_PATH/episodic/bin/server.so" bin/server.so
    popd
fi

sdkpath=`cat sdkpath.txt`

"$sdkpath"/hl2.sh -game "$PWD/ResistanceElement" -steam
