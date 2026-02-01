#!/bin/bash

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.local/share/openjk/base/openjk.cfg ]; then
        if [ ! -d ~/.local/share/openjk/base ]; then
            mkdir -p ~/.local/share/openjk/base
        fi

        echo -e "seta r_fullscreen \"1\"" >> ~/.local/share/openjk/base/openjk.cfg
        echo -e "seta r_mode \"-1\"" >> ~/.local/share/openjk/base/openjk.cfg
        echo -e "seta r_customHeight \"800\"" >> ~/.local/share/openjk/base/openjk.cfg
        echo -e "seta r_customWidth \"1280\"" >> ~/.local/share/openjk/base/openjk.cfg
    fi
fi

./openjk.x86_64 "$@"
