#!/bin/bash

if [ ! -f demo/etqw-rthread ]; then
    "$STEAM_ZENITY" --error --title="Launch Error" --text="Demo version not in correct location."
    exit 1
fi

cd ./demo
cp -rfv ../libSDL-1.2.so.0 ./libSDL-1.2.id.so.0
./etqw-rthread
