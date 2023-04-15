#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
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

if [[ ! -z "${DEPPATH_1070560}" ]]; then
    runtimepath="$DEPPATH_1070560"
    echo "Automatically detected runtimepath at $runtimepath"
else
    runtimepath=$(cat runtimepath.txt)
fi

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

if [ -f ~/.ut2004/System/User.ini ]; then
    echo "detected user user.ini"

    sed -i "s/InputClass=Class'foxWSFix.foxPlayerInput'/InputClass=Class'Engine.PlayerInput'/" ~/.ut2004/System/User.ini

    if grep -Fxq "InputClass=Class'foxWSFix.foxPlayerInput'" ~/.ut2004/System/User.ini
    then
        echo "foxWSFix found"
        sed -i "/InputClass=Class'foxWSFix.foxPlayerInput'/d" ~/.ut2004/System/User.ini
    fi
fi

cd linuxdata-standard-no-sdlcompat/System
rm libSDL-1.2.so
rm libSDL-1.2.so.0

ln -rsf "$runtimepath/var/steam-runtime/usr/lib/x86_64-linux-gnu/libSDL-1.2.so.0" ./libSDL-1.2.so.0

"$runtimepath/scout-on-soldier-entry-point-v2" --verbose -- ./ut2004-bin-linux-amd64
