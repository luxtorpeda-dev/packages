#!/bin/bash

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.local/share/openjk/base/openjk_sp.cfg ]; then
        if [ ! -d ~/.local/share/openjk/base ]; then
            mkdir -p ~/.local/share/openjk/base
        fi

        echo -e "seta r_fullscreen \"1\"" >> ~/.local/share/openjk/base/openjk_sp.cfg
        echo -e "seta r_mode \"-1\"" >> ~/.local/share/openjk/base/openjk_sp.cfg
        echo -e "seta r_customHeight \"800\"" >> ~/.local/share/openjk/base/openjk_sp.cfg
        echo -e "seta r_customWidth \"1280\"" >> ~/.local/share/openjk/base/openjk_sp.cfg
    fi
fi

if ! [[ -z "${LUX_STEAM_CLOUD}" ]]; then
    engine_config_dir="$HOME/.local/share/openjk/base"
    engine_save_dir="$engine_config_dir/saves"
    cloud_save_dir="$PWD/base/saves"
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

./openjk_sp.x86_64 "$@"
