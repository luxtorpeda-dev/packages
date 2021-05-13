#!/bin/bash

"$STEAM_ZENITY" --info --text="Browse to Half Life installation" --title="Information"
HL_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Half Life installation" --directory)

if [ -z "$HL_PATH" ]; then
    "$STEAM_ZENITY" --error --title="Absolute Zero Setup Error" --text="Path to Half Life not given"
    exit 1
fi

if [ ! -d "$HL_PATH/valve" ]; then
    "$STEAM_ZENITY" --error --title="Absolute Zero Setup Error" --text="Path to Half Life incorrect"
    exit 1
fi

cp -rfv "$HL_PATH/valve" ./
cp -rfv "$HL_PATH/valve/cl_dlls/client.so" ./AbsoluteZero/cl_dlls
