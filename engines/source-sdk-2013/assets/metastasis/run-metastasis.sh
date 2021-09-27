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
        LD_PRELOAD="" find ./ | LD_PRELOAD="" sort -r | LD_PRELOAD="" sed 's/\(.*\/\)\(.*\)/mv "\1\2" "\1\L\2"/' | LD_PRELOAD="" sh
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
        LD_PRELOAD="" mkdir bin
        LD_PRELOAD="" ln -rsf "$EPISODE_PATH/episodic/bin/client.so" bin/client.so
        LD_PRELOAD="" ln -rsf "$EPISODE_PATH/episodic/bin/server.so" bin/server.so
    popd
fi

if [ ! -f "runtimepath.txt" ]; then
    "$STEAM_ZENITY" --info --text="Browse to Steam Linux Runtime Installation. You should see a scout-on-soldier-entry-point-v2 file in the proper directory." --title="Information"
    RUNTIME_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Steam Linux Runtime Installation." --directory)

    if [ -z "$RUNTIME_PATH" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path Browse to Steam Linux Runtime not given"
        exit 1
    fi

    if [ ! -f "$RUNTIME_PATH/scout-on-soldier-entry-point-v2" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Steam Linux Runtime incorrect"
        exit 1
    fi

    echo "$RUNTIME_PATH" >> runtimepath.txt
fi

pushd "metastasis"
    LD_PRELOAD="" cp -rfv ../shorewave003a.vmt materials/test/shorewave003a.vmt
    LD_PRELOAD="" cp -rfv ../gameinfo.txt gameinfo.txt
popd

sdkpath=`cat sdkpath.txt`
runtimepath=`cat runtimepath.txt`

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- "$sdkpath"/hl2.sh -game "$PWD/metastasis" -steam
