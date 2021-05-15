#!/bin/bash

if [ ! -f full/etqw-rthread ]; then
    "$STEAM_ZENITY" --error --title="Launch Error" --text="Retail version not in correct location."
    exit 1
fi

cd ./full
./etqw-rthread
