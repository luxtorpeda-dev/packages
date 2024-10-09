#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

pckname="Public_Demo_2_v2"

# Check if pck file exists and launch game if it does.
if [ -n "$pckname.pck" ]; then
    ln -s "$pckname" godot.linuxbsd.template_release.x86_64
    "./$pckname" $@
    rm "$pckname"
else
    error_message="Couldn't find a .pck file."
    echo "$error_message" > last_error.txt
    exit 10
fi
