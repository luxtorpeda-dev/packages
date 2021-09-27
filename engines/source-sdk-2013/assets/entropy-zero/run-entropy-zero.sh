#!/bin/bash


if [ ! -f "sdkpath.txt" ]; then
    "$STEAM_ZENITY" --info --text="Browse to Source SDK Base 2013 Singleplayer Installation" --title="Information"
    HL_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Source SDK Base 2013 Singleplayer Installation" --directory)

    if [ -z "$HL_PATH" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Half Life not given"
        exit 1
    fi

    if [ ! -d "$HL_PATH/sdktools" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Source SDK 2013 incorrect"
        exit 1
    fi
    
    echo "$HL_PATH" >> sdkpath.txt
    
    pushd "Entropy Zero/EntropyZero"
    # from z33ky script
    for d in sound materials resource; do
		LD_PRELOAD="" find "${d}/" -exec sh -eux -c "echo {} | grep -q '[A-Z]' && ln -vs \"\$(basename {})\" \"\$(echo {}|tr '[A-Z]' '[a-z]')\"" \;
	done
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

sdkpath=`cat sdkpath.txt`
runtimepath=`cat runtimepath.txt`

pushd "Entropy Zero/EntropyZero"
    LD_PRELOAD="" cp -rfv ../../weapon_manhacktoss.txt scripts/
popd

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- "$sdkpath"/hl2.sh -game "$PWD/Entropy Zero/EntropyZero" -steam
