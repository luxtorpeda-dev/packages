#!/bin/bash

RTCW_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Return to Castle Wolfenstein installation" --directory)

if [ -z "$RTCW_PATH" ]; then
    "$STEAM_ZENITY" --error --title="RealRTCW Setup Error" --text="Path to RTCW not given"
    exit 1
fi

ln -rsf "$RTCW_PATH/Main"/*.pk3 ./Main
