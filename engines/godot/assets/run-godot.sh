#!/bin/bash

# Find pck file
pckfile=$(find . -name \*.pck)

# Check if pck file exists and launch game if it does.
if [ -n "$pckfile" ]; then
    echo "Launching .pck file from $pckfile"
    ./godot.x11.tools.64 --fullscreen --main-pack "$pckfile"
else
    echo "Couldn't find .pck file"
fi
