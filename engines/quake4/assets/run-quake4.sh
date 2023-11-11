#!/bin/bash

cp -rfv ./libSDL-1.2.id.so.0 ./linuxdata/bin/Linux/x86_64

if ! [[ -z "${LUX_STEAM_CLOUD}" ]]; then
    engine_config_dir="$HOME/.quake4/q4base"
    engine_save_dir="$engine_config_dir/savegames"
    cloud_save_dir="$PWD/q4base/savegames"
    cloud_transfer_run_file="$PWD/luxsteamcloud"

    if [ ! -f "${cloud_transfer_run_file}" ]; then
        echo "$engine_save_dir"
        if [ ! -d "${engine_save_dir}" ]; then
            mkdir -p "$engine_save_dir"
        fi

        if [ -d "${engine_save_dir}" ]; then
            cp -rfv "$engine_save_dir"/* "$cloud_save_dir"
            mv "$engine_save_dir" "$engine_save_dir"-beforelux
        fi

        ln -s "$cloud_save_dir" "$engine_save_dir"
        touch "$cloud_transfer_run_file"
    fi

    mv "$engine_save_dir" "$engine_save_dir"-oldlink
    ln -s "$cloud_save_dir" "$engine_save_dir"
fi

cd linuxdata
LD_LIBRARY_PATH="./bin/Linux/x86_64" ./bin/Linux/x86_64/quake4smp.x86
