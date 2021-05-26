#!/bin/bash

"$STEAM_ZENITY" --info --text="Browse to Return to Castle Wolfenstein installation" --title="Information"
RTCW_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Return to Castle Wolfenstein installation" --directory)

if [ -z "$RTCW_PATH" ]; then
    "$STEAM_ZENITY" --error --title="RealRTCW Setup Error" --text="Path to RTCW not given"
    exit 1
fi

mv ./nosteam/"!copy the content of this folder into rtcw root directory"/Main ./nosteam/Main
ln -rsf "$RTCW_PATH/Main"/*.pk3 ./nosteam/Main
