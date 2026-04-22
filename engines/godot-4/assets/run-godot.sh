#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

pckfile=$(find . -name \*.pck)

# Check if pck file exists and launch game if it does.
if [ -n "$pckfile" ]; then
    echo "Launching .pck file from $pckfile"
    ./godot.linuxbsd.template_release.x86_64 --main-pack "$pckfile" $@
else
    error_message="Couldn't find a .pck file."
    echo "$error_message" > last_error.txt
    exit 10
fi
