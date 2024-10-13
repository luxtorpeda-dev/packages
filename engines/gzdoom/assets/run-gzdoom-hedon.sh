#!/bin/bash

export SteamDeck=""
unset SteamDeck

if [ ! -f gzdoom.ini ]; then
    cp -rfv ./hedon_template.ini ./gzdoom.ini
fi

if ! [[ -z "${LUX_STEAM_CLOUD}" ]]; then
    cloud_transfer_run_file="$PWD/luxsteamcloud"

    if [ ! -f "${cloud_transfer_run_file}" ]; then
        cp -rfv ./saves/* Save
        mv ./saves ./saves-presteamcloud
        ln -rsf ./Save ./saves
    fi
fi

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./gzdoom "$@" +vid_backend 1
