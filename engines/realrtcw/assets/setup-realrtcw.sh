#!/bin/bash

if [[ ! -z "${DEPPATH_9010}" ]]; then
    echo "Automatic path for rtcw found at $DEPPATH_9010"
    RTCW_PATH="$DEPPATH_9010"
else
    "$STEAM_ZENITY" --info --text="Browse to Return to Castle Wolfenstein installation" --title="Information"
    RTCW_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Return to Castle Wolfenstein installation" --directory)
fi

if [ -z "$RTCW_PATH" ]; then
    "$STEAM_ZENITY" --error --title="RealRTCW Setup Error" --text="Path to RTCW not given"
    exit 1
fi

if [ ! -d ./nosteam/"!copy the content of this folder into rtcw root directory" ]; then
    "$STEAM_ZENITY" --error --title="RealRTCW Setup Error" --text="Game content not downloaded from ModDB and extracted to nosteam directory."
    exit 1
fi

mv ./nosteam/"!copy the content of this folder into rtcw root directory"/Main/* ./nosteam/Main
ln -rsf "$RTCW_PATH/Main"/*.pk3 ./nosteam/Main
