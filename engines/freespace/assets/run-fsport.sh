#!/bin/bash

if [[ ! -z "${DEPPATH_273620}" ]]; then
    echo "Automatic path for freespace 2 found at $DEPPATH_273620"

    if [ ! -f "$DEPPATH_273620/fs2_open_x64" ]; then
        "$STEAM_ZENITY" --error --title="Error" --text="Freespace 2 not found or not launched."
        exit 1
    fi
else
    "$STEAM_ZENITY" --error --title="Error" --text="Freespace 2 path not found."
    exit 1
fi


if [ ! -d "$DEPPATH_273620/fsport" ]; then
    7z
fi

