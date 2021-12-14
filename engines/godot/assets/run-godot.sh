#!/bin/bash

# Find the package file
pckfile=$(find . -name \*.pck)

# Check if pck file exists and launch game if it does.
if [ -n "$pckfile" ]; then
    echo "Launching .pck file from $pckfile"
    ./godot.x11.tools.64 --fullscreen --main-pack "$pckfile"
else
    "$STEAM_ZENITY" --error --title="Error" --text="Couldn't find .pck file"
fi
