#!/bin/bash

if [ ! -f full/etqw-rthread ]; then
    error_message="Retail version not in correct location."
    if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
        "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
    else
        echo "$error_message" > last_error.txt
    fi
    exit 10
fi

cd ./full
cp -rfv ../libSDL-1.2.so.0 ./libSDL-1.2.id.so.0
./etqw-rthread
