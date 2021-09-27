#!/bin/bash


if [ ! -f "sdkpath.txt" ]; then
    if [[ ! -z "${DEPPATH_243730}" ]]; then
        echo "Automatic path for sdk found at $DEPPATH_243730"
        HL_PATH="$DEPPATH_243730"
    else
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
    fi
    
    echo "$HL_PATH" >> sdkpath.txt
    
    pushd "yearlongalarm"
        LD_PRELOAD="" find ./ | LD_PRELOAD="" sort -r | LD_PRELOAD="" sed 's/\(.*\/\)\(.*\)/mv "\1\2" "\1\L\2"/' |LD_PRELOAD="" sh
    popd
fi

if [ ! -f "runtimepath.txt" ]; then
    if [[ ! -z "${DEPPATH_1070560}" ]]; then
        echo "Automatic path for runtime found at $DEPPATH_1070560"
        RUNTIME_PATH="$DEPPATH_1070560"
    else
        "$STEAM_ZENITY" --info --text="Browse to Steam Linux Runtime Installation. You should see a scout-on-soldier-entry-point-v2 file in the proper directory." --title="Information"
        RUNTIME_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Steam Linux Runtime Installation." --directory)

        if [ -z "$RUNTIME_PATH" ]; then
            "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Steam Linux Runtime not given"
            exit 1
        fi

        if [ ! -f "$RUNTIME_PATH/scout-on-soldier-entry-point-v2" ]; then
            "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Steam Linux Runtime incorrect"
            exit 1
        fi
    fi

    echo "$RUNTIME_PATH" >> runtimepath.txt
fi

if [[ ! -z "${DEPPATH_243730}" ]]; then
    sdkpath="$DEPPATH_243730"
    echo "Automatically detected sdkpath at $sdkpath"
else
    sdkpath=`cat sdkpath.txt`
fi

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    echo "Automatically detected runtimepath at $runtimepath"
else
    runtimepath=`cat runtimepath.txt`
fi

pushd "yearlongalarm"
    LD_PRELOAD="" cp -rfv ../gameinfo.txt gameinfo.txt
popd

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- "$sdkpath"/hl2.sh -game "$PWD/yearlongalarm" -steam
