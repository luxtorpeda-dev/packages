#!/bin/bash


if [ ! -f "sdkpath.txt" ]; then
    "$STEAM_ZENITY" --info --text="Browse to Source SDK Base 2013 Singleplayer Installation" --title="Information"
    HL_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Source SDK Base 2013 Singleplayer Installation" --directory)

    if [ -z "$HL_PATH" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Source SDK Base 2013 Singleplayer not given"
        exit 1
    fi

    if [ ! -d "$HL_PATH/sdktools" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Source SDK Base 2013 Singleplayer incorrect"
        exit 1
    fi
    
    echo "$HL_PATH" >> sdkpath.txt
    
    pushd "metastasis"
        # from https://steamcommunity.com/sharedfiles/filedetails/?id=754991349&insideModal=0
        find ./ | sort -r | sed 's/\(.*\/\)\(.*\)/mv "\1\2" "\1\L\2"/' |sh
    popd
fi

if [ ! -f "hlpath.txt" ]; then
    "$STEAM_ZENITY" --info --text="Browse to Half Life 2 Installation" --title="Information"
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
    
    pushd "metastasis"
        mkdir bin
        ln -rsf "$EPISODE_PATH/episodic/bin/client.so" bin/client.so
        ln -rsf "$EPISODE_PATH/episodic/bin/server.so" bin/server.so
    popd
fi

pushd "metastasis"
    cp -rfv ../shorewave003a.vmt materials/test/shorewave003a.vmt
    cp -rfv ../gameinfo.txt gameinfo.txt
popd

sdkpath=`cat sdkpath.txt`

"$sdkpath"/hl2.sh -game "$PWD/metastasis" -steam
