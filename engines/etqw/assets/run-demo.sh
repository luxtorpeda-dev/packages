#!/bin/bash

if [ ! -f demo/etqw-rthread ]; then
    "$STEAM_ZENITY" --error --title="Launch Error" --text="Demo version not in correct location."
    exit 1
fi

cd ./demo
./etqw-rthread
