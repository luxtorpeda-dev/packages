#!/bin/bash

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.config/dhewm3/base/dhewm.cfg ]; then
        if [ ! -d ~/.config/dhewm3/base ]; then
            mkdir -p ~/.config/dhewm3/base
        fi

        echo -e "seta r_fullscreen \"1\"" >> ~/.config/dhewm3/base/dhewm.cfg
        echo -e "seta r_mode \"-1\"" >> ~/.config/dhewm3/base/dhewm.cfg
        echo -e "seta r_customHeight \"800\"" >> ~/.config/dhewm3/base/dhewm.cfg
        echo -e "seta r_customWidth \"1280\"" >> ~/.config/dhewm3/base/dhewm.cfg
    fi

    if [ ! -f ~/.config/dhewm3/d3xp/dhewm.cfg ]; then
        if [ ! -d ~/.config/dhewm3/d3xp ]; then
            mkdir -p ~/.config/dhewm3/d3xp
        fi

        echo -e "seta r_fullscreen \"1\"" >> ~/.config/dhewm3/d3xp/dhewm.cfg
        echo -e "seta r_mode \"-1\"" >> ~/.config/dhewm3/d3xp/dhewm.cfg
        echo -e "seta r_customHeight \"800\"" >> ~/.config/dhewm3/d3xp/dhewm.cfg
        echo -e "seta r_customWidth \"1280\"" >> ~/.config/dhewm3/d3xp/dhewm.cfg
    fi
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if ! [[ -z "${LUX_STEAM_CLOUD}" ]]; then
    ./dhewm3 +set fs_savepath "$DIR" "$@"
else
    ./dhewm3 "$@"
fi
