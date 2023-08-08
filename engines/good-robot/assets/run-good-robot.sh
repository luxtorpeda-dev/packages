#!/bin/bash

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.config/Pyrodactyl/Good\ Robot/settings.ini ]; then
        if [ ! -d ~/.config/Pyrodactyl/Good\ Robot ]; then
            mkdir -p ~/.config/Pyrodactyl/Good\ Robot
        fi
        echo -e "[settings]" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "fullscreen=1" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "setup=1" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "[window]" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "height=800" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
        echo -e "width=1280" >> ~/.config/Pyrodactyl/Good\ Robot/settings.ini
    fi
fi

if ! [[ -z "${LUX_STEAM_CLOUD}" ]]; then
    engine_save_dir="$HOME/.config/Pyrodactyl/Good Robot"
    cloud_save_dir="$PWD/save"
    cloud_transfer_run_file="$PWD/luxsteamcloud"

    if [ ! -f "${cloud_transfer_run_file}" ]; then
        echo "$engine_save_dir"
        if [ ! -d "${engine_save_dir}" ]; then
            mkdir -p "$engine_save_dir"
        fi

        if [ -d "${cloud_save_dir}" ]; then
            mkdir -p "$cloud_save_dir"
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

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./good_robot
