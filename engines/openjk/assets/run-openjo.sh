#!/bin/bash

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.local/share/openjo/base/openjo_sp.cfg ]; then
        if [ ! -d ~/.local/share/openjo/base ]; then
            mkdir -p ~/.local/share/openjo/base
        fi

        echo -e "seta r_fullscreen \"1\"" >> ~/.local/share/openjo/base/openjo_sp.cfg
        echo -e "seta r_mode \"-1\"" >> ~/.local/share/openjo/base/openjo_sp.cfg
        echo -e "seta r_customHeight \"800\"" >> ~/.local/share/openjo/base/openjo_sp.cfg
        echo -e "seta r_customWidth \"1280\"" >> ~/.local/share/openjo/base/openjo_sp.cfg
    fi
fi

./openjo_sp.x86_64 "$@"
