#!/bin/bash

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
cp -rfv ./Spirit/cl_dlls/client.so ./before/cl_dlls
cp -rfv ./Spirit/cl_dlls/spirit.so ./before/dlls
sed -i "s/gamedll \"dlls/spirit.dll\"/gamedll \"dlls/spirit.so\"/" before/liblist.gam
