#!/bin/bash

if [ ! -f full/etqw-rthread ]; then
    "$STEAM_ZENITY" --error --title="Launch Error" --text="Retail version not in correct location."
    exit 1
fi

cd ./full
cp -rfv ../libSDL-1.2.so.0 ./libSDL-1.2.id.so.0
./etqw-rthread
