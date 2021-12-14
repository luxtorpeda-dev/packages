#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

pckfile=$(find . -name \*.pck)

# Check if pck file exists and launch game if it does.
if [ -n "$pckfile" ]; then
    echo "Launching .pck file from $pckfile"
    ./godot.x11.tools.64 --fullscreen --main-pack "$pckfile"
else
    error_message="Couldn't find a .pck file."

    if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
        "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
    else
        echo "$error_message" > last_error.txt
    fi
    exit 10
fi
