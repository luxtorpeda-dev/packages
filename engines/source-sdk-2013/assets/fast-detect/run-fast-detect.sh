#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [ ! -f "sdkpath.txt" ]; then
    if [[ ! -z "${DEPPATH_243730}" ]]; then
        echo "Automatic path for sdk found at $DEPPATH_243730"
        HL_PATH="$DEPPATH_243730"
    else
        "$STEAM_ZENITY" --info --text="Browse to Source SDK Base 2013 Singleplayer Installation" --title="Information"
        HL_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Source SDK Base 2013 Singleplayer Installation" --directory)

        if [ -z "$HL_PATH" ]; then
            error_message="Path to Source SDK 2013 not given."
            if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
                "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
            else
                echo "$error_message" > last_error.txt
            fi
            exit 10
        fi

        if [ ! -d "$HL_PATH/sdktools" ]; then
            error_message="Path to Source SDK 2013 incorrect."
            if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
                "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
            else
                echo "$error_message" > last_error.txt
            fi
            exit 10
        fi
    fi
    
    echo "$HL_PATH" >> sdkpath.txt
    
    pushd "FastDetect"
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
            error_message="Path to Steam Linux Runtime not given."
            if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
                "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
            else
                echo "$error_message" > last_error.txt
            fi
            exit 10
        fi

        if [ ! -f "$RUNTIME_PATH/scout-on-soldier-entry-point-v2" ]; then
            error_message="Path to Steam Linux Runtime incorrect."
            if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
                "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
            else
                echo "$error_message" > last_error.txt
            fi
            exit 10
        fi
    fi

    echo "$RUNTIME_PATH" >> runtimepath.txt
fi

if [[ ! -z "${DEPPATH_243730}" ]]; then
    sdkpath="$DEPPATH_243730"
    echo "Automatically detected sdkpath at $sdkpath"
else
    sdkpath=$(cat sdkpath.txt)
fi

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    echo "Automatically detected runtimepath at $runtimepath"
else
    runtimepath=$(cat runtimepath.txt)
fi

pushd "FastDetect"
    LD_PRELOAD="" mkdir bin
    LD_PRELOAD="" ln -rsf "$sdkpath/sourcetest/bin/client.so" bin/client.so
    LD_PRELOAD="" ln -rsf "$sdkpath/sourcetest/bin/server.so" bin/server.so
popd

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- "$sdkpath"/hl2.sh -game "$PWD/FastDetect" -steam
