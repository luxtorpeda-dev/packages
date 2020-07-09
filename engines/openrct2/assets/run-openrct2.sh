#!/bin/bash

if [ ! -f overlay-disabled ]; then
    if zenity --question --text="The steam overlay needs to be disabled for this game. If the steam overlay has been disabled, click Yes to continue."; then
        touch overlay-disabled
    else
        exit 0
    fi
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./openrct2 set-rct2 .

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./openrct2
