#!/bin/bash

if ! [[ -z "${LUX_STEAM_DECK}" ]]; then
    if [ ! -f ~/.wolf/Main/wolfconfig.cfg ]; then
        if [ ! -d ~/.wolf/Main ]; then
            mkdir -p ~/.wolf/Main
        fi

        echo -e "seta r_fullscreen \"1\"" >> ~/.wolf/Main/wolfconfig.cfg
        echo -e "seta r_mode \"-1\"" >> ~/.wolf/Main/wolfconfig.cfg
        echo -e "seta r_customHeight \"800\"" >> ~/.wolf/Main/wolfconfig.cfg
        echo -e "seta r_customWidth \"1280\"" >> ~/.wolf/Main/wolfconfig.cfg
    fi
fi

./iowolfsp.x86_64 "$@"
