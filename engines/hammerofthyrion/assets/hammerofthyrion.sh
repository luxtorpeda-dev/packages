#!/bin/bash

ln -rsf ./data1/PROGS.DAT ./data1/progs.dat
ln -rsf ./data1/PROGS2.DAT ./data1/progs2.dat
ln -rsf ./data1/Strings.txt ./data1/strings.txt
ln -rsf ./data1/Hexen.rc ./data1/hexen.rc
ln -rsf ./data1/Config.cfg ./data1/config.cfg
ln -rsf ./data1/Autoexec.cfg ./data1/autoexec.cfg

if ! [[ -z "${LUX_STEAM_CLOUD}" ]]; then
    engine_config_dir="$HOME/.hexen2"
    engine_save_dir="$engine_config_dir/data1"
    cloud_save_dir="$PWD/data1"
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

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./lib" ./glhexen2 -f "$@"
